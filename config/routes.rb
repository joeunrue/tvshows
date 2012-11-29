Tvshows::Application.routes.draw do
  devise_for :users

  resources :feeds
  resources :shows do
    resources :episodes
  end

  root :to => 'shows#index'
end
