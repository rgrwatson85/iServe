class UserTablesController < ApplicationController
  before_action :set_user_table, only: [:show, :edit, :update, :destroy]

  # GET /user_tables
  # GET /user_tables.json
  def index
    @user_tables = UserTable.all
  end

  # GET /user_tables/1
  # GET /user_tables/1.json
  def show
  end

  # GET /user_tables/new
  def new
    @user_table = UserTable.new
  end

  # GET /user_tables/1/edit
  def edit
  end

  # POST /user_tables
  # POST /user_tables.json
  def create
    @user_table = UserTable.new(user_table_params)

    respond_to do |format|
      if @user_table.save
        format.html { redirect_to @user_table, notice: 'User table was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_table }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_tables/1
  # PATCH/PUT /user_tables/1.json
  def update
    respond_to do |format|
      if @user_table.update(user_table_params)
        format.html { redirect_to @user_table, notice: 'User table was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_tables/1
  # DELETE /user_tables/1.json
  def destroy
    @user_table.destroy
    respond_to do |format|
      format.html { redirect_to user_tables_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_table
      @user_table = UserTable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_table_params
      params.require(:user_table).permit(:user_id, :table_id, :assign_date)
    end
end
