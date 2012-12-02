class UserlocationsController < ApplicationController
  # GET /userlocations
  # GET /userlocations.json
  def index
    @userlocations = Userlocation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @userlocations }
    end
  end

  # GET /userlocations/1
  # GET /userlocations/1.json
  def show
    @userlocation = Userlocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @userlocation }
    end
  end

  # GET /userlocations/new
  # GET /userlocations/new.json
  def new
    @userlocation = Userlocation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @userlocation }
    end
  end

  # GET /userlocations/1/edit
  def edit
    @userlocation = Userlocation.find(params[:id])
  end

  # POST /userlocations
  # POST /userlocations.json
  def create
      require 'open-uri'
      require 'json'
    @userlocation = Userlocation.new(params[:userlocation])
         
    #store in session variables
    session[:uAddress] = @userlocation.address.tr(' ','+')
    if @userlocation.lat == nil
      url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{session[:uAddress]}&sensor=false"
      geocode_result = ActiveSupport::JSON.decode(open(url).read)
      session[:uLat] = geocode_result["results"][0]["geometry"]["location"]["lat"]
      session[:uLng] = geocode_result["results"][0]["geometry"]["location"]["lng"]
    else
      session[:uLat] = @userlocation.lat
      session[:uLng] = @userlocation.lng
    end
    
    # scope back out to the city level
    url2 = "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&latlng=#{session[:uLat]},#{session[:uLng]}"
    reverse_geocode_result = ActiveSupport::JSON.decode(open(url2).read)

    # find the city
    arrayLen = reverse_geocode_result["results"].length
    reverse_geocode_result["results"].each do |result|
      if result["types"][0] == "locality"
        session[:uCity] = result["formatted_address"]
      end
    end
    
    

    # do we already have this address (at the city level) in our Droutes db?
    # NB look at dimension in Userlocations table first
  
    # if Userlocation.where(:origin => session[:uCity])  == nil
    #     #add to Droutes table
    #     droutes.create
    # end


    # Boilerplate code
    redirect_to '/show'
#    respond_to do |format|
    #   if @userlocation.save
    #     format.html { redirect_to @userlocation, notice: 'Userlocation was successfully created.' }
    #     format.json { render json: @userlocation, status: :created, location: @userlocation }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @userlocation.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /userlocations/1
  # PUT /userlocations/1.json
  def update
    @userlocation = Userlocation.find(params[:id])

    respond_to do |format|
      if @userlocation.update_attributes(params[:userlocation])
        format.html { redirect_to @userlocation, notice: 'Userlocation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @userlocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userlocations/1
  # DELETE /userlocations/1.json
  def destroy
    @userlocation = Userlocation.find(params[:id])
    @userlocation.destroy

    respond_to do |format|
      format.html { redirect_to userlocations_url }
      format.json { head :no_content }
    end
  end
end
