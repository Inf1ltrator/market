class ItemsController < ApplicationController

	before_filter :find_item,      only:[:show, :edit, :update, :destroy, :upvote]
	before_filter :check_if_admin, only:[:edit, :update, :create, :new, :delete]

	def index
		@items = Item.all
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
			redirect_to item_path(@item)
		else
			render "new"
		end
	end

	# /items/id PUT
	def update
		@item.update_attributes(item_params)
		if @item.errors.empty?
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

		def check_if_admin
			render_403 unless params[:admin]
		end

end
