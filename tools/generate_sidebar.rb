# This script is built to maintain the sidebar.

require 'fileutils'
require 'optparse'
require 'yaml'
require 'nokogiri'

class SidebarBuilder
  EXPORT_FOLDER = 'export'
  FILENAME_REGEX =  /\S+\/(\S+)\.md/

  def initialize(options = nil)
    @verbose = options[:verbose]
    @yamlfile = options[:yaml] || 'doc_list.yml'
    @yaml = YAML::load_file(File.join(__dir__, @yamlfile))
    @doc = Nokogiri::HTML::DocumentFragment.parse ""
  end

  def generate_sidebar
    @yaml.each do |section_name, subsections|
      Nokogiri::HTML::Builder.with(@doc) do |doc|
        puts "Generating section: #{section_name}" if @verbose
        doc.section(id: "sidebar-#{section_name}", class: "sidebar section #{section_name}") do |a|
          generate_subsections a, section_name, subsections
        end
      end
    end
  end

  def generate_subsections(builder, section_name, subsections)
    return unless subsections

    subsections.each do |subsection_name, urls|
      pattern = File.join(__dir__, '..', '_en', section_name, subsection_name, "*.md")
      puts "Searching: #{pattern}"
      builder.section(id: "sidebar-#{section_name}-#{subsection_name}",
          class: "sidebar subsection #{subsection_name}") do |doc|
        Dir.glob(pattern) do |filename|
          meta = YAML.load(File.open(filename))
          name = FILENAME_REGEX.match(filename)[1]
          doc.div(class: 'sidebar-nav-item') do |blk|
            blk.a(href: "/#{name}") { |a| a.text meta['title'] }
          end
        end
      end
    end
  end

  def execute
    export_folder = File.join(__dir__, EXPORT_FOLDER)
    FileUtils.mkdir_p export_folder
    FileUtils.mkdir_p File.join(export_folder, '_includes')
    generate_sidebar
    sidebar_html = @doc.to_html
    puts sidebar_html if @verbose
    File.write(File.join(export_folder, '_includes', 'sidebar.html'), sidebar_html)
  end

end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby tools/doc_section_maintainer.rb [options]"

  opts.on('-c', '--configuration NAME', 'YAML configuration file') { |v| options[:yaml] = v }
  opts.on('-v', '--verbose', 'Vebose mode') { |v| options[:verbose] = true }
end.parse!

$builder = SidebarBuilder.new(options)
$builder.execute
