require 'test_helper'

class SupplementTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:supplement, name: nil, description: nil).valid?
  end

  test 'is valid with required atttributes' do
    supplement = build(:supplement)
    assert supplement.valid?
  end
end
