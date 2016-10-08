class CheckIns::Onboard
  include Interactor

  context_requires :last_period, :cycle_length, :period_length, user: User

  before do
    context.last_period = context.last_period.to_date
    context.cycle_length = context.cycle_length.to_i
    context.period_length = context.period_length.to_i
  end

  def call
    period_starts.each(&method(:create_check_ins))
  end

  private

    def period_starts
      [
        context.last_period,
        context.last_period - context.cycle_length.days
      ]
    end

    def create_check_ins(date)
      (date..date + period_length).each do |d|
        break if d >= Date.current
        CheckIn.create user: context.user, created_at: d, period: true
      end
    end

    def period_length
      (context.period_length - 1).days
    end
end
