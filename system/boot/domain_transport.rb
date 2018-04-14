# frozen_string_literal: true

Container.boot(:domain_transport) do |container|
  init do
    domain_transport = Hanami::Events.new(:memory_sync)
    container.register(:domain_transport, domain_transport)
  end

  start do
    container.register(:domain_caller, lambda do |event_name, payload|
      container[:domain_transport].broadcast(event_name, payload).first
    end)
  end
end
