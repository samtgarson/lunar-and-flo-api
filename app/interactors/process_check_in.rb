class ProcessCheckIn
  include Interactor

  def call
    if created_check_ins.all?(&:valid?)
      context.check_ins = created_check_ins.each(&:save)
    else
      context.fail!(failed_symptoms: failed_check_ins)
    end
  end

  private

    def created_check_ins
      @created_check_ins ||= context.symptom_ids.map do |symptom_id|
        CheckIn.new(user: context.user, symptom_id: symptom_id)
      end
    end

    def failed_check_ins
      context.symptom_ids - created_check_ins.select(&:valid?).map(&:symptom_id)
    end
end
