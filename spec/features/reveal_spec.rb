require 'rails_helper'

feature 'RevealFunds' do
  before(:each) do
    @app.seed_test_db
        .setup_funds(num: 7, open_data: true)
        .create_recipient
        .with_user
        .create_registered_proposal
        .sign_in
    @user = User.last
    @recipient = Recipient.last
    @proposal = Proposal.last
    @fund = Fund.last
  end

  context 'v1 subscription' do
    it 'does not see Reveal button' do
      visit proposal_funds_path(@proposal, page: 2)
      expect(page).not_to have_link 'Reveal'
    end
  end

  context 'v2 subscription' do
    before(:each) do
      Subscription.last.update(version: 2)
      visit proposal_funds_path(@proposal)
    end

    scenario 'reveal button hidden once revealed' do
      click_link('Reveal', match: :first)
      visit proposal_funds_path(@proposal)
      expect(page).to have_link 'Reveal', count: 5
    end

    scenario 'I see a reveal button on funds pages' do
      expect(page).to have_link 'Reveal', count: 6
    end

    scenario 'clicking on reveal button reveals that fund' do
      click_link('Reveal', match: :first)
      expect(@user.reveals.count).to eq 1
      expect(current_path).to eq proposal_fund_path(@proposal, @fund)
    end

    context 'limit reached' do
      before(:each) do
        @recipient.update(reveals: [1, 2, 3])
        visit proposal_funds_path(@proposal)
      end

      scenario 'cant reveal fund after reaching limit' do
        click_link('Reveal', match: :first)
        expect(current_path).to eq account_upgrade_path(@recipient)
      end

      scenario 'can browse redacted fund after reaching limit' do
        click_link('Check eligibility', match: :first)
        expect(current_path).to eq proposal_fund_path(@proposal, @fund)
      end

      scenario 'can check eligibility after reaching limit' do
        click_link('Check eligibility', match: :first)
        expect(current_path)
          .to eq proposal_fund_path(@proposal, @fund, anchor: 'eligibility')
      end
    end
  end
end
