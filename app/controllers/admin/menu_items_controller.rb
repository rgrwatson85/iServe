module Admin
  class MenuItemsController < ManagementHomeController
    before_action :set_menu_item, only: [:show, :edit, :update, :destroy]

    # GET /menu_items
    # GET /menu_items.json
    def index
      @menu_items = MenuItem.all
    end

    # GET /menu_items/1
    # GET /menu_items/1.json
    def show
    end

    # GET /menu_items/new
    def new
      @menu_item = MenuItem.new
    end

    # GET /menu_items/1/edit
    def edit
    end

    # POST /menu_items
    # POST /menu_items.json
    def create
      @menu_item = MenuItem.new(menu_item_params)
      respond_to do |format|
        if @menu_item.save
          format.html { redirect_to @menu_item, notice: 'Menu item was successfully created.' }
          format.json { render action: 'show', status: :created, location: @menu_item }
          format.js   { 
            response.headers['toggle_refresh'] = 'true'
            render :text => 'Menu item was successfully created.'
          }
        else
          format.html { render action: 'new' }
          format.json { render json: @menu_item.errors, status: :unprocessable_entity }
          format.js   { 
            msg = ''
            @menu_item.errors.full_messages.each do |message|
              msg = msg + message + '<br />'
            end
            response.headers['toggle_refresh'] = 'false'
            render :text => msg.upcase
            }
        end
      end
    end

    # PATCH/PUT /menu_items/1
    # PATCH/PUT /menu_items/1.json
    def update
      respond_to do |format|
        if @menu_item.update(menu_item_params)
          format.html { redirect_to @menu_item, notice: 'Menu item was successfully updated.' }
          format.json { head :no_content }
          format.js   { render :text => 'Item updated'}
        else
          format.html { render action: 'edit' }
          format.json { render json: @menu_item.errors, status: :unprocessable_entity }
          format.js   { render :text => 'Item update error!'}
        end
      end
    end

    # DELETE /menu_items/1
    # DELETE /menu_items/1.json
    def destroy
      @menu_item.destroy
      respond_to do |format|
        format.html  { redirect_to menu_items_url }
        format.json { head :no_content }
        format.js   { render :text => 'Menu item was successfully deleted.'}
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_menu_item
        @menu_item = MenuItem.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def menu_item_params
        params.require(:menu_item).permit(:item_name, :item_price, :menu_id)
      end
  end
  
end
