require 'test_helper'

class SymptomTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:symptom, name: nil, symptom_group: nil).valid?
  end

  test 'is valid with required atttributes' do
    symptom = build(:symptom)
    assert symptom.valid?
  end

  test '#for returns the correct symptoms' do
    user = create :user
    symptoms = generate_check_ins(3, user)
    assert_equal Symptom.for(user, limit: 2).to_a, [symptoms[0], symptoms[1]]
  end
end
