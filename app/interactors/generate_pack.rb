class GeneratePack
  include Interactor

  context_requires user: User

  delegate :user, to: :context

  def call
    context.fail!(errors: ["User #{context.user.id} needs at least one check in."]) unless valid_user?
    generate_pack!
  end

  private

    def generate_pack!
      Pack.create user: user
      symptoms.map do |symptom|
        generator.append_for(symptom)
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

    def generator
      PackGenerator.new(user)
    end
end
