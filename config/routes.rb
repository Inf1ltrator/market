Rails.application.routes.draw do

  devise_for :users

  resources :users, only: (:show)
  resources :categories do
    resources :items do
      get :upvote,    on: :member
      get :expensive, on: :collection
      get :create_position, on: :member
    end
  end

  resources :carts do
    get :delete_position, on: :member
  end
  
  root to: "categories#index"

  get "admin/users_count" => "admin#users_count"
  
end
