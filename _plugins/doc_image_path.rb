module Jekyll
  module DocImagePathFilter
    def doc_image_path(page)
      prefix = @context.registers[:site].config['resources_path']
      collection = page['relative_path'].split('/').at 1
      name = page['name']
      "#{prefix}/#{collection}/#{name}"
    end
  end
end

Liquid::Template.register_filter(Jekyll::DocImagePathFilter)
