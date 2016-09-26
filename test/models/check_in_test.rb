require 'test_helper'

class CheckInTest < ActiveSupport::TestCase
  setup do
    @check_in = build(:check_in, user: build(:user))
  end

  test 'is invalid without required attributes' do
    @check_in.update_attributes(user: nil)
    assert_not @check_in.valid?
  end

  test 'is valid with required atttributes' do
    assert @check_in.valid?
  end

  test '.on_day provides check ins on a day' do
    @check_in.update_attributes(created_at: 4.days.ago)

    assert_equal CheckIn.on_day(4.days.ago).first, @check_in
  end

  test 'should give total score of symptoms' do
    positive = create :symptom_group, points: 4
    negative = create :symptom_group, points: -2
    [positive, positive, negative].each do |group|
      CheckInSymptom.create(check_in: @check_in, symptom: create(:symptom, symptom_group: group))
    end

    assert_equal 6, @check_in.score
  end

  test 'should provide an icon' do
    happy = create :symptom_group, icon: 'happy'
    sad = create :symptom_group, icon: 'sad'
    [happy, happy, sad].each do |group|
      CheckInSymptom.create(check_in: @check_in, symptom: create(:symptom, symptom_group: group))
    end

    assert_equal 'happy', @check_in.icon
  end
end
