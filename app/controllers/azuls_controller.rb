class AzulsController < ApplicationController
  before_action :set_azul, only: [:show, :edit, :update, :destroy]

  # GET /azuls
  # GET /azuls.json
  def index
    @azuls = Azul.all
  end

  # GET /azuls/1
  # GET /azuls/1.json
  def show
  end

  # GET /azuls/new
  def new
    @azul = Azul.new
  end

  # GET /azuls/1/edit
  def edit
  end

  # POST /azuls
  # POST /azuls.json
  def create
    @azul = Azul.new(azul_params)

    respond_to do |format|
      if @azul.save
        format.html { redirect_to @azul, notice: 'Azul was successfully created.' }
        format.json { render :show, status: :created, location: @azul }
      else
        format.html { render :new }
        format.json { render json: @azul.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /azuls/1
  # PATCH/PUT /azuls/1.json
  def update
    respond_to do |format|
      if @azul.update(azul_params)
        format.html { redirect_to @azul, notice: 'Azul was successfully updated.' }
        format.json { render :show, status: :ok, location: @azul }
      else
        format.html { render :edit }
        format.json { render json: @azul.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /azuls/1
  # DELETE /azuls/1.json
  def destroy
    @azul.destroy
    respond_to do |format|
      format.html { redirect_to azuls_url, notice: 'Azul was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def page_forwarding_mode
    @azul = Azul.first
    if !@azul.present?
      @azul = Azul.new
    end

  end

  def forward_to_azul_payment_page
    puts "params: #{params.inspect}"
  end

  def api_mode
    @azul_json = AzulJson.first
    if !@azul_json.present?
      @azul_json = AzulJson.new
    end
  end

  def make_payment_by_azul_api
    puts "==== params: #{params.inspect} ===="
    # save to database
    azul_json = AzulJson.first
    if azul_json.present?
      azul_json.update(azul_json_params)
    else
      azul_json = AzulJson.create(azul_json_params)
      azul_json.save!
    end
    body_data = azul_json_params_for_remote.to_json
    puts "===== azul_json_body_data: #{body_data}"
    # make POST request to azul.com.do
    make_post_req(azul_json, body_data)
    redirect_to api_mode_azuls_path
  end

  def approved
    puts "==== params: #{params.inspect} ===="
    flash[:notice] = t("AZUL approved successfully!")
    redirect_to page_forwarding_mode_azuls_path
  end

  def canceled
    puts "==== params: #{params.inspect} ===="
    flash[:error] = flash[:error] = "AZUL canceled!"
    redirect_to page_forwarding_mode_azuls_path
  end

  def declined
    puts "==== params: #{params.inspect} ===="
    flash[:error] = "AZUL declined."
    redirect_to page_forwarding_mode_azuls_path
  end

  def response_post
    puts "==== params: #{params.inspect} ===="
    flash[:notice] = t("AZUL sent you a respose!")
    redirect_to page_forwarding_mode_azuls_path
  end

  def get_auth_hash
    # save to database
    azul = Azul.first
    if azul.present?
      azul.update(azul_params_from_api)
    else
      azul = Azul.create(azul_params_from_api)
      azul.save!
    end
    # make auth_hash
    origin_auth =  "#{params[:merchant_id]}#{params[:merchant_name]}#{params[:merchant_type]}#{params[:currency]}#{params[:order_number]}#{params[:amount]}#{params[:approved_url]}#{params[:declined_url]}#{params[:cancel_url]}#{params[:response_post_url]}#{params[:custom_field_1]}#{params[:custom_field_1_label]}#{params[:custom_field_1_value]}#{params[:custom_field_2]}#{params[:custom_field_2_label]}#{params[:custom_field_2_value]}#{params[:auth_key]}"

    auth_hash = Digest::SHA512.hexdigest origin_auth
    render json: {auth_hash: auth_hash, origin_auth: origin_auth}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_azul
      @azul = Azul.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def azul_params
      params.require(:azul).permit(:merchant_id, :merchant_type, :merchant_name, :auth_key, :url_azul, :approved_url, :declined_url, :cancel_url, :response_post_url, :custom_field_1, :custom_field_1_label, :custom_field_1_value, :custom_field_2, :custom_field_2_label, :custom_field_2_value)
    end

    def azul_params_from_api
      params.permit(:merchant_id, :merchant_type, :merchant_name, :auth_key, :url_azul, :approved_url, :declined_url, :cancel_url, :response_post_url, :custom_field_1, :custom_field_1_label, :custom_field_1_value, :custom_field_2, :custom_field_2_label, :custom_field_2_value)
    end

    def azul_json_params_for_remote
      azul_json_parameters = params[:azul_json]
      azul_json_parameters[:rrn] = nil if !azul_json_parameters[:rrn].present? or azul_json_parameters[:rrn] == ''
      azul_json_parameters.permit(:channel, :store, :card_number, :expiration, :cvc, :pos_input_mode, :trx_type, :amount, :currency_pos_code, :payments, :plan, :original_date, :original_trx_ticket_nr, :customer_service_phone, :acquirer_ref_data, :order_number, :custom_order_id, :rrn, :e_commerce_url)
    end

    def azul_json_params
      azul_json_parameters = params[:azul_json]
      azul_json_parameters[:rrn] = nil if !azul_json_parameters[:rrn].present? or azul_json_parameters[:rrn] == ''
      azul_json_parameters.permit(:azul_json_url, :auth1, :auth2, :channel, :store, :card_number, :expiration, :cvc, :pos_input_mode, :trx_type, :amount, :currency_pos_code, :payments, :plan, :original_date, :original_trx_ticket_nr, :customer_service_phone, :acquirer_ref_data, :order_number, :custom_order_id, :rrn, :e_commerce_url)
    end

    def make_post_req(azul_json, body)
      require 'net/http'
      require 'json'
      begin
        uri = URI(azul_json.azul_json_url)
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json',
          'Auth1' => azul_json.auth1,
          'Auth2' => azul_json.auth2})
        req.body = body
        puts "======== request: #{req.inspect}"
        res = http.request(req)
        puts "======== response: #{res.body}"
        response_data = JSON.parse(res.body)
        flash[:notice] = "request:\nauth1: #{azul_json.auth1}\nauth2: #{azul_json.auth2}\nrequest_body: #{body}\n\nresponse from azul: #{response_data}"
      rescue => e
        puts "==== failed #{e}"
        flash[:error] = "request:\nauth1: #{azul_json.auth1}\nauth2: #{azul_json.auth2}\nrequest_body: #{body}\n\nfailed payment: #{e}"
        response_data = nil
      end
    end
end
