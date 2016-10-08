require 'test_helper'

class V1::BlacklistedEffectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @user.blacklisted_effects = create_list :effect, 3
  end

  test 'should get index' do
    get user_blacklisted_effects_url(user_id: @user.id)

    assert_equal @user.blacklisted_effects.count, json_response.count
    assert_response :success
  end
end
