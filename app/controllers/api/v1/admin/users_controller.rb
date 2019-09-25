class Api::V1::Admin::UsersController < Api::V1::ApiController
  before_action :authenticate_user
  before_action :require_admin

  def index
    users = User.all.employee

    render json: users
  end

  def create
    user = User.create!(user_params)

    render json: user, status: :created
  end

  def update
    user = User.find(params[:id])
    user.update!(user_params)

    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

    head :no_content
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :full_name, :address, :country, :city).merge(role: :employee)
    end
end