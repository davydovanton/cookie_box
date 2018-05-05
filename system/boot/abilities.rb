# frozen_string_literal: true

Container.finalize(:abilities) do |container|
  abilities = Kan::Application.new(
    deck: [Decks::Abilities::Anonymous.new, Decks::Abilities::Regular.new, Decks::Abilities::Admin.new]
  )

  container.register(:abilities, abilities)
end
