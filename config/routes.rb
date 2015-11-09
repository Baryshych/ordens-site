Rails.application.routes.draw do
  root to: 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'
  devise_for :users
  
  scope(:path => '/api/v1') do
    resources :profiles
    resources :science_degrees, only: [:index, :show, :update, :create]
    resources :education_degrees, only: [:index, :show, :update, :create]
    resources :workplaces, only: [:index, :show, :update, :create]
    resources :awards, except: [:new, :edit]
    resources :award_types, only: [:index, :show, :update, :create]
    resources :petition_initiators, only: [:index, :show, :update, :create]
    resources :document_qualities, only: [:index, :show, :update, :create]

    get 'account/current', to: 'application#current_account'
  end
end
