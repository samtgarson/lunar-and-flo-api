require 'test_helper'

class UserHistoryTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @check_in = create(:check_in, user: @user)
  end

  def successful_context
    @successful_context ||= Users::History.call(user: @user, to: Time.current, from: 1.day.ago)
  end

  test 'it should provide the history' do
    assert_not successful_context.history[1.day.ago.strftime(Users::History::DATE_FORMAT)]
    assert_equal successful_context.history[Time.current.strftime(Users::History::DATE_FORMAT)], @check_in
  end
end
