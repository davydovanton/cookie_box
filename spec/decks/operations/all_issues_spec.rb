# frozen_string_literal: true

RSpec.describe Decks::Operations::AllIssue do
  let(:issues_repo) { double(:issues_repo, all_for_deck: issues) }
  let(:issues) { [Issue.new(state: 'open')] }
  let(:operation) { described_class.new(issue: issues_repo) }

  subject { operation.call(deck_id: 1) }

  it { expect(subject).to be_right }
  it { expect(subject.value!).to eq(open: issues) }

  it 'calls archive repo method with deck id' do
    expect(issues_repo).to receive(:all_for_deck).with(1)
    subject
  end
end
