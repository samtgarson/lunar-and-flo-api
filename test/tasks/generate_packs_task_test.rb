require 'test_helper'
class GeneratePacksTaskTest < ActiveSupport::TestCase
  setup do
    @user = create :user
    generate_check_ins 3, @user
    create :pack, user: @user, created_at: 2.months.ago

    @another_user = create :user
    generate_check_ins 3, @another_user
    create :pack, user: @another_user, created_at: 2.weeks.ago
  end

  test 'should generate new packs' do
    rake_task.invoke

    assert_equal 2, @user.packs.count
    assert_equal 1, @another_user.packs.count
  end
end
