require 'test_helper'

class CheckInTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:check_in, user: nil).valid?
  end

  test 'is valid with required atttributes' do
    check_in = build(:check_in, user: create(:user))
    assert check_in.valid?
  end
end
