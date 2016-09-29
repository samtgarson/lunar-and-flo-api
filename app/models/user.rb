class User < ApplicationRecord
  has_many :check_ins, dependent: :destroy
  has_many :packs, -> { order 'created_at desc' }, dependent: :destroy
  has_many :blacklisted_effects, class_name: 'Effect', foreign_key: :user_id

  validates :email, uniqueness: true, if: 'email.present?'

  class << self
    def needs_new_pack
      joins(:packs)
        .where('packs.created_at = (SELECT MAX(packs.created_at) FROM packs WHERE packs.user_id = users.id)')
        .where('packs.created_at <= ?', 1.month.ago)
    end
  end

  def latest_pack
    packs.joins(:effects).group(:id).first
  end

  def blacklist!(effect)
    blacklisted_effects << effect
  end

  def unblacklist!(effect)
    blacklisted_effects.delete effect
  end
end
