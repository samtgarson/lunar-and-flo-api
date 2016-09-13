require 'test_helper'

class V1::HistoryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @symptom = create :symptom
    @check_ins = [3.days.ago, 1.day.ago].map { |d| create(:check_in, user: @user, created_at: d) }
  end

  test 'should get history between dates' do
    auth_visit :get, user_history_url(from: 1.week.ago, user_id: @user.id)
    days = (1..3).map { |d| d.days.ago.strftime(UserHistory::DATE_FORMAT) }
    empty_days = days.values_at(1, 3)
    full_days = days.values_at(2)

    empty_days.each { |d| assert_equal json_response[d], nil }
    full_days.each_with_index { |d, i| assert_equal json_response[d], CheckInSerializer.new(@check_ins[i]).as_json.stringify_keys }
    assert_response :success
  end
end
