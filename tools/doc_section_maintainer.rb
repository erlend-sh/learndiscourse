# This script is built to maintain the doc up to date.

require 'multi_json'
require 'forwardable'
require 'fileutils'
require 'optparse'
require 'yaml'
require 'uri'
require 'net/http'
require 'time'
require 'base64'

class DocDownloader
  extend Forwardable
  attr_accessor :weight, :strategy
  attr_reader :original_url, :extract_title, :title, :slug

  def_delegators :@strategy, :url, :content, :updated_at, :get_json

  def initialize(opts)
    @original_url = opts['url']
    @extract_title = opts['extract_title']
    @title = opts['title']
    @slug = opts['slug']
    @weight = opts['weight'] || 0
    @redirect_from = opts['redirect_from']
  end

  def title
    @title.nil? ? @strategy.title : @title
  end

  def slug
    @slug.nil? ? @strategy.slug : @slug
  end

  def additional_meta
    result = ['']
    result.push "weight: #{@weight}" unless @weight == 0
    result.push "redirect_from: #{@redirect_from}" if @redirect_from
    result.join("\n")
  end
end

class MetaDownloadStrategy
  DISCOURSE_TOPIC_URL_REGEX = /(\/t\/\S+\/\d+)\/(\d+)/

  def initialize(downloader)
    @url = URI(downloader.original_url)
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
      puts "Error parsing: ", response ? response[0..90] : ''
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

class GitHubDownloadStrategy
  DISCOURSE_TOPIC_URL_REGEX = /(\/t\/\S+\/\d+)\/(\d+)/
  attr_reader :content, :title

  def initialize(downloader)
    @downloader = downloader
    @original_url = downloader.original_url
    @json = nil
  end

  def url
    @original_url
  end

  def slug
    @slug ||= @json['name'][0..-4].downcase
  end

  def updated_at
    nil
  end

  def get_json
    process_url
    begin
      request = Net::HTTP::Get.new(@url)
      request['Content-Type'] = 'application/vnd.github.v3+json'
      http = Net::HTTP.new(@url.host, @url.port)
      http.use_ssl = true
      response = http.request(request).body
      @json = MultiJson.load(response)
    rescue
      puts "Error parsing: ", response ? response[0..90] : ''
      nil
    end
    post_process
  end

  def post_process
    text = Base64::decode64(@json['content'])
    if @downloader.extract_title.nil? && @downloader.extract_title != false
      lines = text.lines.to_a
      @content = lines[2..-1].join
      @title = lines[0].gsub(/#\s+(.+)\n/, '\1')
    else
      @content = text
      @title = slug.gsub('-', ' ').capitalize
    end
  end

  def process_url
    repo, _, file_path = @original_url.partition(/github\.com\//).last.partition(/\/blob\/master\//)
    @url = URI("https://api.github.com/repos/#{repo}/contents/#{file_path}")
  end
end

class DocSectionMaintainer
  EXPORT_FOLDER = 'export'

  def initialize(options = nil)
    @verbose = options[:verbose]
    @update = options[:update]
    @yamlfile = options[:yaml] || 'doc_list.yml'
    @yaml = YAML::load_file(File.join(__dir__, @yamlfile))
  end

  def create_portal_page(name)
    template = """---
layout: default
section: #{name}
---

{% include doclist.html %}
"""
    File.write(File.join(__dir__, EXPORT_FOLDER, '_en', name, "#{name}.html"), template)
  end

  def create_folder(a, b = nil)
    dir = b ? "#{a}/#{b}" : "#{a}"
    puts "Creating folder: #{dir}"
    FileUtils.mkdir_p File.join(__dir__, EXPORT_FOLDER, '_en', dir)
  end

  def get_doc(section_name, subsection_name, opts)
    downloader = DocDownloader.new(opts.merge({ 'verbose' => @verbose }))
    uri = URI(opts['url'])
    downloader.strategy = if uri.host.index('meta.discourse.org')
                            MetaDownloadStrategy.new(downloader)
                          elsif uri.host.index('github.com')
                            GitHubDownloadStrategy.new(downloader)
                          end
    downloader.get_json ? downloader : nil
  end

  def get_portal
    @yaml.each do |name, subsections|
      create_folder name
      create_portal_page name
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
      opts = if u.is_a? Hash
               u
             else
               { 'url' => u }
             end

      puts "Downloading url: [#{i}/#{urls.count}] #{opts['url']}"
      i += 1
      doc = get_doc section_name, subsection_name, opts
      next unless doc

      filename = "#{section_name}/#{subsection_name}/#{doc.slug}.md"
      original_file_mtime = original_file_updated_at(filename)
      if original_file_mtime && doc.updated_at && original_file_mtime < doc.updated_at || # Doc updated
          original_file_mtime == nil || # never created
          !@update # force download all
        genertate_doc_file doc, filename, section_name, subsection_name
      else
        puts "                 [SKIPED] Original doc updated at: #{doc.updated_at} < #{original_file_mtime}"
      end
    end
  end

  def escape_title(original)
    if original.index(/[":']/)
      if original.index(/"/)
        original.index(/'/) ? URI.escape(original) : "'#{original}'"
      else
        "\"#{original}\""
      end
    else
      original
    end
  end

  def genertate_doc_file(doc, filename, section_name, subsection_name)
    title = escape_title(doc.title)
    content = "---
title: #{title}#{doc.additional_meta}
---

#{doc.content}

<small class=\"documentation-source\">Source: [#{doc.url}](#{doc.url})</small>
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
