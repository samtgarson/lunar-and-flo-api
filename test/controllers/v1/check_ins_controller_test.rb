require 'test_helper'

class V1::CheckInsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
  end

  def check_in_params
    { symptom_ids: [create(:symptom).id, create(:symptom).id], lat: 1.0, lng: 1.0, period: true }
  end

  test 'should create check ins for another user' do
    another_user = create :user

    assert_difference('another_user.check_ins.count', +1) do
      post user_check_ins_url(user_id: another_user.id), params: check_in_params
    end

    assert_equal 2, json_response['symptoms'].count
    assert_equal 1.0, json_response['lat']
    assert_equal true, json_response['period']
    assert json_response['weather_report']
    assert_response :success
  end

  test 'should return the current user\'s check ins' do
    2.times { @user.check_ins.create }
    get user_check_ins_url(user_id: @user.id)

    assert_equal json_response.count, 2
    assert_response :success
  end

  test 'should return failed symptom ids' do
    post user_check_ins_url(user_id: @user.id), params: { symptom_ids: ['123'] }

    assert_equal json_response['invalid_ids'], ['123']
    assert_response :unprocessable_entity
  end

  test 'should return a specific check in' do
    check_in = @user.check_ins.create
    get user_check_in_url(user_id: @user.id, id: check_in.id)

    assert_equal json_response['id'], check_in.id
    assert_response :success
  end
end
