# frozen_string_literal: true

Fabricator(:deck) do
  title      { Faker::Book.title }
  published  false
  account_id { Fabricate.create(:account).id }
end
