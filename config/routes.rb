Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :boards
  namespace :api do
    resources :boards, only: [:show, :update] do
      member do
        put :final_states
      end
    end
    
  end
  mount ActionCable.server => '/cable'
  # get '/boards/:id/fetch', to: 'boards#fetch_data', as: 'fetch_board'
  root "boards#index"
end
