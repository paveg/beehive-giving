FactoryGirl.define do
  factory :eligibility do
    association :recipient, :factory => :recipient
    association :restriction, :factory => :restriction
    eligible true
  end

  factory :funding_stream do
    funders {FactoryGirl.create_list(:funder, 1)}
    restrictions {FactoryGirl.create_list(:restriction, 1)}
    label "Funding stream name"
  end
end
