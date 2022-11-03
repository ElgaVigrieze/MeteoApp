class ParametersController < ApplicationController
  before_action :set_parameter, only: %i[ show edit update destroy ]

  # GET /parameters or /parameters.json
  def index
    @parameters = Parameter.all
  end

  # GET /parameters/1 or /parameters/1.json
  def show
    @parameters = Parameter.all
    @stations = Station.all
    @parameter = Parameter.find(params[:id])
    @months = Date::ABBR_MONTHNAMES.drop(1)
    @months_n = (1..12).to_a
    @values = get_all_values(@parameter.id)
  end

  # GET /parameters/new
  def new
    @parameter = Parameter.new
  end

  # GET /parameters/1/edit
  def edit
  end

  # POST /parameters or /parameters.json
  def create
    @parameter = Parameter.new(parameter_params)

    respond_to do |format|
      if @parameter.save
        format.html { redirect_to parameter_url(@parameter), notice: "Parameter was successfully created." }
        format.json { render :fun, status: :created, location: @parameter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parameters/1 or /parameters/1.json
  def update
    respond_to do |format|
      if @parameter.update(parameter_params)
        format.html { redirect_to parameter_url(@parameter), notice: "Parameter was successfully updated." }
        format.json { render :fun, status: :ok, location: @parameter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parameters/1 or /parameters/1.json
  def destroy
    @parameter.destroy

    respond_to do |format|
      format.html { redirect_to parameters_url, notice: "Parameter was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parameter
      @parameter = Parameter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parameter_params
      params.require(:parameter).permit(:name, :measuring_unit, :code)
    end

  def get_all_values(parameter_id)
    values=Array.new
    (1..12).each do |i|
      values.append(get_values(i, parameter_id))
    end
    values.delete("n/a")
    values
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

end
