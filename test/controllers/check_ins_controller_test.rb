require 'test_helper'

class CheckInsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
  end

  def check_in_params
    { symptom_ids: [create(:symptom).id, create(:symptom).id] }
  end

  test 'should create check ins' do
    assert_difference('CheckInSymptom.count', +2) do
      auth_visit :post, check_ins_url, params: check_in_params
    end

    assert_equal json_response['symptoms'].count, 2
    assert_response :success
  end

  test 'should return the current user\'s check ins' do
    2.times { @user.check_ins.create }
    auth_visit :get, check_ins_url

    assert_equal json_response.count, 2
    assert_response :success
  end
end
