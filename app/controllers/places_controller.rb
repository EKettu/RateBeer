class PlacesController < ApplicationController
  def index
  end

  def show
    # byebug
    @place = BeermappingApi.places_in(session[:last_city]).find{ |place| place.id == params[:id] }
    @city = session[:last_city]
  end

  def search
    city = params[:city]
    # binding.pry
    @places = BeermappingApi.places_in(city)
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{city}"
    else
      @weather = BeermappingApi.weather_in(city)
      session[:city] = city
      render :index
    end
  end

#   def search
#     # binding.pry
#     @places = BeermappingApi.places_in(params[:city])
#     @weather = BeermappingApi.weather_in(params[:city])
#     session[:last_city] = params[:city]
#     @city = session[:last_city]
#     if @places.empty?
#       redirect_to places_path, notice: "No locations in #{params[:city]}"
#     else
#       render :index
#     end
#   end
end
