require 'test_helper'
#require 'fileutils'

class ProductsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @product = products(:product1)
    @photo = @product.photos.new
    @photo.image = Rails.root.join("test/fixtures/files/test.png").open
    @photo.save
    @category = categories(:category1)
  end

  test "should get show" do
    get product_path(@product)
    assert_response :success
    assert_match @product.title, response.body
    assert_match @product.description, response.body
    assert_match @product.price.to_s, response.body     
    assert_match "In Stock", response.body
    assert_select "img[src=?]", @photo.image.url
    assert_select "a[href=?]", shoppingcart_path
    assert_select "form select", count:1
    assert_select "form input[value=?]", "Add to Shopping Cart"
  end

  test "should create with photo and category" do
    get new_product_path
    assert_response :success
    image_upload = Rails.root.join("test/fixtures/files/test.png").open
    assert_difference "@category.products.count", 1 do
      post products_path, params:{product:{title:"Test",description:"test",price:10,stock:10, photos_attributes:{'0':{image:image_upload}}, categorizations_attributes:{'0':{category_id:@category.id}}}}
     end
    assert_redirected_to product_path(Product.last)
    assert_not Product.last.photos.empty?
  end

  test "should not create when price is not a number" do
    get new_product_path
    assert_response :success
    image_upload = Rails.root.join("test/fixtures/files/test.png").open
    assert_no_difference "Product.count" do
      post products_path, params:{product:{title:"Test",description:"test",price:"abc",stock:10, photos_attributes:{'0':{image:image_upload}}}}
    end
  end

  test "should edit the stock and delete the photo" do
    get edit_product_path(@product)
    assert_response :success
    patch product_path(@product), params:{product:{title:@product.title,abstract:@product.abstract,description:@product.description,price:@product.price,stock:0, photos_attributes:{'0':{id:@photo.id, _destroy:1}},categorizations_attributes:{'0':{category_id:@category.id}}}}
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
