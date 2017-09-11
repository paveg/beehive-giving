FactoryGirl.define do
  factory :priority do
    sequence(:details) { |n| "Random priority #{n}" }

    factory :recipient_priority, class: 'Priority' do
      category 'Organisation'
    end
  end
end
