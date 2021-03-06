class Question < ApplicationRecord
  scope :grouped, ->(type, group) { where(criterion_type: type, group: group) }
  belongs_to :criterion, polymorphic: true
  belongs_to :fund, touch: true
  has_many :answers, through: :criterion
end
