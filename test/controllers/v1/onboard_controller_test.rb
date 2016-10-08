require 'test_helper'

class V1::OnboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
    @symptoms = create_list :symptom, 3, supplement_count: 1
    @onboard_attributes = {
      symptom_ids: @symptoms.map(&:id),
      last_period: 12.days.ago,
      cycle_length: 28,
      period_length: 5
    }

    post user_onboard_url(user_id: @user.id, format: :json), params: @onboard_attributes
  end

  test 'should be a success' do
    assert_response :success
  end

  test 'should create a check in for symptoms' do
    assert_equal 1, @user.check_ins.where('created_at > ?', 1.day.ago).count
    assert_matching @symptoms.map(&:id), @user.check_ins.where('created_at > ?', 1.day.ago).first.symptoms.pluck(:id)
  end

  test 'should create a check in for periods' do
    skip('Need to write an interactor for dealing with periods')
    assert_equal @onboard_attributes[:period_length], @user.check_ins.where('created_at < ?', 1.day.ago).where('created_at > ?', 13.days.ago).count
    assert_equal @onboard_attributes[:period_length], @user.check_ins.where('created_at < ?', 13.day.ago).count
  end

  test 'should create a pack for the user' do
    assert @user.latest_pack.present?
  end

end
