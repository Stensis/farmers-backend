class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :validatable,
       :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  #  validations
   has_many :notifications
   has_many :reviews, dependent: :destroy

   validates :email, uniqueness: true


  ROLES = %w[Admin Buyer Farmer].freeze

  validates :role, inclusion: { in: ROLES }

  def admin?
    role == 'Admin'
  end

  def buyer?
    role == 'Buyer'
  end

  def farmer?
    role == 'Farmer'
  end
end
