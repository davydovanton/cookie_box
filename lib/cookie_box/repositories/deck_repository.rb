class DeckRepository < Hanami::Repository
  associations do
    has_many :repositories, through: :deck_repos
  end

  def all_for_account(account_id)
    root.where(account_id: account_id, deleted_at: nil).map_to(Deck).to_a
  end

  def archive(id)
    update(id, deleted_at: Time.now)
  end

  def publish(id)
    update(id, published: true)
  end
end
