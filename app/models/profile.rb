class Profile < ActiveRecord::Base
  belongs_to :organisation

  validates :organisation, presence: true
  validates :year, :gender, :currency, :goods_services, :who_pays, :who_buys,
            :min_age, :max_age, :income, :expenditure, :volunteer_count,
            :staff_count, :job_role_count, :department_count, :goods_count,
            :units_count, :services_count, :beneficiaries_count, presence: true
  validates :min_age, :max_age, :income, :expenditure, :volunteer_count,
            :staff_count, :job_role_count, :department_count, :goods_count,
            :units_count, :services_count, :beneficiaries_count,
            numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :year, uniqueness: {scope: :organisation_id, message: 'only one is allowed per year'}
end
