require 'rails_helper'

describe FundInsightCell do
  controller ApplicationController

  before(:each) do
    # TODO: refactor
    @app.seed_test_db.setup_funds(num: 2, open_data: true)
        .create_recipient.create_proposal
    @db = @app.instances
    @fund = Fund.first
    @proposal = Proposal.first
  end

  context '#grant_examples' do
    it 'more than one grant examples' do
      card = cell(:fund_insight, @fund).call(:grant_examples)
      expect(card).to have_content 'Recent grants include'
    end

    it 'one grant example' do
      @fund.grant_examples = [@fund.grant_examples[0]]
      card = cell(:fund_insight, @fund).call(:grant_examples)
      expect(card).to have_content 'Example of a recent grant'
    end

    it 'Missing recipient' do
      @fund.grant_examples = [@fund.grant_examples[0].delete_if{ |k,v| k=="recipient"}]
      card = cell(:fund_insight, @fund).call(:grant_examples)
      expect(card).to have_content '(recipient not known)'
    end

    it 'Missing id' do
      @fund.grant_examples = [@fund.grant_examples[0].delete_if{ |k,v| k=="id"}]
      card = cell(:fund_insight, @fund).call(:grant_examples)
      expect(card).not_to have_content "http://grantnav.threesixtygiving.org/grant/360G-phf-30692"
    end

    it 'Missing amount' do
      @fund.grant_examples = [@fund.grant_examples[0].delete_if{ |k,v| k=="amount"}]
      card = cell(:fund_insight, @fund).call(:grant_examples)
      expect(card).to have_content 'Grant to'
    end

    it 'Missing date' do
      @fund.grant_examples = [@fund.grant_examples[0].delete_if{ |k,v| k=="award_date"}]
      card = cell(:fund_insight, @fund).call(:grant_examples)
      expect(card).not_to have_content 'in July 2016'
    end

    it 'no grant examples' do
      @fund.grant_examples = []
      card = cell(:fund_insight, @fund).call(:grant_examples)
      expect(card).not_to have_content 'Recent grants include'
      expect(card).not_to have_content 'Example of a recent grant'
    end
  end

  context '#themes' do
    it 'Theme shown correctly' do
      insight = cell(:fund_insight, @fund, proposal: @proposal).call(:themes)
      expect(insight).to have_link(Theme.first.name)
    end
  end

end
