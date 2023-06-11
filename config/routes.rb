Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
    # other scoped routes
  end

  resources :batches
  resources :courses
  resources :schools

  resources :users do
    member do
      post 'assign_role/:role_id', to: 'users#assign_role', as: 'assign_role'
      delete 'remove_role/:role_id', to: 'users#remove_role', as: 'remove_role'
    end
  end
end
