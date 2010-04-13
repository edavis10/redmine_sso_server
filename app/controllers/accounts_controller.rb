class AccountsController < InheritedResources::Base
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  
  respond_to :xml
  actions :create, :update, :present

  def create
    @user = User.new_from_limited_attributes(params[:user]) if params[:user]
    @user ||= User.new
    create!
  end

  def present
    @user = User.find_by_login(params[:login])
    @user ||= User.find_by_login(params[:id])
    
    respond_to do |format|
      if @user
        format.xml { render(:text => '', :status => :ok)}
      else
        format.xml { render(:text => '', :status => :no_content)}
      end
    end
    
  end
end
