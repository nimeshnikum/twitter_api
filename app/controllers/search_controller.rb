require 'open-uri'
require 'json'

class SearchController < ApplicationController
  geocode_ip_address

  def index
#    @geocode
##    geocode = Geocoders::MultiGeocoder.geocode(request.remote_ip)
#    p "1111111111111111111111111111111111"
#    p geocode.lng
#    p geocode.lat
    unless params[:q].blank?
      @search_results = JSON.parse(open("http://search.twitter.com/search.json?geocode=#{@geocode.lat},#{@geocode.lng},1000.0km&q=#{params[:q]}").read)["results"]
      a = @search_results.collect {|s| s["text"]}
      b = exec("curl -i -X POST -u 'ajay123:regius' -F 'dataset[csv]=@spreadsheet.csv;name=spreadsheet.csv' http://geocommons.com/datasets.json")
      raise b.inspect
#      respond_to do |format|
#        format.js {send(a)}
#      end
#      raise params[:q].inspect
    end
  end
end
