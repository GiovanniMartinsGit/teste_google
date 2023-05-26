class SalesController < ApplicationController
  before_action :set_sale, only: %i[ show edit update destroy ]

  # GET /sales or /sales.json
  def index
    @sales = Sale.all
    @total_revenue = @sales.sum { |sale| sale.item.price * sale.purchase_count }
  end

  # GET /sales/1 or /sales/1.json
  def show
  end

  # GET /sales/new
  def new
    @sale = Sale.new
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales or /sales.json
  def create
    sales_file = sale_params[:sales_file]
  
    csv_data = CSV.read(sales_file.path, col_sep: "\t", headers: true)
  
    csv_data.each do |row|
      item = Item.find_or_create_by(description: row['item description']) do |i|
        i.price = row['item price'].to_f
      end
  
      merchant = current_merchant
      merchant.update(merchant_address: row['merchant address'])
  
      sale = Sale.new(
        purchaser_name: row['purchaser name'],
        purchase_count: row['purchase count'],
        item: item,
        merchant: merchant
      )
  
      # Calcula a quantidade de itens multiplicando o preço pelo número de compras
      purchase_count = row['purchase count'].to_i
      sale.define_singleton_method(:purchase_count) { purchase_count }
  
      sale.save
    end
  
    redirect_to sales_path, notice: 'Arquivo de vendas processado com sucesso.'
  end
  # PATCH/PUT /sales/1 or /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to sale_url(@sale), notice: "Sale was successfully updated." }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1 or /sales/1.json
  def destroy
    @sale.destroy

    respond_to do |format|
      format.html { redirect_to sales_url, notice: "Sale was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sale_params
      params.require(:sale).permit(:purchaser_name,:purchase_count, :item_id, :merchant_id, :sales_file)
    end
end
