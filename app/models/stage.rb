class Stage < ActiveRecord::Base
  STAGES = [
    'Speak with member of staff',
    'Expression of interest',
    'Application form',
    'Online application form',
    'Interview',
    'Pitch',
    'Video',
    'Phone call',
    'Meeting',
    'Funding approved',
    'Funding awarded'
  ].freeze

  belongs_to :fund

  validates :fund, :name, :position, presence: true
  validates :name, inclusion: { in: STAGES }, uniqueness: { scope: :fund }
  validates :feedback_provided, inclusion: { in: [true, false] }
  validates :position, numericality: { greater_than: 0 }, uniqueness: { scope: :fund }
  validate :position_in_sequence

  private

    def position_in_sequence
      last_stage = Stage.where('fund_id = ? AND id != ?', fund_id, id).order(:position).last
      return unless last_stage && position > (last_stage.position + 1)
      errors.add(:position, 'Position not in sequence')
    end
end
