class CategoriesController < ApplicationController

  before_filter :find_category,      only:[:show, :edit, :update, :destroy, :upvote]
  #before_filter :check_if_admin, only:[:edit, :update, :create, :new, :delete]

  def index
    render layout: "category"
  end
  # /items/id GET
  def show
    unless @category 
      render text: "Page not found", status: 404
    end
    render layout: "category"
  end

  # /items/new GET
  def new
    @category = Category.new
    render layout: "admin"
  end

  # /items/id/edit GET
  def edit
  end

  # /items POST
  def create
    @category = Category.create(category_params)
    if @category.errors.empty?
      redirect_to category_path(@category)
    else
      render "new"
    end
  end

  # /items/id PUT
  def update
    @category.update_attributes(category_params)
    if @category.errors.empty?
      redirect_to category_path(@category)
    else
      render "edit"
    end
  end

  # /items/id DELETE
  def destroy
    @category.destroy
    redirect_to action: "index"
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

    def find_category
      @category = Category.where(id: params[:id]).first
      render_404 unless @category
    end

end
