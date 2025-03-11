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

  resources :recipe_lists do
    post "add_recipe", on: :member
  end
end
