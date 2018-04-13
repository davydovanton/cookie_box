# frozen_string_literal: true

Container.boot(:events) do |container|
  init do
    events = Hanami::Events.new(:memory_sync)
    container.register(:events, events)
  end
end
