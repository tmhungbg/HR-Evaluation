Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admin/sessions', unlocks: 'admin/unlocks' }
  devise_for :staffs, controllers: { sessions: 'staff/sessions', unlocks: 'staff/unlocks' }

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
  end
  # get '/admin/staffs/generate_password', to:'admin/staffs#generate_password', as:'generate_password_staffs'
end
