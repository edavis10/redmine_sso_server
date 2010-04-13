class LoginsController < ApplicationController
  def create
    @user = User.try_to_login(params[:login], params[:password])

    respond_to do |format|
      if @user
        format.xml { render(:text => @user.to_xml, :status => :ok) }
      else
        format.xml { render(:text => '', :status => :unauthorized) }
      end
    end
    
  end
  
end
