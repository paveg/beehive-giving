ActiveAdmin.register Funder do
  config.sort_order = 'created_at_asc'

  permit_params :name, :slug, :website, :charity_number, :company_number,
                :active, :microsite, :primary_colour, :headline_colour,
                :subtitle_colour

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  filter :name
  config.sort_order = 'name_asc'

  index do
    selectable_column
    column 'Funder', :name do |funder|
      link_to funder.name, [:admin, funder]
    end
    column :active
    column :microsite
    column :has_funds do |funder|
      funder.funds.count.positive?
    end
    column :funds do |funder|
      funder.funds.size
    end
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :slug
      row :name
      row :website
      row :charity_number
      row :company_number
      row :active
      row :microsite
      row :primary_colour
      row :headline_colour
      row :subtitle_colour
    end

    panel 'Funds' do
      table_for funder.funds do
        column :slug
        column :active
        column :microsite
        column :actions do |fund|
          link_to 'View', [:admin, fund]
          link_to 'Edit', [:edit_admin, fund]
        end
      end
    end
  end
end
