class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #skiping authentication for users creation other actions
  skip_before_filter :authenticate_user!, only: [:create, :login, :update]

  # GET /api/v1/users
  # GET /api/v1/users.json
  def index
    @users = User.all
  end

  # GET /api/v1/users/1
  # GET /api/v1/users/1.json
  def show
  end

  # GET /api/v1/users/new
  def new
    @user = User.new
  end

  # GET /api/v1/users/1/edit
  def edit
  end

  # POST /api/v1/users
  # POST /api/v1/users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/users/1
  # PATCH/PUT /api/v1/users/1.json
  def update
    authorize @user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render json: @user, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/users/1
  # DELETE /api/v1/users/1.json
  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  #for new user authentication
  def login
    user_password = params[:user][:password]
    user_email = params[:user][:email]
    user = User.find_by_email(user_email)
     respond_to do |format|
        if user_email.present? && user.present?
          if user.valid_password? user_password
            sign_in user, store: false
            user.save
            format.html { redirect_to api_users_path, notice: 'User was login successfully' }
            format.json { render json: user, status: 200 }
          else
            format.html { redirect_to api_users_path, notice: 'User was login successfully' }
            render json: { errors: "Invalid email or password" }, status: 422
          end
        else
          format.html { redirect_to api_users_path, notice: 'Invalid Registration' }
          render json: {errors: "Invalid Registration"}, status: 422
        end
     end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :user_type, :contact_number, :address, :auth_token)
    end
end
