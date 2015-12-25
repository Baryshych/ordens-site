Rails.application.routes.draw do

  get 'test', to: 'petitions#test'
  
  root to: 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'
  devise_for :users

  scope(:path => '/api/v1') do
    resources :profiles
    resources :science_degrees, only: [:index, :show, :update, :create]
    resources :education_degrees, only: [:index, :show, :update, :create]
    resources :workplaces, only: [:index, :show, :update, :create]
    resources :awards, except: [:new, :edit]
    resources :users, except: [:new, :edit]
    resources :award_types, only: [:index, :show, :update, :create]
    resources :award_type_categories, only: [:index]
    resources :petition_initiators, only: [:index, :show, :update, :create]
    resources :document_qualities, only: [:index, :show, :update, :create]
    resources :award_categories, only: [:index]

    get 'petitions/new_count', to: 'admin_petitions#new_count'
    resources :petitions, controller: 'admin_petitions', as: 'admin_petitions' do
      member do
        get 'similar'
        post 'import'
      end
    end

    resources :petitioners
    get 'account/current', to: 'application#current_account'

    resources :reports, only: [:create, :index]
  end

  # petitions
  resources :petitions
  devise_for :petitioners, controllers: {
    sessions: 'petitioners/sessions',
    registrations: 'petitioners/registrations',
    confirmations: 'petitioners/confirmations'
  }
end
