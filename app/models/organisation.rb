class Organisation < ActiveRecord::Base
  OPERATING_FOR = [
    ['Yet to start', 0],
    ['Less than 12 months', 1],
    ['Less than 3 years', 2],
    ['4 years or more', 3]
  ].freeze
  INCOME = [
    ['Less than £10k', 0],
    ['£10k - £100k', 1],
    ['£100k - £1m', 2],
    ['£1m - £10m', 3],
    ['£10m+', 4]
  ].freeze
  EMPLOYEES = [
    ['None', 0],
    ['1 - 5', 1],
    ['6 - 25', 2],
    ['26 - 50', 3],
    ['51 - 100', 4],
    ['101 - 250', 5],
    ['251 - 500', 6],
    ['500+', 7]
  ].freeze

  has_one :subscription, dependent: :destroy
  has_many :users, dependent: :destroy

  has_many :profiles, dependent: :destroy # TODO: deprecated

  geocoded_by :search_address
  after_validation :geocode,
                   if: :street_address_changed?,
                   unless: ->(o) { o.country != 'GB' }

  attr_accessor :skip_validation

  validates :income, :employees, :volunteers,
            presence: true, numericality: { greater_than_or_equal_to: 0 },
            unless: :skip_validation

  validates :income, inclusion: { in: INCOME.pluck(1) },
                     unless: :skip_validation

  validates :employees, :volunteers, inclusion: { in: EMPLOYEES.pluck(1) },
                                     unless: :skip_validation

  validates :org_type, :name, :status, :country, :operating_for,
            presence: true, unless: :skip_validation

  validates :org_type,
            inclusion: { in: (ORG_TYPES.pluck(1) - [-1]), message: 'please select a valid option' },
            unless: :skip_validation

  validates :operating_for,
            inclusion: { in: OPERATING_FOR.pluck(1), message: 'please select a valid option' },
            unless: :skip_validation

  validates :street_address,
            presence: true,
            if: :unregistered_org,
            unless: :skip_validation
  validates :charity_number,
            presence: true,
            if: proc { |o| [1,3].include? o.org_type },
            unless: :skip_validation
  validates :company_number,
            presence: true,
            if: proc { |o| [2,3,5].include? o.org_type },
            unless: :skip_validation

  validates :charity_number,
            uniqueness: { on: :create, scope: :company_number },
            allow_nil: true, allow_blank: true
  validates :company_number,
            uniqueness: { on: :create, scope: :charity_number },
            allow_nil: true, allow_blank: true

  validates :website, format: {
    with: URI.regexp(%w(http https)),
    message: 'enter a valid website address e.g. http://www.example.com'
  }, if: :website?

  validates :slug, uniqueness: true, presence: true

  validates :postal_code,
            presence: true,
            if: proc { |o| o.charity_name.present? || o.company_name.present? },
            unless: :skip_validation

  before_validation :set_slug, if: :should_set_slug?
  before_validation :clear_registration_numbers_if_unregistered
  after_create :create_subscription

  def name=(s)
    self[:name] = s.sub(s.first, s.first.upcase)
  end

  def charity_number=(s)
    self[:charity_number] = s.try(:strip)
  end

  def company_number=(s)
    self[:company_number] = s.try(:strip)
  end

  def to_param
    slug
  end

  def set_slug
    self.slug = generate_slug
  end

  def generate_slug(n = 1)
    return nil unless name
    candidate = name.downcase.gsub(/[^a-z0-9]+/, '-')
    candidate += "-#{n}" if n > 1
    return candidate unless Organisation.find_by(slug: candidate)
    generate_slug(n + 1)
  end

  def send_authorisation_email(user_to_authorise)
    UserMailer.request_access(self, user_to_authorise).deliver_now
  end

  def scrape_org
    case org_type
    when 1
      scrape_charity_data
    when 2
      lookup_company_data
    when 3
      scrape_charity_data
      lookup_company_data
    when 5
      lookup_company_data
    else
      self[:registered_on] = nil
    end
  end

  def find_with_reg_nos
    Organisation.find_by(
      charity_number: charity_number,
      company_number: company_number
    )
  end

  # TODO: refactor
  # def show_postal_code?
  #   scrape_charity_data && postal_code.blank?
  # end

  def create_subscription
    Subscription.create(organisation_id: id) if subscription.nil?
  end

  private

    def search_address
      if postal_code.present?
        [postal_code, country].join(', ')
      elsif street_address.present?
        [street_address, country].join(', ')
      end
    end

    def should_set_slug?
      slug.blank? || (name.present? && name_changed?)
    end

    def street_address_changed?
      street_address.present? ||
        (postal_code.present? && postal_code_changed?)
    end

    def unregistered_org
      org_type.nil? || (org_type.zero? || org_type == 4)
    end

    def clear_registration_numbers_if_unregistered
      return unless unregistered_org
      self.charity_number = nil
      self.company_number = nil
    end

    def charity_commission_url
      'http://beta.charitycommission.gov.uk/charity-details/?regid=' +
        CGI.escape(charity_number) + '&subid=0'
    end

    def scrape_charity_data
      require 'open-uri'
      response = begin
                   Nokogiri::HTML(open(charity_commission_url, open_timeout: 3))
                 rescue
                   nil
                 end
      if response && response.at_css('h1') # TODO: test
        # TODO: refactor
        company_no_scrape = response.at_css('#ContentPlaceHolderDefault_cp_content_ctl00_CharityDetails_4_TabContainer1_tpOverview_plCompanyNumber')
        name_scrape = response.at_css('h1')
        address_scrape = response.at_css('#ContentPlaceHolderDefault_cp_content_ctl00_CharityDetails_4_TabContainer1_tpOverview_plContact .detail-33+ .detail-33 .detail-panel-wrap')
        website_scrape = response.at_css('#ContentPlaceHolderDefault_cp_content_ctl00_CharityDetails_4_TabContainer1_tpOverview_plContact h3+ a')
        email_scrape = response.at_css('br+ a')
        status_scrape = response.at_css('.up-to-date')
        year_ending_scrape = response.at_css('#ContentPlaceHolderDefault_cp_content_ctl00_CharityDetails_4_plHeading h2')
        days_overdue_scrape = response.at_css('#ContentPlaceHolderDefault_cp_content_ctl00_CharityDetails_4_plHeadingUoutOfDate .removed')
        out_of_date_scrape = response.at_css('#global-breadcrumb .out-of-date')
        income_scrape = response.at_css('.detail-33:nth-child(1) .big-money')
        spending_scrape = response.at_css('.detail-33:nth-child(2) .big-money')
        trustee_scrape = response.at_css('#tpPeople li:nth-child(1) .mid-money')
        employee_scrape = response.at_css('#tpPeople li:nth-child(2) .mid-money')
        volunteer_scrape = response.at_css('#tpPeople li:nth-child(3) .mid-money')
        link_scrape = response.at_css('.detail-33:nth-child(2) .doc')

        if company_no_scrape.present?
          self.company_number = company_no_scrape
                                .text
                                .strip.sub(/Company no. 0|Company no. /, '0')
        end

        self.name = name_scrape.text if name_scrape.present?
        self.charity_name = name_scrape.text if name_scrape.present?

        if website_scrape.present?
          self.website = website_scrape.text if
            website_scrape.text.match(URI.regexp(%w(http https)))
        end
        self.country = 'GB' if name_scrape.present?

        self.postal_code = address_scrape.text.split(',').last.strip if
                             address_scrape.present?
        self.contact_email = email_scrape.text if email_scrape.present?
        self.charity_status = status_scrape.text.tr('-', ' ').capitalize if
                                status_scrape.present?
        self.charity_status = out_of_date_scrape.text.tr('-', ' ').capitalize if
                                out_of_date_scrape.present?
        if year_ending_scrape.present? && year_ending_scrape.include?('Data')
          self.charity_year_ending = year_ending_scrape
                                     .text
                                     .gsub('Data for financial year ending ', '')
                                     .to_date
        end
        if days_overdue_scrape.present?
          self.charity_days_overdue = days_overdue_scrape
                                      .text.gsub('Documents ', '')
                                      .gsub(' days overdue', '')
        end
        if income_scrape.present?
          self.charity_income = income_scrape
                                .text.sub('£', '')
                                .to_f * financials_multiplier(income_scrape)
        end
        if spending_scrape.present?
          self.charity_spending = spending_scrape
                                  .text.sub('£', '')
                                  .to_f * financials_multiplier(spending_scrape)
        end
        self.charity_trustees = trustee_scrape.text if trustee_scrape.present?
        self.charity_employees = employee_scrape.text if
                                   employee_scrape.present?
        self.charity_volunteers = volunteer_scrape.text if
                                    volunteer_scrape.present?
        self.charity_recent_accounts_link = link_scrape['href'] if
                                              link_scrape.present?

        if income_scrape.present?
          income_select(income_scrape.text.sub('£', '')
          .to_f * financials_multiplier(income_scrape))
        end
        staff_select('employees', charity_employees) if
          charity_employees.present?
        staff_select('volunteers', charity_volunteers) if
          charity_volunteers.present?

        if company_no_scrape.present?
          self.org_type = 3
          lookup_company_data
        else
          self.company_number = nil
        end
        true
      else
        false
      end
    end

    def financials_multiplier(scrape)
      return unless scrape.present?
      case scrape.text.last
      when 'K'
        1000
      when 'M'
        1_000_000
      end
    end

    def income_select(income)
      self.income = if income < 10_000
                      0
                    elsif income >= 10_000 && income < 100_000
                      1
                    elsif income >= 100_000 && income < 1_000_000
                      2
                    elsif income >= 1_000_000 && income < 10_000_000
                      3
                    elsif income >= 10_000_000
                      4
                    end
    end

    def staff_select(field_name, count)
      count = count.to_i
      self[field_name] = if count.zero?
                           0
                         elsif count >= 1 && count <= 5
                           1
                         elsif count >= 6 && count <= 25
                           2
                         elsif count >= 26 && count <= 50
                           3
                         elsif count >= 51 && count <= 100
                           4
                         elsif count >= 101 && count <= 250
                           5
                         elsif count >= 251 && count <= 500
                           6
                         elsif count > 500
                           7
                         end
    end

    def lookup_company_data
      CompaniesHouse.new(company_number).lookup(self)
    end
end
