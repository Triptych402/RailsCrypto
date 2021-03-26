class BitcoinsController < ApplicationController
  before_action :set_bitcoin, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user, only: %i[ show edit update destroy ]
  # GET /bitcoins or /bitcoins.json
  def index
    @bitcoins = Bitcoin.all
    require 'net/http'
    require 'json'

    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=f20de4a4-9bf9-4a57-bdb0-e68559b87260&start=1&limit=5000&convert=USD'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @lookup_bitcoin = JSON.parse(@response)
    @profit_loss = 0
  end

  # GET /bitcoins/1 or /bitcoins/1.json
  def show
    @bitcoins = Bitcoin.all
    require 'net/http'
    require 'json'

    @url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=f20de4a4-9bf9-4a57-bdb0-e68559b87260&start=1&limit=5000&convert=USD'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @show_bitcoin = JSON.parse(@response)
  end

  # GET /bitcoins/new
  def new
    @bitcoin = Bitcoin.new
  end

  # GET /bitcoins/1/edit
  def edit
  end

  # POST /bitcoins or /bitcoins.json
  def create
    @bitcoin = Bitcoin.new(bitcoin_params)

    respond_to do |format|
      if @bitcoin.save
        format.html { redirect_to @bitcoin, notice: "Bitcoin was successfully created." }
        format.json { render :show, status: :created, location: @bitcoin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bitcoin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bitcoins/1 or /bitcoins/1.json
  def update
    respond_to do |format|
      if @bitcoin.update(bitcoin_params)
        format.html { redirect_to @bitcoin, notice: "Bitcoin was successfully updated." }
        format.json { render :show, status: :ok, location: @bitcoin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bitcoin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bitcoins/1 or /bitcoins/1.json
  def destroy
    @bitcoin.destroy
    respond_to do |format|
      format.html { redirect_to bitcoins_url, notice: "Bitcoin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bitcoin
      @bitcoin = Bitcoin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bitcoin_params
      params.require(:bitcoin).permit(:symbol, :user_id, :cost_per, :amount_owned)
    end

def correct_user
  @correct = current_user.bitcoins.find_by(id: params[:id])
  redirect_to bitcoins_path, notice: "이 페이지에 권한이 없습니다." if @correct.nil?
end

end
