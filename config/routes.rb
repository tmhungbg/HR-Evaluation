Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: 'admin/sessions', unlocks: 'admin/unlocks'}

  namespace :admin do
    root to: "pages#home"
    resources :staffs, :managers
  end
end
