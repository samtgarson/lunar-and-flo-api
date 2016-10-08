class CheckInSymptom < ApplicationRecord
  belongs_to :check_in
  belongs_to :symptom
end
