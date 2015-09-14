ActiveAdmin.register Feedback do

  permit_params :user_id, :nps, :taken_away, :informs_decision, :other

  controller do
    def scoped_collection
      Feedback.includes(:user)
    end
  end

  index do
    column "Organisation", :user do |feedback|
      if feedback.user
        link_to feedback.user.organisation.name, [:admin, feedback.user.organisation]
      end
    end
    column "Contact", :user do |feedback|
      if feedback.user
        feedback.user.user_email
      end
    end
    column "Net Promoter Score", :nps
    column :taken_away
    column :informs_decision
    column :application_frequency
    column :grant_frequency
    column :marketing_frequency
    column :other
    column :created_at
  end
end
