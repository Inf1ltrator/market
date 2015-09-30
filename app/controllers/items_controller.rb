class ItemsController < ApplicationController


	before_filter :load_category
  before_filter :find_item,      only:[:show, :edit, :update, :destroy, :upvote, :create_position]

	def index
		@items = @category.items.all
	end
	# /items/id GET
	def show
		unless @item 
			render text: "Page not found", status: 404
      render layout: "admin"
		end
	end

	# /items/new GET
	def new
    @item = @category.items.build
    render layout: "admin"
	end

	# /items/id/edit GET
	def edit
	end

	def expensive
		@items = @category.items.where("price > 1000")
		render "index"
	end

	# /items POST
	def create
		@item = @category.items.new(item_params)
		if @item.save
			@item.image.update_attributes(file: params[:file])
			redirect_to [@category,@item]
		else
			render "new"
		end
	end

	# /items/id PUT
	def update
		@item.update_attributes(item_params)
		if @item.errors.empty?
			update_image(@item.id)
			redirect_to [@category,@item]
		else
			render "edit"
		end
	end

	def upvote
		@item.increment!(:votes_count)
		redirect_to action: :index
	end

  def create_position
    @position = Position.create()
    @item.positions << @position
    current_user.cart.positions << @position
    redirect_to [@category,@item]
  end

	# /items/id DELETE
	def destroy
		@item.destroy
		redirect_to @category
	end

	private

		def item_params
			params.require(:item).permit(:name,:price,:description,:weight,:real)
		end

		def find_item
			@item = @category.items.find_by(params[:id])
			render_404 unless @item 
		end

    def load_category
      @category = Category.find(params[:category_id])
    end

end
