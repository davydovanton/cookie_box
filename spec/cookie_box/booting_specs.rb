# frozen_string_literal: true

RSpec.describe 'Booting system' do
  it 'loads all dependencies to container' do
    expect { Container.keys.map { |key| Container[key] } }.to_not raise_error
  end

  it 'loads domain dependencies right' do
    expect(Container['decks.operations.all_issues']).to be_a Decks::Operations::AllIssues
  end
end
