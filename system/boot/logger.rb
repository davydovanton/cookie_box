# frozen_string_literal: true

Container.finalize(:logger) do |container|
  container.register(:logger, Hanami.logger)
end
