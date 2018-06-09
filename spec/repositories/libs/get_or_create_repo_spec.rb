# frozen_string_literal: true

RSpec.describe Repositories::Libs::GetOrCreateRepo do
  include Dry::Monads::Result::Mixin

  let(:lib) { described_class.new(repository: repository_mock, info_getter: info_getter_mock) }
  let(:info_getter_mock) { double(:info_getter, call: Right({})) }
  let(:repository_mock) { double(:repository, find_by_name: Repository.new) }

  subject { lib.call(repo_name) }
  let(:repo_name) { 'hanami/hanami' }

  context 'when repo name is github link' do
    let(:repo_name) { 'github.com/hanami/hanami' }

    it 'truncates repository name' do
      expect(repository_mock).to receive(:find_by_name).with('hanami/hanami')
      subject
    end
  end

  context 'when repo exist in db' do
    let(:repository_mock) { double(:repository, find_by_name: Repository.new(title: 'from DB')) }

    it { expect(subject).to be_right }
    it { expect(subject.value!).to eq Repository.new(title: 'from DB') }
  end

  context 'when repo does not exist in db' do
    let(:repository_mock) { double(:repository, find_by_name: nil, create: Repository.new(title: 'created')) }

    context 'and exist in github' do
      let(:info_getter_mock) { double(:info_getter, call: Success({})) }

      it { expect(subject).to be_right }
      it { expect(subject.value!).to eq Repository.new(title: 'created') }

      it { expect { subject }.to change(Issues::Workers::Export.jobs, :size).by(1) }
    end

    context 'and does not exist in github' do
      let(:info_getter_mock) { double(:info_getter, call: Failure(:error)) }

      it { expect(subject).to be_left }
      it { expect(subject.failure).to eq :error }
    end
  end
end
