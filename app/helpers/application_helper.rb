module ApplicationHelper
  include Twitter::TwitterText::Autolink
  class CustomRender < Redcarpet::Render::HTML
    def header(text, header_level)
      %(<a href="/hashtags/#{text}">\##{text}</a>)
    end
  end
  def markdown(text)
    options = {
     filter_html:     false,
     hard_wrap:       true,
     link_attributes: { rel: 'nofollow', target: "_blank" },
     space_after_headers: true,
     fenced_code_blocks: true
    }

    twoptions = {
      username_url_base: "/user/",
      hashtag_url_base: "/hashtags/",
      cashtag_url_base: "/hashtags/"
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
     footnotes: true,
     tables: true
   }
  
    renderer = CustomRender.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(auto_link(text, twoptions)).html_safe
  end
end
