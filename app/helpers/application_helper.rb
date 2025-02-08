module ApplicationHelper
  def custom_line_break(num = 5)
    ("<br>" * num).html_safe
  end

  def page_title(text)
    content_tag(:article, class: "container") do
      content_tag(:h4, text, class: "padding-x-medium margin-0")
    end
  end
end
