# frozen_string_literal: true

RSpec.describe Issues::Operations::Update do
  include Dry::Monads::Either::Mixin

  let(:webhook) do
    {
      repository: {
        full_name: 'davydovanton/cookie_box'
      },
      action: 'opened',
      issue: {
        url: 'https://api.github.com/repos/davydovanton/cookie_box/issues/14',
        repository_url: 'https://api.github.com/repos/davydovanton/cookie_box',
        labels_url: 'https://api.github.com/repos/davydovanton/cookie_box/issues/14/labels{/name}',
        comments_url: 'https://api.github.com/repos/davydovanton/cookie_box/issues/14/comments',
        events_url: 'https://api.github.com/repos/davydovanton/cookie_box/issues/14/events',
        html_url: 'https://github.com/davydovanton/cookie_box/issues/14',
        id: 321_650_570,
        number: 14,
        title: 'One more test',
        user: {
          login: 'davydovanton',
          id: 1_147_484,
          avatar_url: 'https://avatars2.githubusercontent.com/u/1147484?v=4',
          gravatar_id: '',
          url: 'https://api.github.com/users/davydovanton',
          html_url: 'https://github.com/davydovanton',
          followers_url: 'https://api.github.com/users/davydovanton/followers',
          following_url: 'https://api.github.com/users/davydovanton/following{/other_user}',
          gists_url: 'https://api.github.com/users/davydovanton/gists{/gist_id}',
          starred_url: 'https://api.github.com/users/davydovanton/starred{/owner}{/repo}',
          subscriptions_url: 'https://api.github.com/users/davydovanton/subscriptions',
          organizations_url: 'https://api.github.com/users/davydovanton/orgs',
          repos_url: 'https://api.github.com/users/davydovanton/repos',
          events_url: 'https://api.github.com/users/davydovanton/events{/privacy}',
          received_events_url: 'https://api.github.com/users/davydovanton/received_events',
          type: 'User',
          site_admin: false
        },
        labels: [],
        state: 'open',
        locked: false,
        assignee: nil,
        assignees: [],
        milestone: nil,
        comments: 0,
        created_at: '2018-05-09T17:01:45Z',
        updated_at: '2018-05-09T17:01:45Z',
        closed_at: nil,
        author_association: 'OWNER',
        body: ''
      }
    }
  end

  let(:operation) { described_class.new(issue_repo: issue_repo) }
  let(:issue_repo) { double(:issue_repo, update_from_vcs: Issue.new) }

  subject { operation.call(webhook: webhook) }

  it { expect(subject).to be_right }
  it { expect(subject).to eq Success(Issue.new) }

  it 'calls repository with right data' do
    expect(issue_repo).to receive(:update_from_vcs).with(
      321_650_570, webhook[:repository][:full_name],
      title: 'One more test',
      author: webhook[:issue][:user],
      labels: [],
      state: 'open',
      locked: false,
      html_url: 'https://github.com/davydovanton/cookie_box/issues/14',
      assignees: [],
      comments: 0,
      updated_at: '2018-05-09T17:01:45Z',
      closed_at: nil
    )
    subject
  end

  context 'with all dependencies' do
    let(:operation) { described_class.new }
    let(:repo) { IssueRepository.new }

    before { Fabricate.create(:repository, full_name: webhook[:repository][:full_name]) }

    after { repo.clear && RepositoryRepository.new.clear }

    it { expect(subject).to be_right }
    it { expect { subject }.to change { repo.all.count }.by(1) }
  end
end
