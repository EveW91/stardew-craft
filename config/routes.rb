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

  resources :recipe_lists, only: %i[index create show edit new] do
    member do
      post :add_recipe, to: "recipe_lists#add_recipe"
    end
  end
end
