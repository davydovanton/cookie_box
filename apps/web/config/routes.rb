root to: 'home#index'

resources :decks, only: %i[index create]
