require 'test_helper'

class GeneratePackTest < ActiveSupport::TestCase
  setup do
    @user = create(:user)
    @generator = stub(append_for: true, pack: build(:pack))
    PackGenerator.stubs(:new).returns(@generator)
  end

  def call_context!
    @context ||= GeneratePack.call(user: @user)
  end

  def assert_appends_three_times
    assert_received(@generator, :append_for) { |x| x.times(3) }
  end

  test 'it provides a pack for a user with many check ins' do
    generate_check_ins(4, @user, physical: true)
    call_context!

    assert_appends_three_times
  end

  test 'it provides a pack for a user with 1 symptom' do
    generate_check_ins(1, @user, physical: true)
    call_context!

    assert_appends_three_times
  end

  test 'it fails for users with no check ins' do
    call_context!

    assert @context.failure?
  end
end
