require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test 'should get index' do
    get v1_users_url, as: :json
    assert_response :success
  end

  test 'should show user' do
    get v1_user_url(@user), as: :json
    assert_response :success
  end

  test 'should update user' do
    patch v1_user_url(@user), params: { user: { email: @user.email, name: @user.name } }, as: :json
    assert_response 200
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete v1_user_url(@user), as: :json
    end

    assert_response 204
  end
end
