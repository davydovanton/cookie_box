# frozen_string_literal: true

RSpec.describe Repositories::Libs::GithubInfoGetter do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new }

  subject { lib.call(repo_name) }

  context 'when repo exist' do
    let(:repo_name) { 'hanami/hanami' }

    it { VCR.use_cassette('hanami_hanami_get_success') { expect(subject).to be_right } }

    it 'returns right information about repo' do
      VCR.use_cassette('hanami_hanami_get_success') do
        expect(subject.value!).to eq(
          full_name: 'hanami/hanami',
          description: 'The web, with simplicity.',
          html_url: 'https://github.com/hanami/hanami',
          topics: nil
        )
      end
    end
  end

  context 'when repo does not exist' do
    let(:repo_name) { 'hanami/invalid' }

    it { VCR.use_cassette('hanami_invalid_get_error') { expect(subject).to be_left } }
  end
end
