module ApplicationHelper
  def custom_line_break(num = 5)
    ("<br>" * num).html_safe
  end

  def page_title(args = {})
    case action_name
    when "new", "create"
      text = "Create new #{args[:name] || controller_name.singularize}"
    when "edit", "update"
      text = "Editing #{args[:name] || controller_name.singularize}"
    else
      text = controller_name.humanize
    end

    content_tag(:article, class: "container") do
      content_tag(:h4, args[:custom_text] || text, class: "padding-x-medium margin-0")
    end
  end
end
