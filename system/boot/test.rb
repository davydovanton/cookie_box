Container.finalize(:test) do |container|
  container.register(:test, Object.new)
end
