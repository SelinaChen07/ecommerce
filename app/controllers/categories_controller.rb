class CategoriesController < ApplicationController
  def index
  	@categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.all
  end


  def new
  	@category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category is ceated."
      redirect_to categories_path
    else
      render "new"
    end

  end

  def edit
  	@category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Category is updated."
      redirect_to categories_path
    else
      render "edit"
    end
  end

  def destroy
  	@category = Category.find(params[:id])
    @category.destroy
    flash[:success] = "The category is deleted."
    redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

end
