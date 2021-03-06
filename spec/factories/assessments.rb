FactoryBot.define do
  factory :assessment, aliases: [:incomplete] do
    association :fund, strategy: :build
    association :proposal, strategy: :build
    association :recipient, strategy: :build

    after(:build) do |assessment, _evaluator|
      assessment.valid?
    end

    factory :eligible do
      eligibility_amount               ELIGIBLE
      eligibility_location             ELIGIBLE
      eligibility_proposal_categories  ELIGIBLE
      eligibility_quiz                 ELIGIBLE
      eligibility_recipient_categories ELIGIBLE

      suitability_quiz                 ELIGIBLE
      factory :ineligible do
        eligibility_amount INELIGIBLE
      end
    end
  end
end
