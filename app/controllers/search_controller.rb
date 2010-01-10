require 'open-uri'
require 'json'
require "faster_csv"

class SearchController < ApplicationController
  geocode_ip_address

  def index
    unless params[:q].blank?
      @search_results = JSON.parse(open("http://search.twitter.com/search.json?geocode=#{@geocode.lat},#{@geocode.lng},1000.0km&q=#{params[:q]}").read)["results"]

#      @mycsv = FasterCSV.read("/home/nimesh/Desktop/geocsv/ajay.csv")
      csv_string = FasterCSV.generate do |csv|
        csv << ["id", "profile_image_url", "location", "text", "from_user", "to_user", "geo"]
        @search_results.each do |result|
          csv << [result["id"], result["profile_image_url"], result["location"], result["text"], result["from_user"], result["to_user"], result["geo"]]
        end
      end
      csv_file = File.open("my_new_csv.csv", 'w') {|f| f.write(csv_string) }

      dataset = exec("curl -i -X POST -u 'ajay123:regius' -F 'dataset[csv]=@my_new_csv.csv;name=my_new_csv.csv' http://geocommons.com/datasets.json")
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
