class ItemsController < ApplicationController

	before_filter :find_item,      only:[:show, :edit, :update, :destroy, :upvote]
	#before_filter :check_if_admin, only:[:edit, :update, :create, :new, :delete]

	def index
		@items = Item
		@items = @items.where("price >= ?", params[:price_from]) if params[:price_from]
		@items = @items.where("created_at >= ?", 1.day.ago) if params[:today]
		@items = @items.order("votes_count DESC", "price")
	end
	# /items/id GET
	def show
		unless @item 
			render text: "Page not found", status: 404
		end
	end

	# /items/new GET
	def new
		@item = Item.new
	end

	# /items/id/edit GET
	def edit
	end

	def expensive
		@items = Item.where("price > 1000")
		render "index"
	end

	# /items POST
	def create
		@item = Item.create(item_params)
		if @item.errors.empty?
			store_image
			@item.image = @image
			redirect_to item_path(@item)
		else
			render "new"
		end
	end

	# /items/id PUT
	def update
		@item.update_attributes(item_params)
		if @item.errors.empty?
			update_image(@item.id)
			redirect_to item_path(@item)
		else
			render "edit"
		end
	end

	def upvote
		@item.increment!(:votes_count)
		redirect_to action: :index
	end

	# /items/id DELETE
	def destroy
		@item.destroy
		redirect_to action: "index"
	end

	private

		def item_params
			params.require(:item).permit(:name,:price,:description,:weight,:real)
		end

		def find_item
			@item = Item.where(id: params[:id]).first
			render_404 unless @item 
		end

end
