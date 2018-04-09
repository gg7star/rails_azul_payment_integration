Rails.application.routes.draw do
  resources :azuls do
    collection do
      get 'page_forwarding_mode'
      post 'forward_to_azul_payment_page'
      get 'approved'
      get 'declined'
      get 'canceled'
      post 'response_post'
      get 'api_mode'
      post 'make_payment_by_azul_api'
      get 'get_auth_hash'
    end
  end
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  root to: 'azuls#page_forwarding_mode'
  devise_for :users
end
