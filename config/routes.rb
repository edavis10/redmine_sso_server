ActionController::Routing::Routes.draw do |map|
  map.resources :accounts, :only => [:create, :update, :present], :member => {:present => :any}
  map.resource :login, :only => [:create]
end
