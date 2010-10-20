class SearchController < ApplicationController
  def index
    unless params[:search_keyword].blank?
      raise params[:search_keyword].inspect
    end
  end
end
