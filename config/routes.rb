Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
  sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "public/homes#top"
  get "/about" => "public/homes#about"
  get "/admin" => "admin/homes#top"

  scope module: :public do
  get "/customers/unsubscribe" => "customers#unsubscribe"
  patch "/customers/withdrawal" => "customers#withdrawal"
  resources :customers
  resources :items
    resources :cart_items do
      collection do
       delete 'destroy_all', action: 'destroy_all'
      end
    end
  resources :orders do
    collection do
      post "confirm"
      get "complete"
    end
  end
  end

  namespace :admin do
  resources :items
  resources :customers
  resources :orders, only: [:show]
  end
end

