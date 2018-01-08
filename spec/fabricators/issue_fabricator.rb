Fabricator(:issue) do
  title      { Faker::Book.title }
  html_url   'https://github.com/hanami/events/issues/59'
  state      'open'
  comments   1

  labels { [{ name: 'enhancement', color: '84b6eb' }] }
  user do
    {
      login: 'davydovanton',
      avatar_url: 'https://avatars2.githubusercontent.com/u/1147484?v=4',
      html_url: 'https://github.com/davydovanton'
    }
  end

  assignees do
    [{
      login: 'davydovanton',
      avatar_url: 'https://avatars2.githubusercontent.com/u/1147484?v=4',
      html_url: 'https://github.com/davydovanton'
    }]
  end

  repository_id { Fabricate.create(:repository).id }
end
