require 'test_helper'

class CheckInsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
  end

  def check_in_params
    { symptom_ids: [create(:symptom).id, create(:symptom).id] }
  end

  test 'should create check ins for another user' do
    another_user = create :user

    assert_difference('another_user.check_ins.count', +1) do
      auth_visit :post, user_check_ins_url(user_id: another_user.id), params: check_in_params
    end

    assert_equal json_response['symptoms'].count, 2
    assert_response :success
  end

  test 'should return the current user\'s check ins' do
    2.times { @user.check_ins.create }
    auth_visit :get, user_check_ins_url(user_id: @user.id)

    assert_equal json_response.count, 2
    assert_response :success
  end
end
