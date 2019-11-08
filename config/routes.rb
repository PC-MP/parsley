Rails.application.routes.draw do


  namespace :my do
    get 'top'
  end

  root to: 'home#index'
  devise_for :users,
             controllers: {
               sessions:      'users/sessions',
               registrations: 'users/registrations',
               passwords:     'users/passwords'
             }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
