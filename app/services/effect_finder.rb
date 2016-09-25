class EffectFinder
  attr_accessor :user, :pack, :symptom

  def find(pack, symptom)
    @pack = pack
    @symptom = symptom

    pack.effects << found_effect || new_effect
  end

  private

    def new_effect

    end

    def found_effect
      previous_effects.reduce do |effect, found|
        user.blacklist!(effect) and next(found) if first_occurrence_of(effect) <= effect.effectiveness_days.ago 
        break effect
      end
    end

    def previous_effects
      @previous_effect ||= user.latest_pack.effects.where(symptom: symptom).not id: pack.effects.pluck(:id) + user.blacklisted_effects.pluck(:id)
    end

    def first_occurrence_of(effect)
      user.packs.order(created_at: :desc).reduce(DateTime.current) do |date, pack|
        break date unless pack.effects.include?(effect)
        pack.created_at
      end
    end
end
