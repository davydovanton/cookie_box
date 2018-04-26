# frozen_string_literal: true

RSpec.describe Decks::Operations::Create do
  let(:operation) { described_class.new(deck: repo, slug_generator: slug_generator) }
  let(:slug_generator) { -> { '1234567' } }
  let(:repo) { double(:repo, create: Deck.new) }

  subject { operation.call(payload) }

  context 'when payload is valid' do
    let(:payload) { { title: 'test', account_id: 1 } }

    it { expect(subject).to be_right }
    it { expect(subject.value!).to be_a Deck }

    it 'calls repository' do
      expect(repo).to receive(:create).with(slug: '1234567', title: 'test', account_id: 1)
      subject
    end
  end

  context 'when payload is invalid' do
    let(:payload) { {} }

    it { expect(subject).to be_left }
    it { expect(subject.failure).to eq(title: ['is missing'], account_id: ['is missing']) }

    it 'does not call repository' do
      expect(repo).to_not receive(:create)
      subject
    end
  end

  context 'with a real dependencies' do
    let(:operation) { described_class.new }

    let(:repo) { DeckRepository.new }
    let(:payload) { { title: 'test', account_id: Fabricate(:account).id } }

    after { repo.clear }

    it { expect(subject).to be_right }
    it { expect { subject }.to change { repo.all.count }.by(1) }
  end
end
