module ApplicationHelper

  def browser_title
    "Axyoms" + (@browser_title ? " | #{@browser_title}" : "")
  end

  def datetimepicker(form, field_symbol)
    render partial: "layouts/datetimepicker", locals: {f: form, field: field_symbol}
  end

  def add_link_text(class_name, show_text=true)
    "<span class='glyphicon glyphicon-plus'></span>
        #{show_text ? " Add #{class_name.titleize}" : ''}".html_safe
  end

  def shortener(string, length)
    string.length > length ? string.first(length) + "..." : string
  end
end
