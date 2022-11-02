module DatabaseServices
  class Record

    def initialize
      # @records = ActiveRecords::Records.all
    end

    def get_values(month,parameter_id)
      value_sum = 0
      count = 0
      ::Record.all.where("parameter_id": parameter_id).each do |r|
        if r.time.month == month
          value_sum += r.value
          count += 1
      end
    end
      if count ==0
        "n/a"
      else
        value_sum/count
      end
    end

  end
end
