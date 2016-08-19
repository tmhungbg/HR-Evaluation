Rails.application.routes.draw do
  devise_for :admins
  devise_for :staffs
  devise_for :managers

  namespace :admin do
    root to: "pages#home"
    resources :staffs do
      collection do 
        get 'generate_password_all'
      end
      get 'generate_password', on: :member
    end
    resources :managers do 
      collection do 
        get 'generate_password_all'
      end
      get 'generate_password', on: :member
    end
    resources :periods do
      get :send_account_infor, on: :collection
    end
    resources :evaluation_results, only: [:index, :show]
    resources :questions do
      member do
        get :move_up
        get :move_down
      end
    end
    resources :progress, only: [:index]
  end

  namespace :staff do
    root to: "pages#home"
    resources :peer_selections, only: [:index, :update]
    resources :evaluations, only: [:edit, :update] do
      get 'peer_evaluation_list', on: :collection
    end
    resources :evaluation_results, only: [:index]
  end

  namespace :manager do 
    root to: "pages#home"
    resources :evaluations, only: [:edit, :update]
  end
end
