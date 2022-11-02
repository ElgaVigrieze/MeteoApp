class Record < ApplicationRecord
  belongs_to :station
  belongs_to :parameter



  # def get_values(month,parameter_id)
  #   value_sum = 0
  #   count = 0
  #   Record.all.where("parameter_id": parameter_id).each do |r|
  #     if r.time.month == month
  #       value_sum += r.value
  #       count += 1
  #   end
  # end
  #   if count ==0
  #     "n/a"
  #   else
  #     value_sum/count
  #   end
  # end

  def get_values(month,parameter_id)
    data = Record.where("parameter_id": parameter_id).where('EXTRACT(MONTH FROM time) = ?', month)
    count = data.count
    value_sum = data.sum(:value)
    if count ==0
      "n/a"
    else
      BigDecimal(value_sum/count).round(2)
    end
  end

    def get_values_average(parameter_id)
      BigDecimal(Record.all.where("parameter_id": parameter_id).average("value")).round(2)
  end

  def get_value_min(parameter_id)
    BigDecimal(Record.all.where("parameter_id": parameter_id).minimum("value")).round(2)
  end

  def get_value_max(parameter_id)
    BigDecimal(Record.all.where("parameter_id": parameter_id).maximum("value")).round(2)
  end

end

