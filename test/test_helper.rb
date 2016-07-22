ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include FactoryGirl::Syntax::Methods
  Geocoder.configure(:lookup => :test)
  Geocoder::Lookup::Test.add_stub(
    "A1 B2, GB", [{'latitude' => 40.7143528, 'longitude' => -74.0059731}])
  Geocoder::Lookup::Test.add_stub(
    "BS48 3PA, GB", [{'latitude' => 2, 'longitude' => 2}])
  Geocoder::Lookup::Test.add_stub(
    "GL6 0QL, GB", [{'latitude' => 1, 'longitude' => 1}])
  Geocoder::Lookup::Test.add_stub(
    "London Road, GB", [{'latitude' => 0, 'longitude' => 0}])
  Geocoder::Lookup::Test.add_stub(
    "SE1 7TP, GB", [{'latitude' => 3, 'longitude' => 3}])

  def seed_test_db
    FactoryGirl.reload
    # TODO: refactor add age_groups and beneficiaries
    @countries       = create_list(:country, 2)
    @uk_districts    = create_list(:district, 3, country: @countries.first)
    @kenya_districts = create_list(:kenya_district, 3, country: @countries.last)
    @districts       = @uk_districts + @kenya_districts
  end

  def setup_funds(num=1, save=false)
    FactoryGirl.reload
    seed_test_db
    @funder = create(:funder)
    @funds = build_list(:fund, num, funder: @funder)
    @funding_types = create_list(:funding_type, FundingType::FUNDING_TYPE.count)
    @restrictions = create_list(:restriction, 2)
    @outcomes = create_list(:outcome, 2)
    @decision_makers = create_list(:decision_maker, 2)
    @funds.each do |fund|
      fund.deadlines = create_list(:deadline, 2, fund: fund)
      fund.stages = create_list(:stage, 2, fund: fund)
      fund.funding_types = @funding_types
      fund.countries = @countries
      fund.districts = @uk_districts + @kenya_districts
      fund.restrictions = @restrictions
      fund.outcomes = @outcomes
      fund.decision_makers = @decision_makers
    end
    @funds.each { |f| f.save! } if save
  end
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include FactoryGirl::Syntax::Methods
  include Capybara::DSL
  include ShowMeTheCookies

  # Selenium
  Capybara.app_host = "http://localhost:4000"
  Capybara.server_host = "localhost"
  Capybara.server_port = "4000"

  setup do
    expire_cookies
  end

  def create_and_auth_user!(opts = {})
    @user = create(:user, opts)
    create_cookie(:auth_token, @user.auth_token)
  end

  def setup_funders(num, proposal=false)
    seed_test_db
    FactoryGirl.create_list(:beneficiary, num)
    FactoryGirl.create_list(:age_group, num)
    @funding_types = create_list(:funding_type, FundingType::FUNDING_TYPE.count)

    @funders = Array.new(num) { |i| create(:funder) }
    @grants = Array.new(num) do |i|
      create(:grants, funder: @funders[i], recipient: @recipient,
              countries: @countries, districts: @uk_districts + @kenya_districts
            )
    end
    @attributes = Array.new(num) { |i| create(:funder_attribute, funder: @funders[i],
                    beneficiaries: Beneficiary.limit(i+1),
                    age_groups: AgeGroup.limit(i+1),
                    countries: @countries,
                    districts: @uk_districts + @kenya_districts,
                    funding_types: @funding_types
                  ) }
    @restrictions = Array.new(3) { |i| create(:restriction) }
    @funding_streams = Array.new(num) { |i| create(:funding_stream, restrictions: @restrictions, funders: [@funders[i]]) }
    create_and_auth_user!(organisation: @recipient, user_email: 'email@email.com')

    @proposal = create(:proposal, recipient: @recipient,
                        beneficiaries: Beneficiary.all,
                        age_groups: AgeGroup.all,
                        countries: @countries,
                        districts: @uk_districts + @kenya_districts
                      ) if proposal
  end
end
