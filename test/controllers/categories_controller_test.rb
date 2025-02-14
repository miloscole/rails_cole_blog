require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = categories(:one)
    @new_category_name = "#{@category.name}1"
    @admin_user = users(:admin)
    @regular_user = users(:regular_user)
    @denied_msg = "That action is allowed only for admin user"
  end

  class GetRequests < CategoriesControllerTest
    test "should get index page" do
      get categories_path
      assert_response :success
    end

    test "should get show page" do
      get category_path(@category)
      assert_response :success
    end

    test "should redirect from new page if not logged in" do
      get new_category_path
      assert_redirected_to root_path
    end

    test "should redirect from new page if logged in as regular user" do
      sign_in_as @regular_user
      get new_category_path
      assert_redirected_to root_path
    end

    test "should get new page" do
      sign_in_as @admin_user
      get new_category_path
      assert_response :success
    end

    test "should redirect from edit page if not logged in" do
      get edit_category_path(@category)
      assert_redirected_to root_path
    end

    test "should redirect from edit page if logged in as regular user" do
      sign_in_as(@regular_user)
      get edit_category_path(@category)
      assert_redirected_to root_path
    end

    test "should get edit page" do
      sign_in_as(@admin_user)
      get edit_category_path(@category)
      assert_response :success
    end
  end

  class PostRequests < CategoriesControllerTest
    test "should not create category as regular user" do
      sign_in_as(@regular_user)
      assert_no_difference "Category.count"  do
        post categories_path, params: { category: { name: @new_category_name } }
      end
      assert_redirected_to root_path
      assert_equal @denied_msg, flash[:alert]
    end

    test "should not create category with empty name" do
      sign_in_as(@admin_user)
      assert_no_difference "Category.count"  do
        post categories_path, params: { category: { name: "" } }
      end
      assert_response 422
    end

    test "should not create category with existing name" do
      sign_in_as(@admin_user)
      assert_no_difference "Category.count"  do
        post categories_path, params: { category: { name: @category.name } }
      end
      assert_response 422
    end

    test "should create category" do
      sign_in_as(@admin_user)
      assert_difference "Category.count"  do
        post categories_path, params: { category: { name: @new_category_name } }
      end
      assert_redirected_to categories_path
      assert_match /successfully created/, flash[:notice]
    end
  end

  class PatchRequests < CategoriesControllerTest
    test "should not update category as regular user" do
      sign_in_as(@regular_user)
      patch category_path(@category), params: { category: { name: @new_category_name } }
      assert_response :redirect
      assert_equal @denied_msg, flash[:alert]
      @category.reload
      assert_not_equal @new_category_name, @category.name
    end

    test "should not update category with empty name" do
      sign_in_as(@admin_user)
      patch category_path(@category), params: { category: { name: "" } }
      assert_response 422
    end

    test "should update category" do
      sign_in_as(@admin_user)
      patch category_path(@category), params: { category: { name: @new_category_name } }
      assert_redirected_to category_path(@category)
      @category.reload
      assert_equal @new_category_name, @category.name
      assert_match /successfully updated/, flash[:notice]
    end
  end

  class DeleteRequests < CategoriesControllerTest
    test "should not destroy category" do
      sign_in_as(@regular_user)
      assert_no_difference "Category.count" do
        delete category_path(@category)
      end
      assert_redirected_to root_path
      assert_equal @denied_msg, flash[:alert]
    end

    test "should destroy category" do
      sign_in_as(@admin_user)
      assert_difference "Category.count", -1 do
        delete category_path(@category)
      end
      assert_redirected_to categories_path
      assert_match /successfully deleted/, flash[:notice]
    end
  end
end
