# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  full_name       :string           not null
#  address         :string
#  city            :string
#  country         :string
#  role            :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_secure_password
  has_many :registers

  enum role: [:admin, :employee]

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :full_name, presence: true, length: { maximum: 30 }
  validates :role, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
