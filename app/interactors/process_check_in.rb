class ProcessCheckIn
  include Interactor::Organizer

  organize CreateCheckIn, AttachCheckInMetaData
end
