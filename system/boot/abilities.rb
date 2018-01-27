Container.finalize(:logger) do |container|
  abilities = Kan::Application.new(
    deck: Decks::Abilities::Base.new
  )

  container.register(:abilities, abilities)
end
