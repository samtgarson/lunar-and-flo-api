class GeneratePack
  include Interactor

  context_requires user: User

  delegate :user, to: :context

  def call
    context.fail!(errors: ["User #{context.user.id} needs at least one check in."]) unless valid_user?
    user.packs << new_pack
  end

  private

    def new_pack
      symptoms.each_with_object(Pack.new(user: user)) do |pack, symptom|
        EffectFinder.find(pack, symptom)
      end
    end

    def symptoms
      return @symptoms if @symptoms
      @symptoms = Symptom.for_user(user, physical: true).to_a
      @symptoms << @symptoms.first while @symptoms.count < 3
      @symptoms
    end

    def valid_user?
      user.check_ins.count >= 1
    end
end
