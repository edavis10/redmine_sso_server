class AccountsController < InheritedResources::Base
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  
  respond_to :xml
  actions :create, :update, :present
end
