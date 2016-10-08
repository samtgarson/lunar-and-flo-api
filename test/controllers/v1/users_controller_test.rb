require 'test_helper'

class V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test 'should show user' do
    get user_url(@user)

    assert_equal json_response['email'], @user.email
    assert_response :success
  end

  test 'should update user' do
    patch user_url(@user), params: { email: 'new@email.com', name: @user.name }

    assert_equal json_response['email'], 'new@email.com'
    assert_response :success
  end

  test 'should create a new user' do
    post users_url

    assert json_response['id']
    assert_response :created
  end

  test 'should return an existing user' do
    create(:user, device_id: 'iphone uuid')
    post users_url(device_id: 'iphone uuid')

    assert_equal 'iphone uuid', json_response['device_id']
    assert_response :success
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_response 204
  end
end
