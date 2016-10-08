require 'test_helper'

class PackTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:pack).valid?
  end

  test 'is valid with required atttributes' do
    pack = build(:pack, user: build(:user))
    assert pack.valid?
  end
end
