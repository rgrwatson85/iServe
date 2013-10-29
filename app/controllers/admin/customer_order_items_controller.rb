module Admin
  class CustomerOrderItemsController < ManagementHomeController
    before_action :set_customer_order_item, only: [:show, :edit, :update, :destroy]

    # GET /customer_order_items
    # GET /customer_order_items.json
    def index
      @customer_order_items = CustomerOrderItem.all
    end

    # GET /customer_order_items/1
    # GET /customer_order_items/1.json
    def show
    end

    # GET /customer_order_items/new
    def new
      @customer_order_item = CustomerOrderItem.new
    end

    # GET /customer_order_items/1/edit
    def edit
    end

    # POST /customer_order_items
    # POST /customer_order_items.json
    def create
      @customer_order_item = CustomerOrderItem.new(customer_order_item_params)

      respond_to do |format|
        if @customer_order_item.save
          format.html { redirect_to @customer_order_item, notice: 'Customer order item was successfully created.' }
          format.json { render action: 'show', status: :created, location: @customer_order_item }
        else
          format.html { render action: 'new' }
          format.json { render json: @customer_order_item.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /customer_order_items/1
    # PATCH/PUT /customer_order_items/1.json
    def update
      respond_to do |format|
        if @customer_order_item.update(customer_order_item_params)
          format.html { redirect_to @customer_order_item, notice: 'Customer order item was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @customer_order_item.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /customer_order_items/1
    # DELETE /customer_order_items/1.json
    def destroy
      @customer_order_item.destroy
      respond_to do |format|
        format.html { redirect_to customer_order_items_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_customer_order_item
        @customer_order_item = CustomerOrderItem.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def customer_order_item_params
        params.require(:customer_order_item).permit(:customer_order_id, :menu_item_id, :is_menu_item_ready, :waitstaff_note)
      end
  end
  
end
