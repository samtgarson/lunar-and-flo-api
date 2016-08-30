require 'test_helper'

class SymptomTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:symptom, name: nil, symptom_group: nil).valid?
  end

  test 'is valid with required atttributes' do
    symptom = build(:symptom)
    assert symptom.valid?
  end
end
