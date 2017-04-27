Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'

  resources :tickets, param: :link_id do
    put :complete, on: :member
    resources :comments
  end

  devise_for :users
  get "users/:id" , to: 'users#show', as: 'users', controller: 'users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tickets#new"
end
