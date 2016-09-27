require 'test_helper'

class PackGeneratorTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @symptom = create(:symptom, supplement_count: 3)
    Pack.create(user: @user)

    @service = PackGenerator.new(@user)
  end

  test 'appends an effect for an empty pack' do
    @service.append_for(@symptom)

    assert_includes @symptom.effects, @service.pack.effects.first
  end

  test 'appends an effect for a user with a blacklist' do
    expected_effect = @symptom.effects.sample
    (@symptom.effects - [expected_effect]).each(&@user.method(:blacklist!))

    @service.append_for(@symptom)

    assert_equal expected_effect, @service.pack.effects.first
  end

  test 'appends an effect for a user with a previous effective effect' do
    previous_effect = @symptom.effects.first
    previous_effect.update(effectiveness_days: 4)
    @user.packs.create(effects: [previous_effect], created_at: 2.days.ago)

    @service.append_for(@symptom)

    assert_equal previous_effect, @service.pack.effects.first
  end

  def setup_previous_packs
    @previous_effect = @symptom.effects[0]
    @previous_effect.update(effectiveness_days: 4)
    @user.packs.create(effects: [@previous_effect], created_at: 2.days.ago)
    @user.packs.create(effects: [@previous_effect], created_at: 6.days.ago)
  end

  test 'appends an effect for a user with a previous ineffective effect and a blacklisted effect' do
    setup_previous_packs
    @user.blacklist! @symptom.effects[1]
    expected_effect = @symptom.effects[2]

    @service.append_for(@symptom)

    assert_equal expected_effect, @service.pack.effects.first
    assert_includes @user.blacklisted_effects, @previous_effect
  end

  test 'unblacklists effects if no more viable effects' do
    @symptom.effects.each(&@user.method(:blacklist!))

    assert_difference('@user.blacklisted_effects.count', -1) do
      @service.append_for(@symptom)
    end

    refute_includes @user.blacklisted_effects, @service.pack.effects.first
  end
end
