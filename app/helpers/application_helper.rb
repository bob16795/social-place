module ApplicationHelper
  def markdown(text)
    options = {
     filter_html:     false,
     hard_wrap:       true,
     link_attributes: { rel: 'nofollow', target: "_blank" },
     space_after_headers: true,
     fenced_code_blocks: true
    }
  
    extensions = {
     autolink:           true,
     no_intra_emphasis: true,
     superscript:        true,
     highlight: true,
     strikethrough: true,
     quote: true,
     no_images: true,
     no_styles: true,
     prettify: true,
     superscript: true,
     footnotes: true,
     tables: true
   }
  
    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
end
