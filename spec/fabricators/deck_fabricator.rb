# frozen_string_literal: true

Fabricator(:deck) do
  slug      { SecureRandom.hex[0..6] }
  title      { Faker::Book.title }
  published  false
  account_id { Fabricate.create(:account).id }
end
