require 'test_helper'
#require 'fileutils'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @product = products(:one)
    @photo = @product.photos.new
    @photo.image = Rails.root.join("test/fixtures/files/test.png").open
    @photo.save
  end

  test "should get show" do
    get product_path(@product)
    assert_response :success
    assert_match @product.title, response.body
    assert_match @product.description, response.body
    assert_match @product.price.to_s, response.body     
    assert_match "In Stock", response.body
    assert_select "img[src=?]", @photo.image.url
  end

  test "should create" do
    get new_product_path
    assert_response :success
    image_upload = Rails.root.join("test/fixtures/files/test.png").open
    assert_difference "Product.count", 1 do
      post products_path, params:{product:{title:"Test",description:"test",price:10,stock:10, photos_attributes:{'0':{image:image_upload}}}}
    end
    assert_redirected_to product_path(Product.last)
  end

  test "should not create" do
    get new_product_path
    assert_response :success
    image_upload = Rails.root.join("test/fixtures/files/test.png").open
    assert_no_difference "Product.count" do
      post products_path, params:{product:{title:"Test",description:"test",price:10,stock:"abc", photos_attributes:{'0':{image:image_upload}}}}
    end
  end

  test "should edit" do
    get edit_product_path(@product)
    assert_response :success
    patch product_path(@product), params:{product:{title:@product.title,abstract:@product.abstract,description:@product.description,price:@product.price,stock:0, photos_attributes:{'0':{id:@photo.id, _destroy:1}}}}
    follow_redirect!
    assert_match "Out of Stock", response.body
    assert_select "img", count:0
  end

  test "should delete" do
    assert_difference "Product.count", -1 do
      delete product_path(@product)
    end
  end

  #Minitest.after_run {
      #FileUtils.rm_rf(Dir["#{Rails.root.join("test")}/[^.]*"])
  #}

  def teardown
    @photo.remove_image!
    @photo.save
  end

end
