module Web::Controllers::PublishedDecks
  class Create
    include Web::Action

    def call(params)
      redirect_to routes.root_path
    end
  end
end
