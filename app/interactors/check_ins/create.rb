class CheckIns::Create
  include Interactor

  context_requires user: User, symptom_ids: Array #lat: Float, lng: Float, period: Boolean

  def call
    if failed_check_in_symptoms.any?
      context.fail!(errors: { failed_symptoms: failed_check_in_symptoms })
    else
      check_in_symptoms.each(&:save)
      context.check_in = check_in
    end
  end

  def rollback
    context.check_in.destroy
  end

  private

    def check_in
      @check_in ||= CheckIn.create(user_id: context.user.id, lat: context.lat, lng: context.lng, period: context.period)
    end

    def check_in_symptoms
      @check_in_symptoms ||= context.symptom_ids.map do |symptom_id|
        CheckInSymptom.new(check_in: check_in, symptom_id: symptom_id)
      end
    end

    def failed_check_in_symptoms
      @failed_check_in_symptoms ||= context.symptom_ids - check_in_symptoms.select(&:valid?).map(&:symptom_id)
    end
end
