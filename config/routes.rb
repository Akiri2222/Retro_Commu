Rails.application.routes.draw do
  namespace :admin do
    get 'homes/top'
  end
  namespace :user do
    get 'homes/top'
  end

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
}
  devise_scope :user do
    post 'users/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :user do
    root to: "homes#top"
    get "about" => "homes#about", as: :about

    resources :posts, onry: [:index, :show, :create, :edit, :update, :destroy] do
      resources :comments, onry: [:create, :edit, :update, :destroy]
      resource :book_marks, only: [:create, :destroy]
    end
    resources :genres, onry: [:show]
    resources :tags
    resources :users do
      member do
        get :book_marks
      end
    end
    get '/search', to: 'searches#search'
  end

  get "admin" => "admin/homes#top", as: :admin
  namespace :admin do
    resources :posts, onry: [:index, :show, :edit, :update, :destroy] do
      resources :comments, onry: [:destroy]
    end
    resources :genres, onry: [:create, :edit, :update, :destroy]
    resources :tags
    resources :users
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
