# This script is built to maintain the doc up to date.
# It can:
#   1. download and generate a markdown file about doc.
#   2. (not implemented) download assets locally

require 'multi_json'
require 'fileutils'
require 'optparse'
require 'yaml'
require 'uri'
require 'net/http'
require 'time'

class DocDownloader
  DISCOURSE_TOPIC_URL_REGEX = /(\/t\/\S+\/\d+)\/(\d+)/

  def initialize(download_assets: true, verbose: false, url:)
    @download_assets = download_assets
    @verbose = verbose
    @url = URI(url)
    @id = nil
    @json = nil
    @raw = nil
  end

  def url
    "#{@url.scheme}://#{@url.host}#{@url.path[0..-6]}"
  end

  def title
    @json['title']
  end

  def slug
    @json['slug']
  end

  def content
    @raw
  end

  def updated_at
    Time.parse first_post['updated_at']
  end

  def first_post
    @first_post ||= @json['post_stream']['posts'].first
  end

  def get_json
    process_url
    begin
      response = Net::HTTP.get(@url)
      @raw = Net::HTTP.get(URI("https://meta.discourse.org/raw/#{@id}"))
      @json = MultiJson.load(response)
    rescue
      p "Error parsing: ", response
      nil
    end
  end

  def process_url
    @url.query = 'include_raw=true'

    if @url.path =~ DISCOURSE_TOPIC_URL_REGEX
      @url.path = DISCOURSE_TOPIC_URL_REGEX.match(@url.path)[1]
    end
    @id = @url.path.gsub(/\/t\/\S+\/(\d+)/, '\1')
    @url.path += '.json'
  end
end

class DocSectionMaintainer
  EXPORT_FOLDER = 'export'

  def initialize(options = nil)
    @verbose = options[:verbose]
    @update = options[:update]
    @download_assets = options[:download_assets]
    @yamlfile = options[:yaml] || 'doc_list.yml'
    @yaml = YAML::load_file(File.join(__dir__, @yamlfile))
  end

  def create_folder(a, b = nil)
    dir = b ? "#{a}/#{b}" : "#{a}"
    puts "Creating folder: #{dir}"
    FileUtils.mkdir_p File.join(__dir__, EXPORT_FOLDER, '_en', dir)
  end

  def get_doc(section_name, subsection_name, url)
    downloader = DocDownloader.new(verbose: @verbose, url: url)
    downloader.get_json ? downloader : nil
  end

  def get_portal
    @yaml.each do |name, subsections|
      create_folder name
      get_subsection name, subsections
    end
  end

  def get_subsection(section_name, subsections)
    return unless subsections

    subsections.each do |name, urls|
      create_folder section_name, name
      get_docs section_name, name, urls
    end
  end

  def get_docs(section_name, subsection_name, urls)
    i = 1
    urls.each do |u|
      puts "Downloading url: [#{i}/#{urls.count}] #{u}"
      i += 1
      doc = get_doc section_name, subsection_name, u
      next unless doc
      filename = "#{section_name}/#{subsection_name}/#{doc.slug}.md"
      original_file_mtime = original_file_updated_at(filename)
      if original_file_mtime && original_file_mtime < doc.updated_at || # Doc updated
          original_file_mtime == nil || # never created
          !@update # force download all
        genertate_doc_file doc, filename, section_name, subsection_name
      else
        puts "                 [SKIPED] Original doc updated at: #{doc.updated_at} < #{original_file_mtime}"
      end
    end
  end

  def genertate_doc_file(doc, filename, section_name, subsection_name)
    content = "---
title: #{doc.title}
---

Source: #{doc.url}

#{doc.content}
"
    puts "   Creating doc: #{doc.title}", "                 #{filename}"
    puts content if @verbose
    File.write(File.join(__dir__, EXPORT_FOLDER, '_en', filename), content)
  end

  def original_file_updated_at(filename)
    begin
      File.open(File.join(__dir__, '..', '_en', filename)).mtime
    rescue
      nil
    end
  end

  def execute
    export_folder = File.join(__dir__, EXPORT_FOLDER)
    FileUtils.rm_rf export_folder
    FileUtils.mkdir_p export_folder
    FileUtils.mkdir_p File.join(export_folder, '_en')
    get_portal
  end

end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby tools/doc_section_maintainer.rb [options]"

  opts.on('-c', '--configuration NAME', 'YAML configuration file') { |v| options[:yaml] = v }
  opts.on('-u', '--update', "Only update newer documentation") { |v| options[:update] = true }
  opts.on('-v', '--verbose', 'Vebose mode') { |v| options[:verbose] = true }
end.parse!

$maintainer = DocSectionMaintainer.new(options)
$maintainer.execute
