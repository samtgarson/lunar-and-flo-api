require 'test_helper'

class V1::OnboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
  end

  test "should get create" do
    post user_onboard_url(user_id: @user.id)
    assert_response :success
  end

end
