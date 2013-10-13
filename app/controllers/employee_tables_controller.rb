class EmployeeTablesController < ApplicationController
  before_action :set_employee_table, only: [:show, :edit, :update, :destroy]

  # GET /employee_tables
  # GET /employee_tables.json
  def index
    @employee_tables = EmployeeTable.all
  end

  # GET /employee_tables/1
  # GET /employee_tables/1.json
  def show
  end

  # GET /employee_tables/new
  def new
    @employee_table = EmployeeTable.new
  end

  # GET /employee_tables/1/edit
  def edit
  end

  # POST /employee_tables
  # POST /employee_tables.json
  def create
    @employee_table = EmployeeTable.new(employee_table_params)

    respond_to do |format|
      if @employee_table.save
        format.html { redirect_to @employee_table, notice: 'Employee table was successfully created.' }
        format.json { render action: 'show', status: :created, location: @employee_table }
      else
        format.html { render action: 'new' }
        format.json { render json: @employee_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employee_tables/1
  # PATCH/PUT /employee_tables/1.json
  def update
    respond_to do |format|
      if @employee_table.update(employee_table_params)
        format.html { redirect_to @employee_table, notice: 'Employee table was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @employee_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employee_tables/1
  # DELETE /employee_tables/1.json
  def destroy
    @employee_table.destroy
    respond_to do |format|
      format.html { redirect_to employee_tables_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee_table
      @employee_table = EmployeeTable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_table_params
      params.require(:employee_table).permit(:employee_id, :table_id, :assign_date)
    end
end
