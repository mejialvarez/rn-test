class Api::V1::Admin::RegistersController < Api::V1::ApiController
  before_action :authenticate_user
  before_action :require_admin

  def create
    user = User.find(params[:user_id])
    register = user.registers.create!(register_params)

    render json: register, status: :created
  end

  def report
    registers = Register.for_user(params[:user_id]).ocurred_between(params[:start], params[:end]).order(occurred_at: :asc)
    statistic = Statistic.new(registers)

    render json: {
      hours: statistic.hours,
      input_total: statistic.input_total,
      output_total: statistic.output_total,
      registers: registers
    }
  end

  private
    def register_params
      params.require(:register).permit(:type, :occurred_at)
    end
end