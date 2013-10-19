module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def body_class
    "#{controller_name} #{action_name}"
  end

end
