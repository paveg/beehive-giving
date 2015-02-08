ActiveAdmin.register Grant do
  permit_params :funding_stream, :grant_type, :attention_how, :amount_awarded,
  :amount_applied, :installments, :approved_on, :start_on, :end_on, :attention_on, :applied_on,
  :recipient_id, :funder_id

  index do
    column "Organisation", :recipient do |grant|
      link_to grant.recipient.name, [:admin, grant.recipient]
    end
    column "Funder", :funder do |grant|
      link_to grant.funder.name, [:admin, grant.funder]
    end
    column :amount_awarded
    actions
  end
end