class PruebaController < ApplicationController
  def index
  end

  def test_api
    # @client_dni = '76492801-6'
    # @debtor_dni = '77360390-1'
    # @document_amount = 1000000
    # @folio = 75
    # @fecha_vencimiento = '2021-03-10'
    @client_dni = params[:rutEmisor]
    @debtor_dni = params[:rutDeudor]
    @document_amount = params[:monto].to_i
    @folio = params[:folio]
    @fecha_vencimiento = params[:fechaVencimiento]
    headers = { 
      "X-Api-Key"  => ENV["X_API_KEY"], 
    }
    p "https://chita.cl/api/v1/pricing/simple_quote?client_dni=#{@client_dni}&debtor_dni=#{@debtor_dni}&document_amount=#{@document_amount}&folio=#{@folio}&expiration_date=#{@fecha_vencimiento}"
    json_response = HTTParty.get(
      "https://chita.cl/api/v1/pricing/simple_quote?client_dni=#{@client_dni}&debtor_dni=#{@debtor_dni}&document_amount=#{@document_amount}&folio=#{@folio}&expiration_date=#{@fecha_vencimiento}",
      :headers => headers
    )
    json = ActiveSupport::JSON.decode(json_response.to_json)
    p json
    @costo_financiamiento = @document_amount * ( json['advance_percent'] / 100) * ((json['document_rate'] / 100) / 30 * 31)
    p @costo_financiamiento
    @giro = (@document_amount * ( json['advance_percent'] / 100)) - @costo_financiamiento - json['commission']
    p @giro
    @excedente = @document_amount - (@document_amount * ( json['advance_percent'] / 100))
    p @excedente

    redirect_to prueba_results_path( :costo => @costo_financiamiento, :giro => @giro, :excedente => @excedente )
  end

  def results
    @costo = params[:costo].to_f.round
    @giro = params[:giro].to_f.round
    @excedente = params[:excedente].to_f.round
  end
end
