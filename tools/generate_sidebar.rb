# This script is built to maintain the sidebar.

require 'fileutils'
require 'optparse'
require 'yaml'
require 'hamlit'

class SidebarBuilder
  EXPORT_FOLDER = 'export'
  FILENAME_REGEX =  /\S+\/(\S+)\.md/

  def initialize(options = nil)
    @verbose = options[:verbose]
    @yamlfile = options[:yaml] || 'doc_list.yml'
    @yaml = YAML::load_file(File.join(__dir__, @yamlfile))
    @sidebar_template = options[:sidebar_template] || 'sidebar.haml'
    @engine = Hamlit::Template.new(format: :html5) { File.open(File.join(__dir__, @sidebar_template)).read }
  end

  def generate_sidebar
    pattern = File.join(__dir__, '..', '_en', '**/*.md')
    info = {}
    Dir.glob(pattern) do |path|
      meta = YAML::load_file(path)
      section, subsection, filename = path.split('/')[-3..-1]
      blob = {
        name: filename.split('.')[0],
        title: meta['title'],
        weight: meta['weight'] || 0
      }
      info[section] = {} unless info[section]
      info[section][subsection] = [] unless info[section][subsection]
      info[section][subsection].push(blob)
      info[section][subsection].sort! do |a,b|
        a[:weight] <=> b[:weight]
      end
    end
    locals = {
      yaml: @yaml,
      info: info
    }
    @engine.render(Object.new, locals)
  end

  def execute
    export_folder = File.join(__dir__, EXPORT_FOLDER)
    FileUtils.mkdir_p export_folder
    FileUtils.mkdir_p File.join(export_folder, '_includes')
    sidebar_html = generate_sidebar
    puts sidebar_html if @verbose
    File.write(File.join(export_folder, '_includes', 'sidebar.html'), sidebar_html)
  end

end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby tools/doc_section_maintainer.rb [options]"

  opts.on('-c', '--configuration NAME', 'YAML configuration file') { |v| options[:yaml] = v }
  opts.on('-s', '--sidebar_template TEMPLATE', 'HAML template for sidebar') { |s| option[:sidebar_template] = s }
  opts.on('-v', '--verbose', 'Vebose mode') { |v| options[:verbose] = true }
end.parse!

$builder = SidebarBuilder.new(options)
$builder.execute
