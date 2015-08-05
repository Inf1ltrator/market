class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception

  private

  	def check_if_admin
		render_403 unless params[:admin]
	end

	def render_403
		render file: "public/403.html", status: 403
	end

	def render_404
		render file: "public/404.html", status: 404
	end

	def store_image
		if params[:file]
		  @image = Image.new(file: params[:file])
		  @image.save
		else
			@image = Image.new
			@image.save
		end

	end

	def update_image imageable_id
		if params[:file]
		  @image = Image.find_by_imageable_id(imageable_id)
		  @image.update_attributes(file: params[:file])
		end
	end

end
