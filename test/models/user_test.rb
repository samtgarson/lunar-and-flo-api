require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = create(:user, email: 'a@b.c')
  end

  test 'is invalid with a duplicate email' do
    another_user = build(:user, email: @user.email)

    assert_not another_user.valid?
  end

  test 'should provide latest pack with effects' do
    packs = create_packs @user, [2.weeks.ago, 1.week.ago]

    assert_equal @user.latest_pack, packs.last

    packs.last.update effects: []

    assert_equal @user.latest_pack, packs.first
  end

  test 'should provide users who need a new pack' do
    @other_user = create(:user)
    create_packs @user, [1.month.ago, 2.months.ago]
    create_packs @other_user, [1.month.ago, 2.weeks.ago]

    assert_equal User.needs_new_pack, [@user]
  end

  def create_packs(user, dates = [Time.current])
    dates.map { |date| create :pack, user: user, created_at: date }
  end
end
