class PackGenerator
  attr_accessor :user, :pack, :symptom

  def initialize(user, pack)
    @user = user
    @pack = pack
  end

  def append_for(symptom)
    @symptom = symptom
    pack.effects << (new_effect || blacklisted_effect)

    ineffective_effects.each { |effect| user.blacklist! effect }
  end

  private

    def blacklisted_effect
      effect = user.blacklisted_effects.where(symptom: symptom).where.not(id: pack.effects.pluck(:id)).sample
      user.unblacklist!(effect)
      effect
    end

    def new_effect
      [previous_effects, symptom.effects].detect do |query|
        effects = query.where.not(id: disallowed_effect_ids)
        break effects.sample if effects.any?
      end
    end

    def previous_effects
      return Effect.where(id: nil) unless previous_packs.any?
      @previous_effects ||= previous_packs.first.effects.where(symptom: symptom)
    end

    def ineffective_effects
      @ineffective_effects ||= previous_effects.select(&method(:no_longer_effective?))
    end

    def no_longer_effective?(effect)
      first_occurrence_of(effect) <= effect.effectiveness_days.days.ago
    end

    def first_occurrence_of(effect)
      previous_packs.reduce(DateTime.current) do |date, pack|
        break date unless pack.effects.include?(effect)
        pack.created_at
      end
    end

    def disallowed_effect_ids
      pack.effects.pluck(:id) + user.blacklisted_effects.pluck(:id) + ineffective_effects.map(&:id)
    end

    def previous_packs
      user.packs.where.not(id: pack.id).order(created_at: :desc)
    end
end
