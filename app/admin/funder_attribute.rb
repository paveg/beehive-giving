ActiveAdmin.register FunderAttribute do

  permit_params :funder_id, :year, :grant_count, :application_count, :enquiry_count,
  :funding_stream, :funding_size_average, :funding_size_min, :funding_size_max, :funding_duration_average,
  :funding_duration_min, :funding_duration_max, :funded_average_age, :funded_average_income,
  :funded_average_paid_staff, country_ids: [], approval_month_ids: [], funding_type_ids: [], beneficiary_ids: []

  index do
    selectable_column
    column :year
    column "Funder" do |attribute|
      link_to attribute.funder.name, [:admin, attribute.funder]
    end
    column :funding_stream
    column :grant_count
    column :application_count
    column :enquiry_count
    actions
  end

  filter :funder, input_html: {class: 'chosen-select'}
  filter :year, as: :select, collection: Profile::VALID_YEARS
  filter :funding_stream
  filter :updated_at

  show do
    attributes_table do
      row :year
      row "Funder" do |attribute|
        attribute.funder
      end
      row :funding_stream
      row :countries do |attribute|
        attribute.countries.each do |c|
          li c.name
        end
      end
      row :grant_count
      row :application_count
      row :enquiry_count
      row "Approval month(s)" do |attribute|
        attribute.approval_months.each do |t|
          li t.month
        end
      end
      row "Funding type(s)" do |attribute|
        attribute.funding_types.each do |t|
          li t.label
        end
      end
      row :funding_size_average
      row :funding_size_min
      row :funding_size_max
      row :funding_duration_average
      row :funding_duration_min
      row :funding_duration_max
      row :funded_average_age
      row :funded_average_income
      row :funded_average_paid_staff
    end
  end

  form do |f|
    f.inputs do
      f.input :year, as: :select, collection: Profile::VALID_YEARS
      f.input :funder, input_html: {class: 'chosen-select'}
      f.input :funding_stream, collection: Grant.pluck(:funding_stream).uniq << 'All', input_html: {class: 'chosen-select'}
      f.input :countries, as: :select, input_html: {multiple: true, class: 'chosen-select'}, member_label: :name, label: "Countries"
      f.input :grant_count
      f.input :application_count
      f.input :enquiry_count
      f.input :approval_months, as: :select, input_html: {multiple: true, class: 'chosen-select'}, member_label: :month, label: "Approval Month(s)"
      f.input :funding_types, as: :select, input_html: {multiple: true, class: 'chosen-select'}, member_label: :label, label: "Funding Type(s)"
      f.input :funding_size_average
      f.input :funding_size_min
      f.input :funding_size_max
      f.input :funding_duration_average
      f.input :funding_duration_min
      f.input :funding_duration_max
      f.input :funded_average_age
      f.input :funded_average_income
      f.input :funded_average_paid_staff
    end
    f.actions
  end

end
