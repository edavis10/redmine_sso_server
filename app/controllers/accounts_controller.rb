class AccountsController < InheritedResources::Base
  defaults :resource_class => User, :collection_name => 'users', :instance_name => 'user'
  
  respond_to :xml
  actions :create, :update, :present

  def create
    @user = User.new_from_limited_attributes(params[:user]) if params[:user]
    @user ||= User.new
    create!
  end

  def update
    # Try to login using the login or the record id
    @user = User.try_to_login(params[:login], params[:password])
    @user ||= User.try_to_login(params[:id], params[:password])
    
    respond_to do |format|
      if @user && @user.update_attributes(params[:user])
        format.xml { render(:text => @user.to_xml, :status => :ok) }
      else
        format.xml { render(:text => '', :status => :not_found) }
      end
    end
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
