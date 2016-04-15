require 'test_helper'

class RecipientApproachFunderTest < ActionDispatch::IntegrationTest

  setup do
    @recipient = create(:recipient)
    setup_funders(3)
    create(:initial_proposal, recipient: @recipient)
  end

  test 'approach funder choice visible if eligible on comparison page' do
    @recipient.load_recommendation(@funders.first).update_attribute(:eligibility, 'Eligible')

    visit funder_path(@funders.first)
    assert page.has_content?('Apply')
  end

  test 'approach funder choice invisible if ineligible on comparison page' do
    @recipient.load_recommendation(@funders.first).update_attribute(:eligibility, 'Ineligible')

    visit funder_path(@funders.first)
    assert page.has_content?('Why ineligible?')
  end

end
