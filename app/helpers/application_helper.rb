module ApplicationHelper

	def urls_to_images(s)
		s.gsub! /\s(http:\/\/.*?(\.png|jpg))\s/,
			'<p><img src="\1"/><p>'
		s.html_safe
	end

	def urls_to_links(s)
		s.gsub! /\s(https:\/\/.*?)\s/,
			'<a href="\1">\1</a>'
		s.html_safe
	end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


end
