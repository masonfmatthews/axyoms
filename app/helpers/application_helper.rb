module ApplicationHelper

  def browser_title
    "Mental Mapper" + (@browser_title ? " | #{@browser_title}" : "")
  end
end
