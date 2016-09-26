class PackGenerator
  attr_accessor :user, :pack, :symptom

  def initialize(user)
    @user = user
    @pack = Pack.new(user: user)
  end

  def append_for(symptom)
    @symptom = symptom
    pack.effects << (found_effect || new_effect)
  end

  private

    def new_effect
      allowed_effect_ids.each do |filter|
        effects = symptom.effects.where.not(id: filter)
        break effects.sample if effects.any?
      end
    end

    def found_effect
      return unless user.latest_pack.present?
      previous_effects.reduce do |effect, found|
        user.blacklist!(effect) and next(found) if first_occurrence_of(effect) <= effect.effectiveness_days.ago
        break effect
      end
    end

    def previous_effects
      @previous_effect ||= user.latest_pack.effects.where(symptom: symptom).not id: disallowed_effect_ids
    end

    def first_occurrence_of(effect)
      user.packs.order(created_at: :desc).reduce(DateTime.current) do |date, pack|
        break date unless pack.effects.include?(effect)
        pack.created_at
      end
    end

    def disallowed_effect_ids
      pack.effects.pluck(:id) + user.blacklisted_effects.pluck(:id)
    end

    def allowed_effect_ids
      [
        disallowed_effect_ids,
        pack.effects.pluck(:id),
        []
      ]
    end
end
