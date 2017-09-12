class ProductsController < ApplicationController
  def show
  	@product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @category_options = Category.all.map{|category| [category.name, category.id]}
    5.times{@product.photos.build}
    5.times{@product.categorizations.build}
  end

  def create
    @product = Product.new(product_params)
    if @product.save
     flash[:success] = "The product is created."
      redirect_to product_path(@product)
      CarrierWave.clean_cached_files! 0
    else
     5.times{@product.photos.build}
     5.times{@product.categorizations.build}
     @category_options = Category.all.map{|category| [category.name, category.id]}
     render"new"
    end
  end

  def edit
  	@product = Product.find(params[:id])
    @category_options = Category.all.map{|category| [category.name, category.id]}
  	5.times{@product.photos.build}
    5.times{@product.categorizations.build}
  end

  def update  	
  	@product = Product.find(params[:id])
  	if @product.update(product_params)
     flash[:success] = "The product profile is updated."
  		redirect_to product_path(@product)
      CarrierWave.clean_cached_files! 0
  	else
     5.times{@product.photos.build}
     5.times{@product.categorizations.build}
     @category_options = Category.all.map{|category| [category.name, category.id]}
  		render"edit"
  	end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:success] = "The product is deleted."
    redirect_to root_path
  end

  private 
  def product_params
  	params.require(:product).permit(:title, :abstract, :description, :price, :stock, photos_attributes:[:id,:image,:image_cache, :_destroy], categorizations_attributes:[:id,:category_id, :_destroy])
  end
end
