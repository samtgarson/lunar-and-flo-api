require 'test_helper'

class V1::CheckInsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
  end

  def check_in_params
    { symptom_ids: [create(:symptom).id, create(:symptom).id], lat: 1.0, lng: 1.0 }
  end

  test 'should create check ins for another user' do
    another_user = create :user

    assert_difference('another_user.check_ins.count', +1) do
      auth_visit :post, user_check_ins_url(user_id: another_user.id), params: check_in_params
    end

    assert_equal json_response['symptoms'].count, 2
    assert json_response['lat']
    assert json_response['weather_report']
    assert_response :success
  end

  test 'should return the current user\'s check ins' do
    2.times { @user.check_ins.create }
    auth_visit :get, user_check_ins_url(user_id: @user.id)

    assert_equal json_response.count, 2
    assert_response :success
  end

  test 'should return failed symptom ids' do
    auth_visit :post, user_check_ins_url(user_id: @user.id), params: { symptom_ids: ['123'] }

    assert_equal json_response['invalid_ids'], ['123']
    assert_response :unprocessable_entity
  end
end
