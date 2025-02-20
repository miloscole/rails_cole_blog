module ApplicationHelper
  def custom_line_break(num = 6)
    ("<br>" * num).html_safe
  end

  def page_title_el(args = {})
    title = page_title(args[:name])

    content_tag(:article, class: "container") do
      content_tag(:h4, args[:custom_text] || title, class: "padding-x-medium margin-0")
    end
  end

  def page_title(name = nil)
    case action_name
    when "new", "create"
      "Create new #{name || controller_name.singularize}"
    when "edit", "update"
      "Editing #{name|| controller_name.singularize}"
    else
      controller_name.humanize
    end
  end
end
