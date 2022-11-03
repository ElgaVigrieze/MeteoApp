class RecordsController < ApplicationController
  before_action :set_record, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /records or /records.json
  def index
  end

  def overview
    @records = Record.all
    @parameters = Parameter.all
    @months = Date::ABBR_MONTHNAMES.drop(1)
    @months_n = (1..12).to_a

  end

  def search
     par = params[:parameter].reject!(&:empty?)
     @parameters = Parameter.where("id": par)
     @months = Date::ABBR_MONTHNAMES.drop(1)
     @months_n = (1..12).to_a
  end


  # GET /records/1 or /records/1.json
  def fun
    @warm = find_top(9)
    @rainy = find_top(3)
    @windy = find_top(5)
    @snowy = find_top(8)
    @humid = find_top(7)
    @pressure = find_top(6)
    @cold = find_bottom(9)
    @dry= find_bottom(3)
    @less_pressure = find_bottom(6)


  end



  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
  end



  # POST /records or /records.json
  def create
  end

  # PATCH/PUT /records/1 or /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to record_url(@record), notice: "Record was successfully updated." }
        format.json { render :fun, status: :ok, location: @record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1 or /records/1.json
  def destroy
    @record.destroy

    respond_to do |format|
      format.html { redirect_to records_url, notice: "Record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

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




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def record_params
      params.require(:record).permit(:station_id, :parameter_id, :time, :value)
    end


  def find_top(parameter_id)
    value = Hash.new
    for i in 5..29
      value[i]=BigDecimal(Record.where("station_id": i, "parameter_id": parameter_id).average("value")).round(2)
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
      value[i]=BigDecimal(Record.where("station_id": i, "parameter_id": parameter_id).average("value")).round(2)
    end
    names=Array.new
    ids = Hash[value.sort_by { |k, v| v }[0..2]].keys
    ids.each do|j|
      names.append(Station.find(j).name)
    end
    names
  end







end
