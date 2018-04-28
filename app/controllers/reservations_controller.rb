class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # trying this to help with creation errors:
  before_action :set_restaurant_for_create, only: [:create]

  before_action :authenticate_customer!
  # Is it OK not to have only or except? - yes

  before_action :authorize_customer, only: [:show, :edit, :update, :destroy]

  # add rules regarding users (owners) CRUD'ing reservations?

  # trying this to help with creation errors:
  # before_action :set_restaurant, only: [:new]


  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new

    # trying this to help with creation errors:
    # @reservation.restaurant = @restaurant
    # @reservation.restaurant = Restaurant.find(params[:restaurant][:id])
    # @reservation.restaurant = Restaurant.find(params[:restaurant_id])
    @restaurant = Restaurant.find(params[:restaurant_id])


  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    # trying this to help with creation errors:
    @reservation.customer = current_customer # this one seems to be working
    # same as doing @restaurant.user_id = current_user.id
    # @reservation.restaurant = current_restaurant
    # @reservation.restaurant = restaurant
    @reservation.restaurant = @restaurant # this one doesn't work yet - ?
    # @reservation.restaurant_id = @restaurant.id
    # @reservation.restaurant_id = @restaurant

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # trying this to help with creation errors (comment out restaurant_id and customer_id):
    def reservation_params
      params.require(:reservation).permit(:date, :time, :party_size, :restaurant_id, :customer_id)
    end 

    # trying this to help with creation errors:
    # def set_restaurant
    #   @restaurant = Restaurant.find(params[:restaurant_id])
    # end

    def set_restaurant_for_create
      @restaurant = Restaurant.find(params[:restaurant][:id])
      # @restaurant = Restaurant.find(params[:restaurant_id])
      # @restaurant = params[:restaurant][:id]
      # @restaurant = params[:restaurant][:id].to_i
      # @restaurant = Restaurant(params[:restaurant][:id])
      # @restaurant.id = params[:restaurant_id]
      # @restaurant = params[:restaurant_id]
    end
    # for reference, from views/restaurants/show: 
    # <%= link_to 'New Reservation', new_reservation_path(restaurant_id: @restaurant.id)%>

    # edit this?:
    def authorize_customer
      unless @reservation.customer == current_customer
        redirect_to reservations_url, notice: 'No touchy!'
      end
    end
end
