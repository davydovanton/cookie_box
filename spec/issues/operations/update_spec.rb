# frozen_string_literal: true

RSpec.describe Issues::Operations::Update do
  include Dry::Monads::Either::Mixin

  let(:operation) { described_class.new }

  subject { operation.call({}) }
end

# {:url=>"https://api.github.com/repos/davydovanton/cookie_box/issues/14", :repository_url=>"https://api.github.com/repos/davydovanton/cookie_box", :labels_url=>"https://api.github.com/repos/davydovanton/cookie_box/issues/14/labels{/name}", :comments_url=>"https://api.github.com/repos/davydovanton/cookie_box/issues/14/comments", :events_url=>"https://api.github.com/repos/davydovanton/cookie_box/issues/14/events", :html_url=>"https://github.com/davydovanton/cookie_box/issues/14", :id=>321650570, :number=>14, :title=>"One more test", :user=>{:login=>"davydovanton", :id=>1147484, :avatar_url=>"https://avatars2.githubusercontent.com/u/1147484?v=4", :gravatar_id=>"", :url=>"https://api.github.com/users/davydovanton", :html_url=>"https://github.com/davydovanton", :followers_url=>"https://api.github.com/users/davydovanton/followers", :following_url=>"https://api.github.com/users/davydovanton/following{/other_user}", :gists_url=>"https://api.github.com/users/davydovanton/gists{/gist_id}", :starred_url=>"https://api.github.com/users/davydovanton/starred{/owner}{/repo}", :subscriptions_url=>"https://api.github.com/users/davydovanton/subscriptions", :organizations_url=>"https://api.github.com/users/davydovanton/orgs", :repos_url=>"https://api.github.com/users/davydovanton/repos", :events_url=>"https://api.github.com/users/davydovanton/events{/privacy}", :received_events_url=>"https://api.github.com/users/davydovanton/received_events", :type=>"User", :site_admin=>false}, :labels=>[], :state=>"open", :locked=>false, :assignee=>nil, :assignees=>[], :milestone=>nil, :comments=>0, :created_at=>"2018-05-09T17:01:45Z", :updated_at=>"2018-05-09T17:01:45Z", :closed_at=>nil, :author_association=>"OWNER", :body=>""}
