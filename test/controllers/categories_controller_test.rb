require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @categories = Category.all
    @category = categories(:one)
    @products = @category.products
  end

  test "should get index" do
    get categories_path
    assert_response :success
    @categories.each do |category|
      assert_match category.name, response.body
    end
  end

  test "should get show" do
    get category_path(@category)
    assert_response :success
    assert_match @category.name, response.body
    @products.each do |product|
      assert_match product.title, response.body
      assert_match product.abstract, response.body
      assert_match product.price.to_s, response.body     
    end
  end

  test "should only create one" do
    get new_category_path
    assert_response :success
    assert_difference "Category.count", 1 do
      post categories_path, params:{category:{name:"Test"}}
    end
    assert_redirected_to categories_path
    assert_no_difference "Category.count" do
      post categories_path, params:{category:{name:"test"}}
    end
  end

  test "should not create" do
    assert_no_difference "Category.count" do
      post categories_path, params:{category:{name:""}}
    end
  end

  test "should edit" do
    get edit_category_path(@category)
    assert_response :success
    patch category_path(@category), params:{category:{name:"Hot Sell"}}
    follow_redirect!
    assert_match "Hot Sell", response.body
  end

  test "should delete" do
    assert_difference "Category.count", -1 do
      delete category_path(@category)
    end
  end

end
