class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
    if @user.nil?
      redirect_to users_path, alert: "Author not found."
    elsif !@user.uid.nil?
      redirect_to user_path(@user)
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    if @user.valid?
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by(username: params[:username])
    @user.destroy
    redirect_to '/'
  end

  def blog
    @user = User.find_by(id: params[:id])
  end

  def editblog
    @user = User.find_by(id: params[:id])
    redirect_to blog_path if @user != current_user
  end

  private
  def user_params
    params.require(:user).permit(:id, :email, :username, :password, :password_confirmation)
  end
end
