require "test_helper"

class RecipientFeedbackTest < ActionDispatch::IntegrationTest

  setup do
    @recipient = create(:recipient)
    @funder = create(:funder)
  end

  test "recipient with no feedback can see link" do
    create_and_auth_user!(:organisation => @recipient)
    visit "/funders"
    assert page.has_content?("Feedback", count: 2)
  end

  test "no feedback button on new feedback action" do
    create_and_auth_user!(:organisation => @recipient)
    visit '/funders'
    assert page.has_content?("Feedback", count: 2)
    visit '/feedback/new'
    assert_not page.has_content?("Feedback", count: 2)
  end

  test "recipient with feedback cannot see link" do
    create_and_auth_user!(:organisation => @recipient)
    create(:feedback, user: @recipient.users.first)
    visit "/funders"
    assert page.has_content?("Feedback", count: 0)
  end

  test "feedback prompt before third funder unlock" do
    @recipient.founded_on = "01/01/2005"
    @funders, @funding_streams = [], []

    4.times do |i|
      @funder = create(:funder, :active_on_beehive => true)
      @funders << @funder
      create(:funder_attribute, :funder => @funder, :funding_stream => "All", :grant_count => 1)
    end

    4.times do |i|
      @restriction1 = create(:restriction)
      @restriction2 = create(:restriction)

      @funding_stream = create(:funding_stream, :restrictions => [@restriction1, @restriction2], :funders => [@funders[i]])
      @funding_streams << @funding_stream
    end

    @profiles = 3.times { |i| create(:profile, :organisation => @recipient, :year => 2015-i) }

    create_and_auth_user!(:organisation => @recipient)

    # First funder unlock
    @recipient.unlock_funder!(@funders[0])

    # Second funder unlock
    @recipient.unlock_funder!(@funders[1])

    # Visiting third funders pages redirects if no feedback
    visit recipient_eligibility_path(@funders[2])
    select('No', :from => 'recipient_eligibilities_attributes_0_eligible')
    select('No', :from => 'recipient_eligibilities_attributes_1_eligible')
    click_button('Check eligibility (1 left)')
    assert_equal new_feedback_path, current_path

    # completing feedback form redirects to funder
    within("#new_feedback") do
      select("10 - Extremely likely", :from => "feedback_nps")
      select("10 - Very dissatisfied", :from => "feedback_taken_away")
      select("10 - Strongly agree", :from => "feedback_informs_decision")
      select(Feedback::APP_AND_GRANT_FREQUENCY.sample, :from => "feedback_application_frequency")
      select(Feedback::APP_AND_GRANT_FREQUENCY.sample, :from => "feedback_grant_frequency")
      select(Feedback::MARKETING_FREQUENCY.sample, :from => "feedback_marketing_frequency")
    end
    click_button("Submit feedback")
    assert_equal recipient_comparison_path(@funders[2]), current_path

    # Feedback only required for second unlock
    visit recipient_comparison_path(@funders[3])
    assert_equal recipient_comparison_path(@funders[3]), current_path
  end

  # # Selenium testing
  # test "recipient with no feedback can submit feedback" do
  #   # Capybara.current_driver = :selenium
  #
  #   @feedback = nil
  #
  #   # visit "/welcome"
  #   create_and_auth_user!(:organisation => @recipient)
  #   # within("ul > li:nth-child(2)") do
  #   #   click_link("Sign in")
  #   # end
  #   # within("#sign-in") do
  #   #   fill_in("email", :with => @user.user_email)
  #   #   fill_in("password", :with => @user.password)
  #   # end
  #   # click_button("Sign in")
  #
  #   visit "/funders"
  #   click_link("Feedback")
  #   within("#new_feedback") do
  #     select("10 - Extremely likely", :from => "feedback_nps")
  #     select("10 - Very dissatisfied", :from => "feedback_taken_away")
  #     select("10 - Strongly agree", :from => "feedback_informs_decision")
  #   end
  #   click_button("Submit feedback")
  #
  #   assert_not page.has_content?("Feedback")
  # end

  # test "recipient with feedback cannot submit feedback" do
  # end

end
