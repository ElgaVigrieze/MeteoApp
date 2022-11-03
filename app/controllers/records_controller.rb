class RecordsController < ApplicationController
  before_action :set_record, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token

  # GET /records or /records.json
  def index
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
  def show
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
    # @record = Record.new(record_params)

    # respond_to do |format|
    #   if @record.save
    #     format.html { redirect_to record_url(@record), notice: "Record was successfully created." }
    #     format.json { render :show, status: :created, location: @record }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @record.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /records/1 or /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to record_url(@record), notice: "Record was successfully updated." }
        format.json { render :show, status: :ok, location: @record }
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
