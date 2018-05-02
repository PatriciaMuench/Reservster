
# 'Reservster' is a project I was encouraged to build during my web development classes at Startup Institute; 
# I have used the creation of this restaurant reservation web app as an exercise to apply skills I learned in class, 
# and to pursue further learning as I’ve added additional features. 
# The app enables log in by two different types of users: restaurant owners, who must log in to add restaurants and can only 
# edit their own restaurants, and customers, who must log in to make reservations and can only edit their own reservations. 
# Each reservation is associated with both the customer who created it and the restaurant it is made at. 
# Here in the reservations controller, you can see the definition of the different ‘CRUD’ actions for reservations 
# (‘create, read, update, and delete’) and related functions, including authentication and authorization of customers. 
# The identity is tracked of not only the individual reservations, but also of the customer who creates the reservation, 
# and of the restaurant from which the customer initiates the creation of a reservation.
# This app is a work in progress; potential future plans include specifying reservation indexes by customer and by restaurant, 
# as well as adding and enhancing various styling, interactivity, and validation features and writing tests to run.


class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # to help with creation errors:
  before_action :set_restaurant_for_create, only: [:create]

  before_action :authenticate_customer!

  before_action :authorize_customer, only: [:show, :edit, :update, :destroy]

  # add rules regarding users (owners) CRUD'ing reservations?


  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # trying this:
  def customer_index
    # if current_customer
      @reservations = current_customer.reservations
    # end
    # render :index ??
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new

    # to help with creation errors:
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    # to help with creation errors:
    @reservation.customer = current_customer 
    @reservation.restaurant = @restaurant 

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
    def reservation_params
      params.require(:reservation).permit(:date, :time, :party_size, :restaurant_id, :customer_id)
    end 

    # to help with creation errors:
    def set_restaurant_for_create
      @restaurant = Restaurant.find(params[:restaurant][:id])
    end
    # for reference, from views/restaurants/show: 
    # <%= link_to 'New Reservation', new_reservation_path(restaurant_id: @restaurant.id)%>

    def authorize_customer
      unless @reservation.customer == current_customer
        redirect_to reservations_url, notice: 'No touchy!'
        # edit this?
      end
    end
end


