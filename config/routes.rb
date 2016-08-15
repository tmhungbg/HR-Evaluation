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
    end
    resources :evaluation_results do 
    end
    resources :questions do
      member do
        get :move_up
        get :move_down
      end
    end
    resources :answers
  end

  namespace :staff do
    root to: "pages#home"
    resources :peer_selections, only: [:index, :update]
    resources :self_evaluations, only: [:index, :update]
    resources :peer_evaluations, only: [:index, :update, :edit]
    resources :evaluations, only: [:edit, :update]
    resources :evaluation_results, only: [:index]
  end

  namespace :manager do 
    root to: "pages#home"
    resources :manager_evaluations, only: [:edit, :update]
  end
  # get '/admin/staffs/generate_password', to:'admin/staffs#generate_password', as:'generate_password_staffs'
end
