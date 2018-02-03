class ROM::Relation
  include Dry::Monads::Maybe::Mixin

  def maybe_one
    Maybe(one)
  end
end

Container.finalize!
