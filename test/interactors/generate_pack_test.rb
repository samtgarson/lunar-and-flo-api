require 'test_helper'

class GeneratePackTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
  end

  def successful_context
    @successful_context ||= GeneratePack.call(user: @user)
  end

  test 'it provides a pack for a user with many check ins' do
    generate_check_ins(4, @user)

    assert successful_context.user.packs.first
    assert_equal 3, successful_context.user.packs.first.effects.count
  end

  test 'it provides a pack for a user with 2 symptoms' do
    generate_check_ins(2, @user)

    assert_equal 3, successful_context.user.packs.first.effects.count
  end
end
