Rails.application.routes.draw do

  resource :entrance, only: %i[show]

  namespace :my do
    resources :users
    resources :libraries, only: %i[index show] do
      scope module: :libraries do
        resources :book_stocks
        resources :invitations
      end
    end
    resource :settings do
      scope module: :settings do
        resources :libraries
      end
    end
    get 'top'
  end

  root to: 'home#index'

  devise_for :users,
             controllers: {
               omniauth_callbacks: 'users/omniauth_callbacks'
             }

  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
