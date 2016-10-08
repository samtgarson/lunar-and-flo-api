require 'test_helper'

class SymptomGroupTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:symptom_group, name: nil).valid?
  end

  test 'is valid with required atttributes' do
    symptom_group = build(:symptom_group)
    assert symptom_group.valid?
  end

  test '.normalize_categories works' do
    assert_equal SymptomGroup.normalize_categories(0), [0]
    assert_equal SymptomGroup.normalize_categories([0, 1]), [0, 1]
    assert_equal SymptomGroup.normalize_categories([0, :mood]), [0, 1]
  end
end
