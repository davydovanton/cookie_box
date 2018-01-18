Container.finalize(:logger) do |container|
  container.register(:logger, Hanami.logger)
end
