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
  end

  namespace :staff do
    root to: "pages#home"
    resources :peer_selections, only: [:index, :update]
    resources :self_evaluations, only: [:index, :update]
    resources :evaluations do 
    end
  end

  namespace :manager do 
    root to: "pages#home"
  end
  # get '/admin/staffs/generate_password', to:'admin/staffs#generate_password', as:'generate_password_staffs'
end
