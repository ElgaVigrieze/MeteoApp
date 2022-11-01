module DatabaseServices
  class Record

    def initialize
    end

    def get_values(month,parameter_id)
      value_sum = 0
      count = 0
      
      ::Record.all.each do |record|
        if record.time.month == month
            if record.parameter_id == parameter_id
              value_sum += record.value
              count += 1
        end
        end
      end
      if count ==0
        return "n/a"
      else
        return value_sum/count
      end
    end

  end
end
