module Web::Controllers::Home
  class Index
    include Web::Action

    def call(params)
      redirect_to routes.decks_path if authenticated?
    end
  end
end
