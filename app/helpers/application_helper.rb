module ApplicationHelper
  def title
    base_title = "Micropost Sample"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  def logo(image)
    link_to image_tag(image), signup_path
  end
end
