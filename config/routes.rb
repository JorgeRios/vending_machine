Rails.application.routes.draw do
  resources :create
  match '/monitor', :controller => 'application', :action => 'add_money', :via => :get
  match '/show_machine', :controller => 'application', :action => 'show_machine', :via => :post
  match '/add_money', :controller => 'application', :action => 'add_money', :via => :post
  match '/buy_item', :controller => 'application', :action => 'buy_item', :via => :post
  match '/create_machin', :controller => 'create', :action => 'create_app', :via => :post
end
