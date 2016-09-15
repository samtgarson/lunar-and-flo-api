require 'test_helper'

class CheckInTest < ActiveSupport::TestCase
  setup do
    @check_in = build(:check_in)
  end

  test 'is invalid without required attributes' do
    assert_not @check_in.valid?
  end

  test 'is valid with required atttributes' do
    @check_in.update_attributes(user: build(:user))
    assert @check_in.valid?
  end

  test '.on_day provides check ins on a day' do
    @check_in.update_attributes(created_at: 4.days.ago, user: build(:user))

    assert_equal CheckIn.on_day(4.days.ago).first, @check_in
  end
end
