require 'test_helper'

class StatisticTest < ActiveSupport::TestCase
  test '#hours return the hours for the registers' do
    registers = Register.ocurred_between("2019-09-15 21:00:00", "2019-09-15 23:00:00")
    statistic = Statistic.new(registers)

    assert 2, statistic.hours
  end

  test '#input_total return the input registers total' do
    registers = Register.ocurred_between("2019-09-15 21:00:00", "2019-09-15 23:00:00")
    statistic = Statistic.new(registers)

    assert 1, statistic.input_total
  end

  test '#output_total return the output registers total' do
    registers = Register.ocurred_between("2019-09-15 21:00:00", "2019-09-15 23:00:00")
    statistic = Statistic.new(registers)

    assert 1, statistic.output_total
  end

  test '#total return the registers total' do
    registers = Register.ocurred_between("2019-09-15 21:00:00", "2019-09-15 23:00:00")
    statistic = Statistic.new(registers)

    assert 2, statistic.total
  end
end