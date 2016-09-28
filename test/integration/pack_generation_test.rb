require 'test_helper'

class PackGenerationTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @symptom = create :symptom, supplement_count: 4, symptom_group: create(:symptom_group, physical: true)
    @effects = @symptom.effects.to_a

    @effects[0].update effectiveness_days: 30
    @effects[1].update effectiveness_days: 60

    create :check_in, user: @user, symptom_ids: [@symptom.id], created_at: 1.week.ago

    [
      { created: 1.month.ago, effects: 2 },
      { created: 2.months.ago, effects: 1 },
      { created: 3.months.ago, effects: 0 }
    ].each { |p| create :pack, user: @user, effects: @effects.first(p[:effects]), created_at: p[:created] }

    @result = GeneratePack.call(user: @user)
  end

  test 'the interaction is a success' do
    assert @result.success?
  end

  test 'the correct effects are assigned' do
    assert_operator @user.latest_pack.created_at, :>, 1.day.ago
    assert_equal @user.latest_pack.effects.sort, @effects.last(3).sort
  end

  test 'the correct effects are blacklisted' do
    assert_includes @user.blacklisted_effects, @effects[0]
    assert_equal @user.blacklisted_effects.count, 1
  end
end
