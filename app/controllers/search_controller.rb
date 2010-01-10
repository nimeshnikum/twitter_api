require 'open-uri'
require 'json'
require "faster_csv"

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
      raise @search_results.inspect
      @mycsv = FasterCSV.read("/home/nimesh/Desktop/geocsv/ajay.csv")
      csv_string = FasterCSV.generate do |csv|
        @mycsv.each do |mycsv|
          csv << mycsv
        end
      end
      csv_file = File.open("my_new_csv.csv", 'w') {|f| f.write(csv_string) }

      
#      @search_results = "http://search.twitter.com/search.json?geocode=#{@geocode.lat},#{@geocode.lng},1000.0km&q=#{params[:q]}"
#      raise @search_results.inspect
#      a = @search_results.collect {|s| s["text"]}
      b = exec("curl -i -X POST -u 'ajay123:regius' -F 'dataset[csv]=@my_new_csv.csv;name=my_new_csv.csv' http://geocommons.com/datasets.json")
#
#      @map_id = exec("curl -i -X GET -u 'ajay123:regius' http://geocommons.com/maps/new?overlay_id=#{69844}")
#      raise c.inspect
#      b = exec("curl -i -X POST -u 'ajay123:regius' -d 'url=http://search.twitter.com/search.json?geocode=#{@geocode.lat},#{@geocode.lng},1000.0km&q=#{params[:q]}' http://geocommons.com/datasets")
#      raise b.inspect
#      respond_to do |format|
#        format.js {send(a)}
#      end
#      raise params[:q].inspect
    end
  end
end
