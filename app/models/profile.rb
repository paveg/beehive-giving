class Profile < ActiveRecord::Base

  before_validation :allowed_years, unless: Proc.new { |profile| profile.year.nil? }

  belongs_to :organisation

  has_and_belongs_to_many :beneficiaries
  has_and_belongs_to_many :implementations
  has_and_belongs_to_many :implementors
  has_and_belongs_to_many :countries
  has_and_belongs_to_many :districts

  VALID_YEARS = ((Date.today.year-3)..(Date.today.year)).to_a.reverse
  GENDERS = ['All genders', 'Female', 'Male', 'Transgender', 'Other']

  include Workflow
  workflow_column :state
  workflow do
    state :beneficiaries do
      event :next_step, :transitions_to => :location
    end
    state :location do
      event :next_step, :transitions_to => :team
    end
    state :team do
      event :next_step, :transitions_to => :work
    end
    state :work do
      event :next_step, :transitions_to => :finance
    end
    state :finance do
      event :next_step, :transitions_to => :complete
    end
    state :complete
  end

  ## beneficiaries state validations

  validates :year, uniqueness: { scope: :organisation_id,
            message: 'only one is allowed per year', if: 'self.beneficiaries?' }

  validates :year, inclusion: { in: VALID_YEARS }, if: 'self.beneficiaries?'

  validates :gender, inclusion: { in: GENDERS }, if: 'self.beneficiaries?'

  validates :organisation, :year, :gender, :min_age, :max_age, :beneficiaries,
            presence: true, if: 'self.beneficiaries?'

  validates :min_age, :max_age, numericality: { only_integer: true,
            greater_than_or_equal_to: 0, if: 'self.beneficiaries?' }

  validates :min_age, numericality: { less_than_or_equal_to: :max_age,
            message: 'minimum age must be less than maximum age',
            unless: Proc.new { |profile| profile.min_age.nil? || profile.max_age.nil? },
            if: 'self.beneficiaries?' }

  validates :max_age, numericality: { greater_than_or_equal_to: :min_age || 0,
            message: 'maximum age must be greater than minimum age',
            unless: Proc.new { |profile| profile.min_age.nil? || profile.max_age.nil? },
            if: 'self.beneficiaries?' }

  ## location state validations

  validates :countries, :districts, presence: true, if: 'self.location?'

  ## team state validations

  validates :staff_count, :volunteer_count, :trustee_count, :implementors,
            presence: true, if: 'self.team?'

  validates :staff_count, :volunteer_count, :trustee_count,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
            if: 'self.team?' }

  validates :volunteer_count, numericality: { greater_than: 0,
            message: 'must have at least one volunteer if no staff',
            unless: Proc.new { |profile| (profile.staff_count > 0 || profile.staff_count != 0) },
            if: 'self.team?' }

  validates :staff_count, numericality: { greater_than: 0,
            message: 'must have at least one member of staff if no volunteers',
            unless: Proc.new { |profile| (profile.volunteer_count > 0 || profile.volunteer_count != 0) },
            if: 'self.team?' }

  ## work state validations

  validates :implementations, :beneficiaries_count, presence: true,
            if: 'self.work?'

  validates :does_sell, inclusion: { in: [true, false] }, if: 'self.work?'

  validates :beneficiaries_count,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
            if: 'self.work?' }

  ## finance state validations

  validates :income, :expenditure, presence: true, if: 'self.finance?'

  validates :income, :expenditure,
            numericality: { only_integer: true, greater_than_or_equal_to: 0,
            if: 'self.finance?' }

  def allowed_years
    if organisation.founded_on
      if organisation.founded_on.year.to_i > year
        errors.add(:year, "you can't make a profile before #{organisation.founded_on.year} because that's when your organisation was founded")
      end
    end
  end

end
