require 'test_helper'

class CheckInTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:check_in, user: create(:user), symptom: nil).valid?
  end

  test 'is valid with required atttributes' do
    check_in = build(:check_in, user: create(:user), symptom: create(:symptom))
    assert check_in.valid?
  end
end
