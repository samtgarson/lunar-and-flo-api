require 'test_helper'

class GenerateNewPacksJobTest < ActiveJob::TestCase
  setup do
    @user = create :user
  end

  test 'should generate a new pack' do
    generate_check_ins 3, @user
    @user.packs << create(:pack, user: @user, created_at: 2.months.ago)

    assert_difference('@user.packs.count', +1) do
      GenerateNewPacksJob.new.perform(@user.id)
    end
  end

  test 'should raise if the user has less than 3 check ins' do
    assert_raises GenerateNewPacksJob::FailedInteractionError do
      GenerateNewPacksJob.new.perform(@user.id)
    end
  end
end
