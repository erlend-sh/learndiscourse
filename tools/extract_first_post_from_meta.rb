require 'rest-client'
require 'multi_json'
require 'optparse'
require 'yaml'

class MetaDiscourseExtractor
  attr_accessor :url, :response, :json, :tags

  def initialize(options = nil)
    @opts = options || {}
  end

  def get_json
    process_url
    puts "Downloading from #{@url}" if @opts[:verbose]

    @response = RestClient.get(@url)
    @json = MultiJson.load(@response)
  end

  def process_url
    @url = "#{@url}.json?include_raw=true"
  end

  def clear
    @url = nil
    @response = nil
    @json = nil
    @tags = nil
  end

  def markdown_meta
    str = "---
title: #{title}
name: #{doc_identifier}
"
    if @tags
      str << "tags:\n"
      @tags.each do |t|
        str << "  - #{t}\n"
      end
    end

    "#{str}---\n\n"
  end

  def markdown_file
    "#{markdown_meta}#{post}"
  end

  def doc_identifier
    title.downcase.gsub(/\s+/, '-').gsub(/[^\w-]+/, '')
  end

  def filename
    "#{doc_identifier}.md"
  end

  def title
    @json['title']
  end

  def post
    @json['post_stream']['posts'].first['raw']
  end
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: extract_first_post_from_meta.rb [options]"

  opts.on('-c', '--configuration NAME', 'YAML configuration file') { |v| options[:yaml] = v }
  opts.on('-f', '--fake', "Don't actually write files") { |v| options[:fake] = true }
  opts.on('-v', '--verbose', 'Vebose mode') { |v| options[:verbose] = true }
end.parse!

extractor = MetaDiscourseExtractor.new(verbose: options[:verbose])

if options[:yaml]
  yaml= YAML::load_file(File.join(__dir__, options[:yaml]))
  return unless yaml

  yaml['urls'].each do |url|
    extractor.clear
    extractor.tags = yaml['tags']
    extractor.url = url
    extractor.get_json

    puts extractor.markdown_file if options[:verbose]

    File.write(File.join(__dir__, 'exports', extractor.filename), extractor.markdown_file) unless options[:fake]
  end
else
  extractor.url = ARGV[0]
  extractor.get_json
  puts extractor.markdown_file
end
