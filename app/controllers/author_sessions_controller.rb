class AuthorSessionsController < ApplicationController
	before_filter :zero_authors_or_authenticated, only: [:new, :create]

  def zero_authors_or_authenticated
    unless Author.count == 0 || current_user
      redirect_to root_path # articles list
      return false
    end
  end

  def new
  end

  def create
    if login(params[:username], params[:password])
      redirect_back_or_to(articles_path, message: 'Logged in succesfully.')
    else
      flash.now.alert = "Login failed."
      render action: :new
    end
  end

  def destroy
    logout
    redirect_to(:authors, message: 'Logged out!')
  end
end