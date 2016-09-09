require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test 'is invalid with a duplicate email' do
    another_user = build(:user, email: @user.email)

    assert_not another_user.valid?
  end
end
