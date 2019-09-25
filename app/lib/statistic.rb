class Statistic
  HOUR = 3600 #seconds

  def initialize(registers)
    @registers = registers
  end

  def total
    @registers.size
  end

  def input_total
    @registers.in.size
  end

  def output_total
    @registers.out.size
  end

  def hours
    first_input = @registers.in.take.try(:occurred_at) || 0
    last_output = @registers.out.last.try(:occurred_at) || 0
    (last_output - first_input) / HOUR
  end
end