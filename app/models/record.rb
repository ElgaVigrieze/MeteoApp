class Record < ApplicationRecord
  belongs_to :station
  belongs_to :parameter

  def get_values(month,parameter_id)
    data = Record.where("parameter_id": parameter_id).where('EXTRACT(MONTH FROM time) = ?', month).average("value")
    if data != nil
      BigDecimal(data).round(2)
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

  def find_top(parameter_id)
    value = Hash.new
    for i in 5..29
     n=BigDecimal(Record.where("station_id": i, "parameter_id": parameter_id).average("value")).round(2)
      if n != nil
        value[i]=n
     end
    end
    names=Array.new
    ids = Hash[value.sort_by { |k, v| -v }[0..2]].keys
    ids.each do|j|
      names.append(Station.find(j).name)
    end
    names
  end

  def find_bottom(parameter_id)
    value = Hash.new
    for i in 5..29
      n = BigDecimal(Record.where("station_id": i, "parameter_id": parameter_id).average("value")).round(2)
      if n != nil
         value[i]=n
      end
    end
    names=Array.new
    ids = Hash[value.sort_by { |k, v| v }[0..2]].keys
    ids.each do|j|
      names.append(Station.find(j).name)
    end
    names
  end

  def get_all_values(parameter_id)
    values=Array.new
    (1..12).each do |i|
      values.append(get_values(i, parameter_id))
    end
    values.delete(nil)
    values
  end


end

