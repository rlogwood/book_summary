require "test_helper"

class AiModelsControllerTest < ActionDispatch::IntegrationTest
  test "should get chatgpt_models" do
    get ai_models_chatgpt_models_url
    assert_response :success
  end
end
