require 'rails_helper'

describe Progress::Suitability, type: :feature do
  subject { Progress::Suitability.new(opts) }
  let(:opts) {
    {
      fund: build(:fund, id: 1, slug: 'fund'),
      proposal: build(:proposal, id: 1, suitability: { 'fund' => suitability }),
      position: 'top bot'
    }
  }

  let(:suitability) { {} }

  it('#label') { expect(subject.label).to eq('Suitability') }

  context 'poor' do
    it('indicator') { expect(subject.indicator).to eq('top bot bg-red') }
    it('message')   { expect(subject.message).to have_link('Poor') }
  end

  context 'neutral' do
    let(:suitability) { { fund: { a: { score: 1 }, b: { score: 1 } } } }

    it('indicator') { expect(subject.indicator).to eq('top bot bg-yellow') }
    it('message')   { expect(subject.message).to have_link('Review') }
  end

  context 'good' do
    let(:suitability) do
      {
        fund: {
          a: { score: 1 },
          b: { score: 1 },
          c: { score: 1 },
          d: { score: 1 },
          e: { score: 1 }
        }
      }
    end

    it('indicator') { expect(subject.indicator).to eq('top bot bg-green') }
    it('message')   { expect(subject.message).to have_link('Good') }
  end
end
