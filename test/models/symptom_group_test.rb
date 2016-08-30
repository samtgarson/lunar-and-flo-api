require 'test_helper'

class SymptomGroupTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:symptom_group, name: nil).valid?
  end

  test 'is valid with required atttributes' do
    symptom_group = build(:symptom_group)
    assert symptom_group.valid?
  end
end
