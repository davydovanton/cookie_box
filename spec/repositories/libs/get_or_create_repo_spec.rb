# frozen_string_literal: true

RSpec.describe Repositories::Libs::GetOrCreateRepo do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new(repository: repository_mock, github_info_getter: github_info_getter_mock) }
  let(:github_info_getter_mock) { double(:github_info_getter, call: Right({})) }
  let(:repository_mock) { double(:repository, find_by_name: Repository.new) }

  subject { lib.call(repo_name) }
  let(:repo_name) { 'hanami/hanami' }

  context 'when repo exist in db' do
    let(:repository_mock) { double(:repository, find_by_name: Repository.new(title: 'from DB')) }

    it { expect(subject).to be_right }
    it { expect(subject.value).to eq Repository.new(title: 'from DB') }
  end

  context 'when repo does not exist in db' do
    let(:repository_mock) { double(:repository, find_by_name: nil, create: Repository.new(title: 'created')) }

    context 'and exist in github' do
      let(:github_info_getter_mock) { double(:github_info_getter, call: Right({})) }

      it { expect(subject).to be_right }
      it { expect(subject.value).to eq Repository.new(title: 'created') }

      it { expect { subject }.to change(Issues::Workers::Export.jobs, :size).by(1) }
    end

    context 'and does not exist in github' do
      let(:github_info_getter_mock) { double(:github_info_getter, call: Left(:error)) }

      it { expect(subject).to be_left }
      it { expect(subject.value).to eq :error }
    end
  end
end
