# This script is built to maintain the sidebar.

require 'fileutils'
require 'optparse'
require 'yaml'
require 'hamlit'
require 'uri'

class PostProcesser
  EXPORT_FOLDER = 'export'
  SITE_URL = 'http://learndiscourse.org/'
  FILENAME_REGEX =  /\S+\/(\S+)\.md/

  def initialize(options = nil)
    @verbose = options[:verbose]
    @yamlfile = options[:yaml] || 'doc_list.yml'
    @yaml = YAML::load_file(File.join(__dir__, @yamlfile))
    @sidebar_template = options[:sidebar_template] || 'sidebar.haml'
    @info = {}
    @url_map = {}
    @file_pattern = File.join(__dir__, '..', '_en', '**/*.md')
    @engine = Hamlit::Template.new(format: :html5) { File.open(File.join(__dir__, @sidebar_template)).read }
  end

  def gather_information
    Dir.glob(@file_pattern) do |path|
      section, subsection, filename = path.split('/')[-3..-1]
      slug = filename[0..-4]
      content = File.read(path)

      match = content.match(/Source: \[(\S+)\]/)
      @url_map[match[1]] = slug if match

      meta = YAML::load(content)

      blob = {
        name: filename.split('.')[0],
        title: meta['title'],
        weight: meta['weight'] || 0
      }
      @info[section] = {} unless @info[section]
      @info[section][subsection] = [] unless @info[section][subsection]
      @info[section][subsection].push(blob)
    end
    @info.each do |_, sections|
      sections.each do |_, subsection|
        subsection.sort! { |a,b| b[:weight] <=> a[:weight] }
      end
    end
  end

  def generate_sidebar
    locals = {
      yaml: @yaml,
      info: @info
    }
    @engine.render(Object.new, locals)
  end

  def post_process_url
    Dir.glob(@file_pattern) do |path|
      section, subsection, filename = path.split('/')[-3..-1]
      content = File.read(path)
      splits = content.split(/<\/small>/)

      if splits.count == 2 # catch the file need to be post process
        urls = URI.extract(splits[1]).find_all { |u| u =~ /^https?:/ }.map do |url|
          url.gsub!(/[#)].*$/, '')

          match = url.match(/(https?:\/\/meta.discourse.org\/t\/\S+\/\d+)\/\d/)
          url = match[1] if match
          match = url.match(/(https?:\/\/meta.discourse.org\/t\/\S+\/\d+)\/\d/)
          url = match[1] if match
          url
        end
        puts urls if urls && @verbose
        urls.each do |url|
          splits[1].gsub!(Regexp.compile("#{url}(\/?\\d*)?"), SITE_URL + @url_map[url]) if @url_map[url]
        end

        File.write(File.join(__dir__, EXPORT_FOLDER, '_en', section, subsection, filename), splits.join('</small>'))
      end
    end
  end

  def execute
    export_folder = File.join(__dir__, EXPORT_FOLDER)
    FileUtils.mkdir_p export_folder
    FileUtils.mkdir_p File.join(export_folder, '_includes')

    gather_information

    sidebar_html = generate_sidebar
    puts sidebar_html if @verbose
    File.write(File.join(export_folder, '_includes', 'sidebar.html'), sidebar_html)

    post_process_url
  end

end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby tools/post_processer.rb [options]"

  opts.on('-c', '--configuration NAME', 'YAML configuration file') { |v| options[:yaml] = v }
  opts.on('-s', '--sidebar_template TEMPLATE', 'HAML template for sidebar') { |s| option[:sidebar_template] = s }
  opts.on('-v', '--verbose', 'Vebose mode') { |v| options[:verbose] = true }
end.parse!

$builder = PostProcesser.new(options)
$builder.execute
