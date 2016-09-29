require 'test_helper'

class V1::HistoryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @symptom = create :symptom
    @check_in = create(:check_in, user: @user, created_at: 1.day.ago)
    CheckInSymptom.create check_in: @check_in, symptom: @symptom
  end

  test 'should get recent history' do
    get user_history_url(user_id: @user.id)

    assert_not json_response[2.days.ago.strftime(UserHistory::DATE_FORMAT)]
    assert_equal json_response[1.day.ago.strftime(UserHistory::DATE_FORMAT)], CheckInSerializer.new(@check_in).as_json.deep_stringify_keys
    assert_response :success
  end

  test 'it provides a month from a date' do
    get user_history_url(user_id: @user.id, before: 3.months.ago)

    assert_equal json_response.keys.first, 3.months.ago.strftime(UserHistory::DATE_FORMAT)
    assert_equal json_response.keys.last, (4.months.ago + 1.day).strftime(UserHistory::DATE_FORMAT)
  end
end
