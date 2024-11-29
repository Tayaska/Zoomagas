Rails.application.routes.draw do
  get "contact_forms/new"
  get "contact_forms/create"
  get "pages/new"
  get "pages/create"
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root "home#index"
  get "about", to: "pages#about", as: :about
  get "news", to: "pages#news", as: :news

  # Ресурс для контактної форми
  resources :contact_forms, only: [:new, :create]

  get "contacts", to: "contact_forms#new", as: :contacts
  post "contacts", to: "contact_forms#create"  # Додаємо маршрут для POST запиту

  # Ресурси для продуктів
  resources :products, only: [:index, :show, :new, :create] do

    resources :comments, only: [:create] do
      post 'reply', on: :member, to: 'comments#reply'
    end
  end

  # Ресурс для кошика
  # config/routes.rb
  resource :cart, only: [:show] do
    post 'add/:product_id', to: 'carts#add', as: :add
    delete 'remove/:id', to: 'carts#remove', as: :remove
    delete 'clear', to: 'carts#clear', as: :clear
    get 'checkout', to: 'carts#checkout', as: :checkout

    # Додайте маршрут для оновлення кількості товару
    patch 'update_quantity/:id', to: 'carts#update_quantity', as: :update_quantity

  end




  # Інші ресурси
  resources :orders, only: [:new, :create]
end









