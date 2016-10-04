class CheckIns::Process
  include Interactor::Organizer

  organize CheckIns::Create, CheckIns::AttachMetaData
end
