class Users::Onboard
  include Interactor::Organizer

  organize CheckIns::Onboard, CheckIns::Process, Packs::Generate
end
