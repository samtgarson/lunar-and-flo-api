class ApiClient < ApplicationRecord
  validates :secret_key, presence: true

  before_validation :generate_secret_key

  def generate_secret_key
    self.secret_key = ApiAuth.generate_secret_key if self.secret_key.nil?
  end
end
