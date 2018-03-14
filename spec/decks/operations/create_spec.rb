# frozen_string_literal: true

RSpec.describe Decks::Operations::Create do
  let(:operation) { described_class.new(slug_generator: slug_generator) }
  let(:slug_generator) { -> { '1234567' } }
  let(:repo) { DeckRepository.new }

  after { repo.clear }

  subject { operation.call(payload) }

  context 'when payload is valid' do
    let(:payload) { { title: 'test', account_id: Fabricate(:account).id } }

    it { expect(subject).to be_right }

    it { expect { subject }.to change { repo.all.count }.by(1) }

    it { expect(subject.value).to be_a Deck }
    it { expect(subject.value.slug).to eq '1234567' }
  end

  context 'when payload is invalid' do
    let(:payload) { {} }

    it { expect(subject).to be_left }
    it { expect { subject }.to change { repo.all.count }.by(0) }
    it { expect(subject.value).to eq(title: ['is missing'], account_id: ['is missing']) }
  end
end
