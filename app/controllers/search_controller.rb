require 'open-uri'
require 'json'

class SearchController < ApplicationController
  def index
    unless params[:q].blank?
      @search_results = JSON.parse(open("http://search.twitter.com/search.json?q=#{params[:q]}").read)['results']
      a = @search_results.collect {|s| s["text"]}
      raise a.inspect
#      respond_to do |format|
#        format.js {send(a)}
#      end
#      raise params[:q].inspect
    end
  end
end
