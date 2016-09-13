class UserHistory
  include Interactor

  DATE_FORMAT = '%Y-%m-%d'.freeze

  context_requires :from, :to, user: User

  def call
    context.history = check_ins
  end

  private

    def check_ins
      days.each_with_object({}) do |date, hash|
        hash[date.strftime(DATE_FORMAT)] = context.user.check_ins.on_day(date).first
      end
    end

    def days
      @days ||= from..to
    end

    def from
      context.from.to_date
    end

    def to
      context.to.to_date
    end
end
