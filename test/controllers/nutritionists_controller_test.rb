require 'test_helper'

class NutritionistsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nutritionists_index_url
    assert_response :success
  end

end
