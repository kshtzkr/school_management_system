Rails.application.routes.draw do
  devise_for :users
  root to:  'schools#index'

  resources :batches do
    get :link_student
    get :approve_student_batch
    get :student_progress
  end
  resources :courses
  resources :schools

  resources :users do
    member do
      post 'assign_role/:role_id', to: 'users#assign_role', as: 'assign_role'
      delete 'remove_role/:role_id', to: 'users#remove_role', as: 'remove_role'
    end
  end
end
