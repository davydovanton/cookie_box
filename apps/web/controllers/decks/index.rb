module Web::Controllers::Decks
  class Index
    include Web::Action

    before :authenticate!

    def call(params)
    end
  end
end
