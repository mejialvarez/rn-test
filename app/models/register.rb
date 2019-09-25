# == Schema Information
#
# Table name: registers
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  occurred_at :datetime         not null
#  type        :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Register < ApplicationRecord
  self.inheritance_column = :_type_disabled
  belongs_to :user

  paginates_per 20

  enum type: [:in, :out]

  validates :type, presence: true
  validates :occurred_at, presence: true

  scope :for_user, -> (user_id) { where(user_id: user_id) }
  scope :ocurred_between, -> (start_date, end_date) { where("DATE(occurred_at) >= ? AND DATE(occurred_at) <= ?", start_date, end_date ) }
end
