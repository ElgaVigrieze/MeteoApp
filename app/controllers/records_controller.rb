class RecordsController < ApplicationController
  before_action :set_record, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /records or /records.json
  def index
  end

  def overview
    @months = Date::ABBR_MONTHNAMES.drop(1)
    @months_n = (1..12).to_a
    @parameters = Parameter.all
  end


  # GET /records/1 or /records/1.json
  def fun
    @warm = Record.new.find_top(9)
    @rainy = Record.new.find_top(3)
    @windy = Record.new.find_top(5)
    @snowy = Record.new.find_top(8)
    @humid = Record.new.find_top(7)
    @pressure = Record.new.find_top(6)
    @cold = Record.new.find_bottom(9)
    @dry= Record.new.find_bottom(3)
    @less_pressure = Record.new.find_bottom(6)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def record_params
      params.require(:record).permit(:station_id, :parameter_id, :time, :value)
    end

end
