require 'test_helper'

class CheckInsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @symptom1 = create :symptom
    @symptom2 = create :symptom
    @user = create :user
    @check_in_params = { symptom_ids: [@symptom1.id, @symptom2.id] }
  end

  test 'should create check ins' do
    assert_difference('CheckIn.count', +2) do
      auth_visit :post, v1_check_ins_url, params: @check_in_params
    end

    assert_equal json_response['check_ins'].count, 2
    assert_response :success
  end
end
