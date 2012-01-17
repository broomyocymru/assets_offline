Rails.application.routes.draw do
  resources :assets_offline, :defaults => {:format => 'manifest'}
end 
