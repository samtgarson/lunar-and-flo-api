require 'test_helper'

class PackTest < ActiveSupport::TestCase
  test 'is invalid without required attributes' do
    assert_not build(:pack, user: nil).valid?
  end

  test 'is valid with required atttributes' do
    pack = build(:pack, user: create(:user))
    assert pack.valid?
  end
end
