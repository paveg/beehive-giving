require 'rails_helper'

feature 'Browse' do
  before(:each) do
    @app.seed_test_db
        .setup_funds(num: 7, open_data: true)
        .setup_fund_stubs(num: 5)
        .create_recipient
        .with_user
        .create_registered_proposal
    @db = @app.instances
    @fund_stubs = @app.instances[:fund_stubs]
    @proposal = @db[:registered_proposal]
    @theme = @db[:themes].first
    @themes = @db[:themes]
    visit sign_in_path
  end

  scenario 'When I sign in,
            I want to see my recommended fund,
            so I can see my results' do
    fill_in :email, with: @db[:user].email
    fill_in :password, with: @db[:user].password
    click_button 'Sign in'
    expect(current_path).to eq funds_path(@proposal)
  end

  scenario 'When I browse the site,
            there is a list of fund themes in the footer' do
    Fund.active.first.update themes: [@themes.first, @themes.second]
    Fund.active.second.update themes: [@themes.first]
    visit root_path
    expect(page).to have_text 'FUNDING'
    expect(page).to have_text @themes.first.name
    expect(page).to have_text @themes.second.name
    expect(page).to have_text @themes.third.name
  end

  context 'signed in' do
    before(:each) do
      @unsuitable_fund = Fund.active.first
      @low_fund = Fund.active.find_by(name: 'Awards for All 2')
      @top_fund = Fund.active.last
      @recipient = @db[:recipient]
      @app.sign_in
      visit root_path
    end

    context 'cannot visit inactive fund' do
      before do
        @fund = Fund.first
        @fund.update(state: 'inactive')
      end

      it 'hidden' do
        visit hidden_path(@fund, @proposal)
        expect(current_path).to eq(funds_path(@proposal))
      end

      it 'revealed' do
        @proposal.recipient.update(reveals: [@fund.slug])
        visit fund_path(@fund, @proposal)
        expect(current_path).to eq(funds_path(@proposal))
      end
    end

    scenario 'fund stub selection shown on proposal fund page'

    scenario "When I visit a fund that doesn't exist,
              I want to be redirected to where I came from and see a message,
              so I avoid an error and understand what happened" do
      visit fund_path('missing-fund', @proposal)
      expect(current_path).to eq(funds_path(@proposal))
    end

    scenario "When I find a funding theme I'm interested in,
              I want to see similar funds,
              so I can discover new funding opportunties" do
      click_link @theme.name, match: :first
      expect(current_path).to eq(theme_path(@theme.slug, @proposal))
      expect(page).to have_css('h3', count: 6)
    end

    scenario 'Themes redacted on second page and CTA not shown' do
      click_link @theme.name, match: :first
      click_link '2'
      expect(page).to have_link('Hidden fund', count: 1)
    end

    scenario "When I visit a funding theme which isn't listed,
              I want to see a message and be directed to safety,
              so I can continue my search" do
      visit theme_path('missing', @proposal)
      # TODO: v2 flash notices #391
      # expect(page.all('body script', visible: false)[0].native.text)
      #   .to have_text 'Fund not found'
      expect(current_path).to eq(funds_path(@proposal))

      visit theme_path('missing', @proposal)
      # TODO: v2 flash notices #391
      # expect(page.all('body script', visible: false)[0].native.text)
      #   .to have_text 'Not found'
      expect(current_path).to eq funds_path(@proposal)
    end

    def subscribe_and_visit(path)
      @recipient.subscribe!
      visit path
      expect(current_path).to eq path
    end

    context 'When I view fund a with open data' do
      before(:each) do
        click_link 'Hidden fund', match: :first
      end

      scenario 'I want to see which time period the analysis relates to,
                so I can understand how up to date it is' do
        expect(page).to have_text 1.year.ago.strftime('%b %Y') +
                                  ' - ' +
                                  Time.zone.today.strftime('%b %Y')
      end

      scenario 'I want to see the grant_count,
                so I can evaluate my chances of success' do
        expect(page).to have_text(
          "Awarded #{@top_fund.grant_count} grants"
        )
      end

      scenario 'I want to see the top_award_months,
                so I can evaluate my chances of success' do
        expect(page).to have_text(
          'Awarded the most funding in January and February'
        )
      end

      scenario 'I want to see the sources of open data,
                so I can further my research' do
        expect(page).to have_link('License', href: 'https://creativecommons.org/licenses/by/4.0/')
        expect(page).to have_link('Source', href: 'http://www.example.com')
      end
    end
  end
end
