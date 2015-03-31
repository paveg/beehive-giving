ActiveAdmin.register Grant do
  config.sort_order = 'created_at_asc'
  config.per_page = 1000

  permit_params :funding_stream, :grant_type, :attention_how, :amount_awarded,
  :amount_applied, :installments, :approved_on, :start_on, :end_on, :attention_on, :applied_on,
  :recipient_id, :funder_id, :days_from_start_to_end, :country

  index do
    selectable_column
    column "Organisation", :recipient do |grant|
      if grant.recipient
        link_to grant.recipient.name, [:admin, grant.recipient]
      end
    end
    column "Funder", :funder do |grant|
      if grant.funder
        link_to grant.funder.name, [:admin, grant.funder]
      end
    end
    column :amount_awarded
    actions
  end

  show do
    attributes_table do
      row "Funder", :funder do |grant|
        if grant.recipient
          link_to grant.recipient.name, [:admin, grant.recipient]
        end
      end
      row "Recipient", :recipient do |grant|
        if grant.funder
          link_to grant.funder.name, [:admin, grant.funder]
        end
      end
      row :funding_stream
      row :grant_type
      row :installments
      row :amount_awarded
      row :amount_applied
      row :attention_how
      row :attention_on
      row :applied_on
      row :approved_on
      row :start_on
      row :end_on
      row :country
    end
  end

  form do |f|
    f.inputs do
      f.input :funder, required: true
      f.input :recipient, required: true
      f.input :funding_stream, collection: Grant::FUNDING_STREAM.map { |label| label }
      f.input :grant_type, collection: Grant::GRANT_TYPE.map { |label| label }
      f.input :installments
      f.input :amount_awarded
      f.input :amount_applied
      f.input :attention_how, collection: Grant::ATTENTION_HOW.map { |label| label }
      f.input :attention_on
      f.input :applied_on
      f.input :approved_on
      f.input :start_on
      f.input :end_on
      f.input :country
    end
    f.actions
  end
end
