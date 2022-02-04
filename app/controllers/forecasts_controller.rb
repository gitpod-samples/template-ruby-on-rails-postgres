class ForecastsController < ApplicationController
  def index
    @address = params[:address]
    geocoder_results = Geocoder.search(@address)
    if geocoder_results
      @latitude, @longitude = geocoder_results.first.coordinates
    end
  end

  def new
  end
end
