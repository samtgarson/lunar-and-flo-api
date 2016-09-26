require 'test_helper'

class PackGeneratorTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @service = PackGenerator.new(@user)
    @symptom = create(:symptom, supplement_count: 3)
  end

  test 'appends an effect for an empty pack' do
    @service.append_for(@symptom)

    assert_includes @symptom.effects, @service.pack.effects.first
  end

  test 'appends an effect for a user with a blacklist' do
    @symptom.effects[0..1].each(&@user.method(:blacklist!))
    whitelisted = (@symptom.effects - @user.blacklisted_effects).first

    @service.append_for(@symptom)

    assert_equal whitelisted, @service.pack.effects.first
  end
end
