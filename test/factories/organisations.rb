FactoryGirl.define do
  factory :recipient, class: Recipient do
    transient do
      n  { rand(1000) }
    end
    name "ACME"
    mission "mission"
    contact_number "01234 567 890"
    website "www.acme.com"
    street_address "123 street address"
    city "City"
    region "Region"
    postal_code "A1 B2"
    country "United Kingdom"
    status Organisation::STATUS.first
    registered true
    charity_number { "1AB1C#{n}" }
    company_number { "1AB1C#{n}" }
    founded_on "01/01/2014"
    registered_on "01/01/2015"
  end

  factory :organisation, class: Recipient do
    transient do
      n 1
    end
    name { "Random #{n}" }
    mission "mission"
    contact_number "01234 567 890"
    website { "www.random#{n}.com" }
    street_address "123 street address"
    city "City"
    region "Region"
    postal_code "A1 B2"
    country "United Kingdom"
    status Organisation::STATUS.first
    registered true
    charity_number "1AB1C1"
    company_number "1AB1C1"
    founded_on "01/01/2015"
    registered_on "01/01/2015"
  end

  factory :blank_org, class: Recipient do
  end
end
