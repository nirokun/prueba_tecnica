class PruebaController < ApplicationController
  def index
  end

  def test_api
    @client_dni = '76492801-6'
    @debtor_dni = '77360390-1'
    @document_amount = 1000000
    @folio = 75
    @fecha_vencimiento = '2021-03-10'
    # @client_dni = params[:rutEmisor]
    # @debtor_dni = params[:rutDeudor]
    # @document_amount = params[:monto]
    # @folio = params[:folio]
    # @fecha_vencimiento = params[:fechaVencimiento]
    headers = { 
      "X-Api-Key"  => ENV["X_API_KEY"], 
    }
    json_response = HTTParty.get(
      "https://chita.cl/api/v1/pricing/simple_quote?client_dni=#{@client_dni}&debtor_dni=#{@debtor_dni}&document_amount=#{@document_amount}&folio=#{@folio}&expiration_date=#{@fecha_vencimiento}",
      :headers => headers
    )
    json = ActiveSupport::JSON.decode(json_response.to_json)
    p json
  end
end
