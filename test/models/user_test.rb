require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  test 'is invalid with a duplicate email' do
    another_user = build(:user, email: @user.email)

    assert_not another_user.valid?
  end

  test 'should provide latest pack' do
    create(:pack, user: @user, created_at: 2.weeks.ago)
    new_pack = create(:pack, user: @user, created_at: 1.week.ago)

    assert_equal @user.latest_pack, new_pack
  end
end
