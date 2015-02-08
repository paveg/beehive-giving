ActiveAdmin.register Recipient do
  permit_params :name, :contact_number, :website,
  :street_address, :city, :region, :postal_code, :country, :charity_number,
  :company_number, :founded_on, :registered_on, :mission, :status, :registered, :active_on_beehive, organisation_ids: []

  controller do
    def find_resource
      Recipient.where(slug: params[:id]).first!
    end
  end

  index do
    column "Organisation", :name do |recipient|
      link_to recipient.name, [:admin, recipient]
    end
    column :country
    column ("Grants"){|f| f.grants.count }
    column ("Requests"){|f| f.features.count }
    actions
  end
end