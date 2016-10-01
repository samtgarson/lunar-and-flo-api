require 'test_helper'

class SymptomTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:symptom, name: nil, symptom_group: nil).valid?
  end

  test 'is valid with required atttributes' do
    symptom = build(:symptom)
    assert symptom.valid?
  end

  test '#for_user returns the correct categories' do
    user = create :user

    physical = create :symptom_group, category: :physical
    mood = create :symptom_group, category: :mood

    ps = create_list :symptom, 2, symptom_group: physical
    ms = create_list :symptom, 2, symptom_group: mood

    (ms + ps).each { |s| check_in(user, s) }
    3.times { check_in(user, ps[0], created_at: 2.months.ago) }
    2.times { check_in(user, ms[0]) }

    assert_equal Symptom.for_user(user, limit: 2).to_a, [ps[0], ms[0]]
    assert_equal Symptom.for_user(user, limit: 2, category: :physical).to_a, ps
    assert_equal Symptom.for_user(user, limit: 2, category: :mood).to_a, ms
  end

  test '#for_user returns the correct symptoms after date' do
    user = create :user
    symptoms = create_list :symptom, 2

    check_in user, symptoms[0], created_at: 2.months.ago
    check_in user, symptoms[1], created_at: 2.weeks.ago

    assert_equal Symptom.for_user(user, limit: 2, after_date: 1.month.ago).to_a, [symptoms[1]]
    assert_matching Symptom.for_user(user, limit: 2, after_date: nil).to_a, symptoms
  end
end
