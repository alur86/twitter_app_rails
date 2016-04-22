class TwittsController < ApplicationController

require "base64"
require "json"
require "net/http"
require "uri"
require "oauth"



  before_action :set_twitt, only: [:show, :edit, :update, :destroy]


  # GET /twitts
  # GET /twitts.json
  def index
    @twitt = Twitt.new
  end

  # GET /twitts/1
  # GET /twitts/1.json
  def show

consumer_key = "4hhFXBvyNoJlvlqfE1pRNNZIP"
consumer_secret = "d9qq8faSxBTnvXJQILKABAlPgjOU5lsLbgesvZi5nQllZBbJzW"

bearer_token = "#{consumer_key}:#{consumer_secret}"
bearer_token_64 = Base64.strict_encode64(bearer_token)

twitt_user="AlurRor"

token_uri = URI("https://api.twitter.com/oauth2/token")
token_https = Net::HTTP.new(token_uri.host,token_uri.port)
token_https.use_ssl = true

token_request = Net::HTTP::Post.new(token_uri)
token_request["Content-Type"] = "application/x-www-form-urlencoded;charset=UTF-8"
token_request["Authorization"] = "Basic #{bearer_token_64}"
token_request.body = "grant_type=client_credentials"

token_response = token_https.request(token_request).body
token_json = JSON.parse(token_response)
access_token = token_json["access_token"]


uri = URI("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=#{twitt_user}")
https = Net::HTTP.new(timeline_uri.host,timeline_uri.port)
https.use_ssl = true

request = Net::HTTP::Get.new(timeline_uri)
request["Authorization"] = "Bearer #{access_token}"

response = timeline_https.request(request).body
@twitts_data = JSON.parse(response)

   respond_to do |format|
      format.html
      format.json {render :json => @twitts_data}
      format.xml  {render :xml => @twitts_data}
    end
  end



  end

  # GET /twitts/new
  def new
    @twitt = Twitt.new
  end

  # GET /twitts/1/edit
  def edit
  end

  # POST /twitts
  # POST /twitts.json
  def create

@twitt = Twitt.new(twitt_params)


api_consumer_key = "4hhFXBvyNoJlvlqfE1pRNNZIP"
api_consumer_secret = "d9qq8faSxBTnvXJQILKABAlPgjOU5lsLbgesvZi5nQllZBbJzW"

api_access_token = '2930635024-61PWHUq1TAoL2C0NmgkJKxRF0wBfML0u6OpO7tb'
api_access_secret ='GNSp38VuI5xnCt4aT8yAgiUbJNqJB02wpfCazU9K6M9dQ' 

consumer_key = OAuth::Consumer.new(
  api_consumer_key,
  api_consumer_secret)
access_token = OAuth::Token.new(
  api_access_token,
  api_access_secret)


baseurl = "https://api.twitter.com"
path    = "/1.1/statuses/update.json"
address = URI("#{baseurl}#{path}")
request = Net::HTTP::Post.new address.request_uri
request.set_form_data("status" => @twitt,)

http             = Net::HTTP.new address.host, address.port
http.use_ssl     = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

request.oauth! http, consumer_key, access_token
http.start


response = http.request request

tweet = nil
if response.code == '200' then
  tweet = JSON.parse(response.body)
end

    respond_to do |format|
      if @twitt.save
        format.html { redirect_to @twitt, notice: 'New twitt was successfully created.' }
        format.json { render :show, status: :created, location: @twitt }
      else
        format.html { render :new }
        format.json { render json: @twitt.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_twitt
      @twitt = Twitt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def twitt_params
      params.require(:twitt).permit(:message)
    end
end









