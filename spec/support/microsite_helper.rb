class MicrositeHelper
  include Capybara::DSL

  def submit_basics_step(
    funding_type: "Don't know",
    total_costs: 10_000,
    org_type: 'A registered charity',
    charity_number: '123456',
    country: 'United Kingdom'
  )
    select funding_type
    fill_in :basics_step_total_costs, with: total_costs
    select org_type
    fill_in :basics_step_charity_number, with: charity_number
    select country, match: :first
    click_button 'Next'
    self
  end

  def submit_eligibility_step
    select 'Less than 3 years'
    select '1 - 5', from: :eligibility_step_volunteers
    select 'An entire country'
    click_button 'Next'
    self
  end

  def submit_pre_results
    fill_in :pre_results_step_email, with: 'email@example.com'
    click_button 'Next'
    self
  end
end