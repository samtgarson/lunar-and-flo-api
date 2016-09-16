class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :check_ins, dependent: :destroy
  has_many :packs, dependent: :destroy

  def latest_pack
    packs.order(created_at: :desc).first if packs.any?
  end
end
