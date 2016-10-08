require 'test_helper'

class PackGenerationTest
  module BasicSetup
    extend ActiveSupport::Concern
    included do
      setup do
        @user = create :user
        @symptom = create :symptom, supplement_count: 4, symptom_group: create(:symptom_group, category: :physical)
        @effects = @symptom.effects.to_a

        create :check_in, user: @user, symptom_ids: [@symptom.id]

        @effects[0].update effectiveness_days: 30
        @effects[1].update effectiveness_days: 60
      end

      test 'the interaction is a success' do
        assert @result.success?
      end
    end

    def set_result!
      @result = Packs::Generate.call(user: @user)
    end
  end

  class ForIneffectiveSymptoms < ActionDispatch::IntegrationTest
    include PackGenerationTest::BasicSetup
    setup do
      [
        { created: 1.month.ago, effects: 2 },
        { created: 2.months.ago, effects: 1 },
        { created: 3.months.ago, effects: 0 }
      ].each { |p| create :pack, user: @user, effects: @effects.first(p[:effects]), created_at: p[:created] }

      set_result!
    end

    test 'the correct effects are assigned' do
      assert_operator @user.latest_pack.created_at, :>, 1.day.ago
      assert_matching @user.latest_pack.effects, @effects.last(3)
    end

    test 'the correct effects are blacklisted' do
      assert_includes @user.blacklisted_effects, @effects[0]
      assert_equal @user.blacklisted_effects.count, 1
    end
  end

  class ForFirstTimeUser < ActionDispatch::IntegrationTest
    include PackGenerationTest::BasicSetup
    setup do
      set_result!
    end

    test 'the correct effects are assigned' do
      assert_operator @user.latest_pack.created_at, :>, 1.day.ago
      assert_equal @user.latest_pack.effects - @effects, []
    end

    test 'the correct effects are blacklisted' do
      assert_equal @user.blacklisted_effects.count, 0
    end
  end

  class WithAllBlacklistedUser < ActionDispatch::IntegrationTest
    include PackGenerationTest::BasicSetup
    setup do
      @effects.each(&@user.method(:blacklist!))
      set_result!
    end

    test 'the correct effects are assigned' do
      assert_operator @user.latest_pack.created_at, :>, 1.day.ago
      assert_equal @user.latest_pack.effects - @effects, []
    end

    test 'the correct effects are blacklisted' do
      assert_equal @user.blacklisted_effects.count, 1
    end
  end
end
