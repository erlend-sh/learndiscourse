module Jekyll
  module FileDateFilter
    def file_date(input)
      File.mtime(input)
    end
  end
end

Liquid::Template.register_filter(Jekyll::FileDateFilter)
