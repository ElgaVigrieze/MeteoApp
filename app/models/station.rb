class Station < ApplicationRecord

    def get_values(month,parameter_id,station_id)
        data = Record.where("parameter_id": parameter_id).where('EXTRACT(MONTH FROM time) = ?', month).where("station_id": station_id)
        count = data.count
        value_sum = data.sum(:value)
        if count ==0
          "n/a"
        else
          BigDecimal(value_sum/count).round(2)
        end
      end
    
       def get_values_average_per_station(parameter_id,station_id)
         BigDecimal(Record.where("parameter_id": parameter_id).where("station_id": station_id).average("value")).round(2)
      end
    
      def get_value_min_per_station(parameter_id,station_id)
        BigDecimal(Record.where("parameter_id": parameter_id).where("station_id": station_id).minimum("value")).round(2)
      end
    
      def get_value_max_per_station(parameter_id,station_id)
        BigDecimal(Record.where("parameter_id": parameter_id).where("station_id": station_id).maximum("value")).round(2)
      end
    
end
