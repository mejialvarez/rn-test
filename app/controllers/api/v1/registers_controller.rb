class Api::V1::RegistersController < Api::V1::ApiController
  before_action :authenticate_user

  def report
    registers = current_user.registers.ocurred_between(params[:start], params[:end])
    statistic = Statistic.new(registers)

    render json: {
      hours: statistic.hours,
      input_total: statistic.input_total,
      output_total: statistic.output_total,
      registers: registers
    }
  end
end