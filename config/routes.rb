Rails.application.routes.draw do
  devise_for :users
  root "recipes#index"

  resources :recipes do
    collection do
      post :search
    end

    member do
      post "join"
    end
  end
end
