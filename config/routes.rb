Tvshows::Application.routes.draw do
  resources :torrents

  devise_for :users,
    path_names: { sign_in: 'login', sign_out: 'logout' },
    controllers: {
      omniauth_callbacks: 'omniauth_callbacks'
    }

  resources :feeds
  resources :shows do
    resources :episodes
  end
  resources :subscriptions, :only => [:create, :destroy]

  root :to => 'home#index'
end
