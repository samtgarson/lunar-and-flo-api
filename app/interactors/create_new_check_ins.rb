class CreateNewCheckIns
  include Interactor

  context_requires user_id: String, symptom_ids: Array

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
        CheckIn.new(user_id: context.user_id, symptom_id: symptom_id, location: location)
      end
    end

    def failed_check_ins
      context.symptom_ids - created_check_ins.select(&:valid?).map(&:symptom_id)
    end

    def location
      @location ||= Location.create(lat: context.lat, lng: context.lng) if location_present?
    end

    def location_present?
      context.lat.present? && context.lng.present?
    end
end
