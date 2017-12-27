class AccountRepository < Hanami::Repository
  def find_by_uid(uid)
    root.where(uid: uid).map_to(Account).one
  end
end
