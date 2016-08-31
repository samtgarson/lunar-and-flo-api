class ProcessCheckIn
  include Interactor

  def call
    if created_check_ins.all?(&:valid?)
      created_check_ins.each(&:save)
      context.check_ins = created_check_ins
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
