Tvshows::Application.routes.draw do
  devise_for :users

  resources :feeds
  resources :shows do
    resources :episodes
  end

  match 'dropbox/authorize', :controller => 'dropbox', :action => 'authorize'
  match 'dropbox/upload', :controller => 'dropbox', :action => 'upload'

  root :to => 'home#index'
end
