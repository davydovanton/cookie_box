# frozen_string_literal: true

RSpec.describe Repositories::Operations::Create do
  include Dry::Monads::Either::Mixin

  let(:lib) { described_class.new(deck_repo: deck_repo_mock, get_or_create_repo: get_or_create_repo_mock) }
  let(:deck_repo_mock) { double(:deck_repo, select_or_create: DeckRepo.new) }
  let(:get_or_create_repo_mock) { double(:get_or_create_repo, call: repo_result) }
  let(:repo_result) { Right(Repository.new(id: 1)) }

  subject { lib.call(deck_id: deck_id, repo_name: repo_name) }

  context 'when params valid' do
    let(:deck_id) { 1 }
    let(:repo_name) { 'hanami/hanami' }

    context 'and repository exist' do
      let(:repo_result) { Right(Repository.new(id: 1)) }

      it { expect(subject).to be_right }

      it 'creates a new repo <-> deck association' do
        expect(deck_repo_mock).to receive(:select_or_create).with(deck_id: 1, repository_id: 1)
        subject
      end
    end

    context 'and repository does not exist' do
      let(:repo_result) { Left(:error) }

      it { expect(subject).to be_left }

      it 'creates a new repo <-> deck association' do
        expect(deck_repo_mock).to receive(:select_or_create).exactly(0).times
        subject
      end
    end

    context 'and repository name contain site' do
      let(:repo_name) { 'github.com/hanami/hanami' }

      it 'creates a new repo <-> deck association' do
        expect(get_or_create_repo_mock).to receive(:call).with('github.com/hanami/hanami')
        subject
      end
    end

    context 'and repository name contain site with http schema' do
      let(:repo_name) { 'http://github.com/hanami/hanami' }

      it 'creates a new repo <-> deck association' do
        expect(get_or_create_repo_mock).to receive(:call).with('http://github.com/hanami/hanami')
        subject
      end
    end

    context 'and repository name contain site with https schema' do
      let(:repo_name) { 'https://github.com/hanami/hanami' }

      it 'creates a new repo <-> deck association' do
        expect(get_or_create_repo_mock).to receive(:call).with('https://github.com/hanami/hanami')
        subject
      end
    end

    context 'and repository name contain site with https schema and www' do
      let(:repo_name) { 'https://www.github.com/hanami/hanami' }

      it 'creates a new repo <-> deck association' do
        expect(get_or_create_repo_mock).to receive(:call).with('https://www.github.com/hanami/hanami')
        subject
      end
    end
  end

  context 'when params invalid' do
    let(:deck_id) { nil }
    let(:repo_name) { nil }

    it { expect(subject).to be_left }
    it { expect(subject.failure).to eq(deck_id: ['must be filled'], repo_name: ['must be filled']) }
  end

  context 'when repository name contain invalid string' do
    let(:deck_id) { 1 }
    let(:repo_name) { 'invalid.com/bad/hanami/hanami' }

    it { expect(subject).to be_left }
    it { expect(subject.value).to eq(repo_name: ['is in invalid format']) }
  end
end
