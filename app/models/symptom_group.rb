class SymptomGroup < ApplicationRecord
  has_many :symptoms

  validates :name, presence: true

  enum icon: %i(happy sad angry confused thoughtful caring)
  enum category: %i(physical mood)

  class << self
    def normalize_categories(categories)
      return SymptomGroup.categories.values unless categories.present?
      categories = [categories] unless categories.is_a?(Array)
      categories.map do |cat|
        cat.is_a?(Integer) ? cat : self.categories[cat]
      end
    end
  end
end
