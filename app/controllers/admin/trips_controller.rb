class Admin::TripsController < Admin::BaseController

  def edit
    @trip = Trip.find(params[:id])
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    redirect_to trips_path
  end

end
