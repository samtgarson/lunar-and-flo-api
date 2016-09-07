class CreateCheckIn
  include Interactor

  context_requires user_id: String, symptom_ids: Array

  def call
    if failed_check_in_symptoms.any?
      context.fail!(failed_symptoms: failed_check_in_symptoms)
    else
      check_in_symptoms.each(&:save)
      context.check_in = check_in
    end
  end

  def rollback
    context.check_in_symptoms.each(&:destroy)
  end

  private

    def check_in
      @check_in ||= CheckIn.create(user_id: context.user_id, location: location)
    end

    def check_in_symptoms
      @check_in_symptoms ||= context.symptom_ids.map do |symptom_id|
        CheckInSymptom.new(check_in: check_in, symptom_id: symptom_id)
      end
    end

    def failed_check_in_symptoms
      @failed_check_in_symptoms ||= context.symptom_ids - check_in_symptoms.select(&:valid?).map(&:symptom_id)
    end

    def location
      @location ||= Location.create(lat: context.lat, lng: context.lng) if location_present?
    end

    def location_present?
      context.lat.present? && context.lng.present?
    end
end
