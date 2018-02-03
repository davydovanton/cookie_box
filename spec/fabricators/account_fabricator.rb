# frozen_string_literal: true

Fabricator(:account) do
  name        { Faker::Name.name }
  uid         { Faker::Number.number(6) }
  login       { Faker::Internet.user_name }
  email       { Faker::Internet.email }
  avatar_url  { Faker::Avatar.image }
  admin       false
end
