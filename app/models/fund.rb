class Fund < ActiveRecord::Base
  scope :active, -> { distinct.where(active: true) }
  scope :inactive_ids, -> { where(active: false).pluck(:id) }

  belongs_to :funder

  has_many :recommendations, dependent: :destroy
  has_many :proposals, through: :recommendations

  has_many :enquiries, dependent: :destroy
  has_many :deadlines, dependent: :destroy
  # TODO: accepts_nested_attributes_for :deadlines, allow_destroy: true
  has_many :stages, dependent: :destroy
  # TODO: accepts_nested_attributes_for :stages

  has_and_belongs_to_many :countries
  has_and_belongs_to_many :districts
  has_and_belongs_to_many :funding_types
  has_and_belongs_to_many :restrictions
  accepts_nested_attributes_for :restrictions
  has_and_belongs_to_many :outcomes
  has_and_belongs_to_many :decision_makers

  validates :funder, :type_of_fund, :slug, :name, :description, :currency,
            :key_criteria, :application_link,
            presence: true

  validates :open_call, :active, :restrictions_known,
            inclusion: { in: [true, false] }

  validates :name, uniqueness: { scope: :funder }

  # TODO: validations
  # validates :amount_min_limited, :amount_max_limited,
  #             inclusion: { in: [true, false] },
  #             if: :amount_known?
  #
  # validates :amount_min, presence: true, if: :amount_min_limited?
  # validates :amount_max, presence: true, if: :amount_max_limited?
  #
  # validates :duration_months_min_limited, :duration_months_max_limited,
  #             inclusion: { in: [true, false] },
  #             if: :duration_months_known?
  #
  # validates :duration_months_min, presence: true,
  #                                 if: :duration_months_min_limited?
  # validates :duration_months_max, presence: true,
  #                                 if: :duration_months_max_limited?
  #
  # validates :deadlines_known, :stages_known, inclusion: { in: [true, false] }
  #
  # validates :deadlines, presence: true,
  #             if: :deadlines_known? && :deadlines_limited?
  #
  # validates :stages, :stages_count, presence: true,
  #             if: :stages_known?
  #
  # validates :accepts_calls, presence: true, if: :accepts_calls_known?
  # validates :contact_number, presence: true, if: :accepts_calls?

  validates :geographic_scale,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: Proposal::AFFECT_GEO.first[1],
              less_than_or_equal_to: Proposal::AFFECT_GEO.last[1]
            }
  validates :countries, presence: true
  validates :restrictions, presence: true, if: :restrictions_known?
  validates :restrictions_known, presence: true, if: :restriction_ids?
  # validates :outcomes, presence: true, if: :outcomes_known?
  # validates :decision_makers, presence: true, if: :decision_makers_known?

  # with open_data

  validates :open_data, :period_start, :period_end,
            :amount_awarded_distribution, :award_month_distribution,
            :country_distribution, :sources,
            presence: true, if: :open_data?
  validates :grant_count, presence: true,
                          numericality: { greater_than_or_equal_to: 0 },
                          if: :open_data?

  validate :validate_sources, :validate_local, :validate_national

  # TODO: validations
  # validates :period_start, :period_end, :org_type_distribution,
  #           :operating_for_distribution, :income_distribution,
  #           :employees_distribution, :volunteers_distribution,
  #           :geographic_scale_distribution, :gender_distribution,
  #           :age_group_distribution, :beneficiary_distribution,
  #           :amount_awarded_distribution, :award_month_distribution,
  #           :country_distribution, :district_distribution,
  #             presence: true, if: :open_data?
  #
  # validates :grant_count, :recipient_count,
  #           :amount_awarded_sum, :amount_awarded_mean, :amount_awarded_median,
  #           :amount_awarded_min, :amount_awarded_max,
  #           :duration_awarded_months_mean, :duration_awarded_months_median,
  #           :duration_awarded_months_min, :duration_awarded_months_max,
  #           presence: true, numericality: { greater_than_or_equal_to: 0 },
  #           if: :open_data?

  validate :period_start_before_period_end, :period_end_in_past, if: :open_data?

  attr_accessor :skip_beehive_data

  before_validation :set_slug, unless: :slug
  before_validation :check_beehive_data,
                    if: proc { |o| o.skip_beehive_data.to_i.zero? }
  before_save :set_restriction_ids, if: :restrictions_known?

  def to_param
    slug
  end

  def short_name
    name.sub(' Fund', '')
  end

  def tags?
    tags.count.positive?
  end

  include JsonSetters

  private

    def set_slug
      self.slug = "#{funder.slug}-#{name.parameterize}" if funder
    end

    def period_end_in_past
      return unless period_end
      errors.add(:period_end, 'Period end must be in the past') if
        period_end > Time.zone.today
    end

    def period_start_before_period_end
      return unless period_start && period_end
      errors.add(:period_start, 'Period start must be before period end') if
        period_start > period_end
    end

    def check_beehive_data
      return unless open_data && slug
      options = {
        headers: {
          'Authorization' => 'Token token=' + ENV['BEEHIVE_DATA_TOKEN']
        }
      }
      resp = HTTParty.get(
        ENV['BEEHIVE_DATA_FUND_SUMMARY_ENDPOINT'] + slug, options
      )
      assign_attributes(resp.except('fund_slug')) if slug == resp['fund_slug']
    end

    def set_restriction_ids
      self[:restriction_ids] = restrictions.pluck(:id)
    end

    def validate_sources # TODO: refactor DRY
      sources.try(:each) do |k, v|
        errors.add(:sources, "Invalid URL - key: #{k}") if
          k !~ %r{https?://}
        errors.add(:sources, "Invalid URL - value: #{v}") if
          v !~ %r{https?://}
      end
    end

    def validate_local
      return if geographic_scale > 1

      return errors.add(:geographic_scale_limited, 'must be true for local fund') if
        geographic_scale_limited == false

      return errors.add(:districts, "can't be blank") if districts.empty?

      errors.add(:districts, 'cannot select all districts for local fund') if
        all_districts_selected
    end

    def validate_national
      return unless geographic_scale == 2

      if geographic_scale_limited
        errors.add(:districts, 'must select all or none for countries') unless
          districts.empty? || all_districts_selected
      else
        errors.add(:districts, 'must be blank') unless districts.empty?
      end
    end

    def all_districts_selected
      all_district_ids = Country.joins(:districts).where(id: country_ids)
                                .pluck('districts.id').uniq
      all_district_ids.count == (all_district_ids & district_ids).count
    end
end
