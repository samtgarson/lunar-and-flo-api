require 'test_helper'

class CheckInTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:check_in, symptom: nil).valid?
  end

  test 'is valid with required atttributes' do
    symptom_group = build(:symptom_group)
    assert symptom_group.valid?
  end
end
