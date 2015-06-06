ActiveAdmin.register FundingStream do
  config.sort_order = 'created_at_asc'
  config.per_page = 1000

  permit_params :label, :group, funder_ids: [], restriction_ids: []

  form do |f|
    f.inputs do
      f.input :label, label: 'Funding stream'
      f.input :funders, collection: Funder.order('name ASC'), input_html: {multiple: true, class: 'chosen-select'}, member_label: :name, label: 'Funders'
      f.input :restrictions, collection: Restriction.order('details ASC'), input_html: {multiple: true, class: 'chosen-select'}, member_label: :details, label: 'Restrictions'
      f.input :group
    end
    f.actions
  end

  index do
    column("Funders") do |r|
      r.funders.each do |f|
        li f.name
      end
    end
    column "Funding stream", :label
    column("Restrictions") do |r|
      r.restrictions.each do |f|
        li f.details
      end
    end
    actions
  end

end