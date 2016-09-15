require 'test_helper'

class PacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @packs = (1..5).map { |n| create(:pack, created_at: n.days.ago, user: @user) }
  end

  test 'should get index' do
    auth_visit :get, user_packs_url(user_id: @user.id)

    assert_response :success
  end

  test 'should get show' do
    auth_visit :get, user_pack_url(user_id: @user.id, id: @packs.last.id)

    assert_equal json_response['id'], @packs.last.id
    assert_response :success
  end

  test 'should get latest pack' do
    auth_visit :get, user_pack_url(user_id: @user.id, id: 'latest')

    assert_equal json_response['id'], @packs.first.id
    assert_response :success
  end
end
