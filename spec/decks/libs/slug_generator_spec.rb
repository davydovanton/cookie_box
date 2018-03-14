# frozen_string_literal: true

RSpec.describe Decks::Libs::SlugGenerator do
  let(:lib) { described_class.new }
  subject { lib.call }

  it { expect(subject).to be_a String }
  it { expect(subject.size).to eq 7 }
  it { expect(subject).to_not eq lib.call }
end
