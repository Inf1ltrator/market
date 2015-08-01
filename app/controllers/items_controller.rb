class ItemsController < ApplicationController

	def index
		@items = Item.all
	end

	# /items/id GET
	def show
		unless @item = Item.where(id: params[:id]).first
			render text: "Page not found", status: 404
		end
	end

	# /items/new GET
	def new
		@item = Item.new
	end

	# /items/id/edit GET
	def edit
		@item = Item.find(params[:id])
	end

	# /items POST
	def create
		@item = Item.create(item_params)
		if @item.errors.empty?
			redirect_to item_path(@item)
		else
			render "new"
		end
	end

	# /items/id PUT
	def update
		@item = Item.find(params[:id])
		@item.update_attributes(item_params)
		if @item.errors.empty?
			redirect_to item_path(@item)
		else
			render "edit"
		end
	end

	# /items/id DELETE
	def destroy
		@item = Item.find(params[:id])
		@item.destroy
		redirect_to action: "index"
	end

	def item_params
		params.require(:item).permit(:name,:price,:description,:weight,:real)
	end

end
