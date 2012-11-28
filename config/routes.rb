Tvshows::Application.routes.draw do
  resources :feeds
  resources :shows do
    resources :episodes
  end

  root :to => 'shows#index'
end
