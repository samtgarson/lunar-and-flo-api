require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test 'should return unauthorized if unauthorized' do
    get user_url(@user)

    assert_includes json_response['errors'], 'Not Authenticated'
    assert_response :unauthorized
  end

  test 'should show user' do
    auth_visit :get, user_url(@user)

    assert_equal json_response['email'], @user.email
    assert_response :success
  end

  test 'should update user' do
    auth_visit :patch, user_url(@user), params: { user: { email: 'new@email.com', name: @user.name } }

    assert_equal json_response['email'], 'new@email.com'
    assert_response 200
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      auth_visit :delete, user_url(@user)
    end

    assert_response 204
  end
end
