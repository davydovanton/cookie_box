# frozen_string_literal: true

root to: 'home#index'

resources :decks,           only: %i[index create show destroy]
resources :published_decks, only: %i[create]
resources :repositories,    only: %i[create destroy]
