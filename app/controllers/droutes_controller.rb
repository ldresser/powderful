class DroutesController < ApplicationController
  # GET /droutes
  # GET /droutes.json
  def index
    @droutes = Droute.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @droutes }
    end
  end

  # GET /droutes/1
  # GET /droutes/1.json
  def show
    @droute = Droute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @droute }
    end
  end

  # GET /droutes/new
  # GET /droutes/new.json
  def new
    @droute = Droute.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @droute }
    end
  end

  # GET /droutes/1/edit
  def edit
    @droute = Droute.find(params[:id])
  end

  # POST /droutes
  # POST /droutes.json
  def create
     @droute = Droute.new
    # this is the locale to add to the d-routing table
    city = session[:uCity]

        # (1/2) Build destination & origin strings (all zip codes in order)
    dest_str =""
    num_resorts = 0
    @resorts.each do |resort|
      if dest_str.empty?
        dest_str = resort.zip.strip
        num_resorts++
      elsif resort.zip.strip == "03251"
        dest_str = "#{dest_str}|60+Loon+Mountain+Road+Lincoln,+NH+03251"
        num_resorts++
      else
        dest_str = "#{dest_str}|#{resort.zip.strip}"
        num_resorts++
      end
    end
    org_str = "#{session[:uLat]},#{session[:uLng]}"
    @dest_str = dest_str
    
    # (2/2) Drop into URL and poll Google  
    # gmatrix2_url = "http://maps.googleapis.com/maps/api/distancematrix/json?origins=#{org_str}&mode=driving&units=imperial&sensor=false&destinations=#{dest_str}"
    # gmatrix2_result = ActiveSupport::JSON.decode(open(URI.encode(gmatrix2_url)).read)
    # maybe split preceding line and check the open function is json
    # note: distance int is in metres, time is in seconds

    @droute.origin = session[:uCity]
    @droute.resort_address = gmatrix2_result["destination_addresses"][i]
    @droute.distance_str = gmatrix2_result["rows"][0]["elements"][i]["distance"]["text"]
    @droute.distance_int = gmatrix2_result["rows"][0]["elements"][i]["distance"]["value"]
    @droute.drive_time_str = gmatrix2_result["rows"][0]["elements"][i]["duration"]["text"]
    @droute.drive_time_int = gmatrix2_result["rows"][0]["elements"][i]["duration"]["value"]

    respond_to do |format|
      if @droute.save
        format.html { redirect_to @droute, notice: 'Droute was successfully created.' }
        format.json { render json: @droute, status: :created, location: @droute }
      else
        format.html { render action: "new" }
        format.json { render json: @droute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /droutes/1
  # PUT /droutes/1.json
  def update
    @droute = Droute.find(params[:id])

    respond_to do |format|
      if @droute.update_attributes(params[:droute])
        format.html { redirect_to @droute, notice: 'Droute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @droute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /droutes/1
  # DELETE /droutes/1.json
  def destroy
    @droute = Droute.find(params[:id])
    @droute.destroy

    respond_to do |format|
      format.html { redirect_to droutes_url }
      format.json { head :no_content }
    end
  end
end

