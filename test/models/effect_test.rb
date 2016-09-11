require 'test_helper'

class EffectTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:effect, symptom: nil, supplement: nil).valid?
  end

  test 'is valid with required atttributes' do
    effect = build(:effect, supplement: create(:supplement), symptom: create(:symptom))
    assert effect.valid?
  end
end
