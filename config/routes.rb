Rails.application.routes.draw do

  resources :categories do
    resources :items do
      get :upvote,    on: :member
      get :expensive, on: :collection
    end
  end
  
  get "admin/users_count" => "admin#users_count"
  
end
