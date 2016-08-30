require 'test_helper'

class AuthenticationControllerst < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test 'should provide JWT token' do
    post auth_url, params: { email: @user.email, password: @user.password }

    assert_includes json_response.keys, 'auth_token'
    assert_response :success
  end

  test 'should return error if incorrect email' do
    post auth_url, params: { email: 'wrong@email.com', password: @user.password }

    assert_includes json_response['errors'], 'Invalid Username/Password'
    assert_response :unauthorized
  end

  test 'should return error if incorrect password' do
    post auth_url, params: { email: @user.email, password: 'wrong password' }

    assert_includes json_response['errors'], 'Invalid Username/Password'
    assert_response :unauthorized
  end
end
