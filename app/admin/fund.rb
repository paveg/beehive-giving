ActiveAdmin.register Fund do
  config.per_page = 100

  permit_params :funder_id, :type_of_fund, :name, :description, :open_call,
                :active, :currency, :application_link, :key_criteria,
                :match_funding_restrictions, :payment_procedure,
                :restrictions_known, :skip_beehive_data, :open_data,
                :period_start, :period_end, :grant_count,
                :amount_awarded_distribution, :award_month_distribution,
                :country_distribution, :sources, :national,
                :org_type_distribution, :income_distribution, :slug,
                :geographic_scale_limited, country_ids: [], district_ids: [],
                                           restriction_ids: [], tags: []

  controller do
    def find_resource
      Fund.find_by(slug: params[:id])
    end
  end

  index do
    selectable_column
    column :slug
    column :active
    # column :period_start
    column 'year end' do |o|
      o&.period_end&.strftime('%Y')
    end
    column 'org_type' do |fund|
      check_presence(fund, 'org_type_distribution')
    end
    column 'income' do |fund|
      check_presence(fund, 'income_distribution')
    end
    column :geographic_scale_limited
    column :national
    column :districts do |fund|
      fund.districts.count
    end
    actions
  end

  filter :funder, input_html: { class: 'chosen-select' }
  filter :slug
  filter :active
  filter :open_data
  filter :updated_at

  show do
    attributes_table do
      row :slug
      row :funder do |fund|
        link_to fund.funder.name, [:admin, fund.funder]
      end
      row :name
      row :type_of_fund
      row :name
      row :description
      row :open_call
      row :active
      row :currency
      row :application_link
      row :key_criteria
      # row :match_funding_restrictions
      # row :payment_procedure
      row :restrictions_known
      row :restrictions do |fund|
        fund.restrictions.each do |r|
          li r.details
        end
      end
      if fund.open_data
        row :open_data
        row :sources
        row :period_start
        row :period_end
        row :grant_count
        # row :recipient_count
        # row :amount_awarded_sum
        # row :amount_awarded_mean
        # row :amount_awarded_median
        # row :amount_awarded_min
        # row :amount_awarded_max
        row :amount_awarded_distribution
        # row :duration_awarded_months_mean
        # row :duration_awarded_months_median
        # row :duration_awarded_months_min
        # row :duration_awarded_months_max
        # row :duration_awarded_months_distribution
        row :award_month_distribution
        row :org_type_distribution
        # row :operating_for_distribution
        row :income_distribution
        # row :employees_distribution
        # row :volunteers_distribution
        # row :gender_distribution
        # row :age_group_distribution
        # row :beneficiary_distribution
        # row :geographic_scale_distribution
        row :country_distribution
        # row :district_distribution
      end
    end
  end

  form do |f|
    f.inputs do
      inputs 'Basics' do
        f.input :slug
        f.input :funder, input_html: { class: 'chosen-select' }
        f.input :type_of_fund, input_html: { value: 'Grant' }
        f.input :name
        f.input :description
        f.input :open_call
        f.input :active
        f.input :currency, input_html: { value: 'GBP' }
        f.input :application_link
        f.input :key_criteria
        # f.input :match_funding_restrictions
        # f.input :payment_procedure
        f.input :tags, as: :select, collection: Fund.pluck(:tags).flatten.uniq,
                       input_html: { multiple: true, class: 'chosen-select' }
      end

      inputs 'Restrictions' do
        f.input :restrictions_known
        f.input :restrictions, collection: Restriction.pluck(:details, :id),
                               input_html: { multiple: true,
                                             class: 'chosen-select' }
      end

      # inputs 'Amounts' do
      #   f.input :amount_known
      #     f.input :amount_min_limited
      #       f.input :amount_min
      #     f.input :amount_max_limited
      #       f.input :amount_max
      #   f.input :amount_notes
      # end

      # inputs 'Durations' do
      #   f.input :duration_months_known
      #     f.input :duration_months_min_limited
      #       f.input :duration_months_min
      #     f.input :duration_months_max_limited
      #       f.input :duration_months_max
      #   f.input :duration_months_notes
      # end

      # f.input :decision_in_months

      # inputs 'Contact' do
      #   f.input :accepts_calls_known
      #     f.input :accepts_calls
      #       f.input :contact_number
      #   f.input :contact_email
      # end
      #
      inputs 'Geography' do
        f.input :countries, collection: Country.pluck(:name, :id),
                            input_html: { multiple: true,
                                          class: 'chosen-select' }
        f.input :geographic_scale_limited
        f.input :national
        f.input :districts, collection: District.pluck(:name, :id),
                            input_html: { multiple: true,
                                          class: 'chosen-select' }
      end

      # f.input :restrictions_known # boolean

      inputs 'Open Data' do
        f.input :skip_beehive_data, as: :boolean
        f.input :open_data
        f.input :sources
        f.input :period_start
        f.input :period_end

        # Overview
        f.input :grant_count
        # TODO: f.input :recipient_count

        # TODO: f.input :amount_awarded_sum
        # TODO: f.input :amount_awarded_mean
        # TODO: f.input :amount_awarded_median
        # TODO: f.input :amount_awarded_min
        # TODO: f.input :amount_awarded_max
        f.input :amount_awarded_distribution

        # TODO: f.input :duration_awarded_months_mean
        # TODO: f.input :duration_awarded_months_median
        # TODO: f.input :duration_awarded_months_min
        # TODO: f.input :duration_awarded_months_max
        # TODO: f.input :duration_awarded_months_distribution
        f.input :award_month_distribution

        # Recipient
        f.input :org_type_distribution
        # TODO: f.input :operating_for_distribution
        f.input :income_distribution
        # TODO: f.input :employees_distribution
        # TODO: f.input :volunteers_distribution

        # Beneficiary
        # TODO: f.input :gender_distribution
        # TODO: f.input :age_group_distribution
        # TODO: f.input :beneficiary_distribution

        # Location
        # TODO: f.input :geographic_scale_distribution
        f.input :country_distribution
        # TODO: f.input :district_distribution
      end
    end
    f.actions
  end
end
