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
    top_symptom = create :symptom
    second_symptom = create :symptom
    third_symptom = create :symptom
    create :symptom # fourth symptom

    check_in = create(:check_in, user: user)

    3.times { check_in.check_in_symptoms.create symptom: top_symptom }
    2.times { check_in.check_in_symptoms.create symptom: second_symptom }
    1.times { check_in.check_in_symptoms.create symptom: third_symptom }

    assert_equal Symptom.for(user, limit: 2), [top_symptom, second_symptom]
  end
end
