class ProductsController < ApplicationController
  def show
  	@product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    3.times{@product.photos.build}
  end

  def create
    @product = Product.new(product_params)
    if @product.save
     flash[:sucess] = "The product is created."
      redirect_to product_path(@product)
      CarrierWave.clean_cached_files! 1
    else
     3.times{@product.photos.build}
     render"new"
    end
  end

  def edit
  	@product = Product.find(params[:id])
  	3.times{@product.photos.build}
  end

  def update  	
  	@product = Product.find(params[:id])
  	if @product.update(product_params)
     flash[:sucess] = "The product profile is updated."
  		redirect_to product_path(@product)
      CarrierWave.clean_cached_files! 1
  	else
     3.times{@product.photos.build}
  		render"edit"
  	end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:sucess] = "The product is deleted."
    redirect_to root_path
  end

  private 
  def product_params
  	params.require(:product).permit(:title, :abstract, :description, :price, :stock, photos_attributes:[:id,:image,:image_cache, :_destroy])
  end
end
