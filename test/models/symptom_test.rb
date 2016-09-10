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

    check_ins = create_list(:check_in, 3, user: user)

    3.times { |n| check_ins[n].check_in_symptoms.create symptom: top_symptom }
    2.times { |n| check_ins[n].check_in_symptoms.create symptom: second_symptom }
    1.times { |n| check_ins[n].check_in_symptoms.create symptom: third_symptom }

    assert_equal Symptom.for(user, limit: 2), [top_symptom, second_symptom]
  end
end
