# frozen_string_literal: true

RSpec.describe Decks::Operations::List do
  let(:deck_repo) { double(:deck_repo, all_for_account: []) }
  let(:operation) { described_class.new(deck: deck_repo) }
  let(:account_id) { 1 }

  subject { operation.call(account_id) }

  it { expect(subject).to be_right }
  it { expect(subject.value).to eq [] }
end
