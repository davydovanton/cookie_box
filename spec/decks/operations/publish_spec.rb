# frozen_string_literal: true

RSpec.describe Decks::Operations::Publish do
  let(:deck_repo) { double(:deck_repo, publish: true) }
  let(:operation) { described_class.new(deck: deck_repo) }

  subject { operation.call(id) }

  context 'when id is exist' do
    let(:id) { 1 }

    it { expect(subject).to be_right }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to receive(:publish).with(1)
      subject
    end
  end

  context 'when id is empty' do
    let(:id) { nil }

    it { expect(subject).to be_left }

    it 'calls archive repo method with deck id' do
      expect(deck_repo).to_not receive(:archive).with(1)
      subject
    end
  end
end
