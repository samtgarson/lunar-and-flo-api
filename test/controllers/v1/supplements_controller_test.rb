require 'test_helper'

class V1::SupplementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @supplements = create_list :supplement, 3
  end

  test 'should get index' do
    auth_visit :get, supplements_url

    assert_equal @supplements.count, json_response.count
    assert_response :success
  end

  test 'should get show' do
    auth_visit :get, supplement_url(id: @supplements.first.id)

    assert_equal @supplements.first.id, json_response['id']
    assert_response :success
  end
end
