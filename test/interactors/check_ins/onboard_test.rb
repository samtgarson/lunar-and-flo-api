require 'test_helper'

class CheckIns::OnboardTest < ActiveSupport::TestCase
  setup do
    @symptom = create(:symptom)
    @user = create(:user)
    @context ||= CheckIns::Onboard.call(user: @user, last_period: 1.day.ago, cycle_length: 5, period_length: 3)
  end

  test 'it succeeds' do
    assert @context.success?
    assert_equal 4, @user.check_ins.count
  end

  test 'it creates check ins for the users last period' do
    assert @user.check_ins.find_by(created_at: 1.day.ago.to_date)
  end

  test 'it doesnt create check ins in the future' do
    refute @user.check_ins.find_by(created_at: Date.current)
  end

  test 'it creates check ins for the users previous period' do
    assert @user.check_ins.find_by(created_at: 6.days.ago.to_date)
    assert @user.check_ins.find_by(created_at: 5.days.ago.to_date)
    assert @user.check_ins.find_by(created_at: 4.days.ago.to_date)
  end
end
