class ProductsController < ApplicationController
  def show
  	@product = Product.find(params[:id])
  end

  def new
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
  end

  private 
  def product_params
  	params.require(:product).permit(:title, :abstract, :description, :price, :stock, photos_attributes:[:id,:image,:image_cache, :_destroy])
  end
end
