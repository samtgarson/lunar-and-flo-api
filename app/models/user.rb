class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :check_ins, dependent: :destroy
  has_many :packs, dependent: :destroy

  class << self
    def needs_new_pack
      joins(:packs)
        .where('packs.created_at = (SELECT MAX(packs.created_at) FROM packs WHERE packs.user_id = users.id)')
        .where('packs.created_at <= ?', 1.month.ago)
    end
  end

  def latest_pack
    packs.order(created_at: :desc).first if packs.any?
  end
end
