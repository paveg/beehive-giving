class Criterion < ApplicationRecord
  has_many :answers
  has_many :funds, through: :questions
  has_many :questions

  validates :category, inclusion: { in: %w[Proposal Recipient] }
  validates :details, presence: true, uniqueness: true

  def radio_button_values
    invert ? [['Yes', true], ['No', false]] : [['Yes', false], ['No', true]]
  end
end
