require "test_helper"

class SummaryTesterControllerTest < ActionDispatch::IntegrationTest
  test "should get summary" do
    get summary_tester_summary_url
    assert_response :success
  end
end
