# frozen_string_literal: true

class ROM::Relation # rubocop:disable Style/ClassAndModuleChildren
  include Dry::Monads::Maybe::Mixin

  def maybe_one
    Maybe(one)
  end
end

Container.finalize!
