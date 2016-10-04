class Users::Onboard
  include Interactor::Organizer

  context_requires :last_period, :cycle_length, :period_length, user: User, symptom_ids: Array

  organize CheckIns::Process, Packs::Generate

end
