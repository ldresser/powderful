class ResortsController < ApplicationController
  # GET /resorts
  # GET /resorts.json
  def index
    require 'open-uri'
    require 'json'


    # @resorts = Resort.order("cast(verticalDrop as int) desc")
    @resorts = Resort.all


    # Boundaries for the map
    @lat_max = [Resort.maximum("latitude"),session[:uLat]].max
    @lng_max = [Resort.maximum("longitude"),session[:uLng]].max
    @lat_min = [Resort.minimum("latitude"),session[:uLat]].min
    @lng_min = [Resort.minimum("longitude"),session[:uLng]].min
    #@map_bound = "sw?:#{lat_min},#{lng_min},ne?:#{lat_max},#{lng_max}"
    # @map_bound = "#{lat_min},#{lng_min},#{lat_max},#{lng_max}"
    

    # Query the Google Distance Matrix API

    # (1/2) Build destination & origin strings (all zip codes in order)
    dest_str =""
    @resorts.each do |resort|
      if dest_str.empty?
        dest_str ="#{resort.latitude},#{resort.longitude}"
      else
        dest_str = "#{dest_str}|#{resort.latitude},#{resort.longitude}"
      end
    end
    org_str = "#{session[:uLat]},#{session[:uLng]}"
    @dest_str = dest_str
    
    # # (2/2) Drop into URL and poll Google  
    # gmatrix_url = "http://maps.googleapis.com/maps/api/distancematrix/json?origins=#{org_str}&mode=driving&units=imperial&sensor=false&destinations=#{dest_str}"
    # @gmatrix_result = ActiveSupport::JSON.decode(open(URI.encode(gmatrix_url)).read)
    # # maybe split preceding line and check the open function is json
    # # note: distance int is in metres, time is in seconds

    # # drop the time values into an array so we can query the min and max
    # drive_times = []
    # @resorts.each do |resort|
    #   drive_times << @gmatrix_result["rows"][0]["elements"][resort.id - 1]["duration"]["value"]
    # end 
     @drive_secs_min = Resort.minimum("duration_value")
     @drive_secs_max = Resort.maximum("duration_value")
     @price_max = Resort.maximum("price")
     @price_min = Resort.minimum("price")


    # # HAMWeather API (note: huge data return, rate-limited)
    # dest_str_csv = dest_str.gsub('|',',/forecasts/')
    # ham_id = "ONgIFsqwY9VDB0vCdEr2t"
    # ham_token = "cYqMYSEFJjWEGQJ79ULJCM1xzhPAr0HIgpWJL9da"
    # @hweather_url = "http://api.aerisapi.com/batch?requests=/forecasts/#{dest_str_csv}&client_id=#{ham_id}&client_secret=#{ham_token}"
    # @hweather_result = ActiveSupport::JSON.decode(open(URI.encode(@hweather_url)).read)

    # OpenSnow.com API (note: needs attribution)
    # (1) Get list of IDs
    # @opensnowidstr = ""
    # oslocs = %w[NY ME MA CT NH VT]
    # oslocs.each do |w|
    #   osid_url = "http://opensnow.com/api/getLocationIds.php?apikey=mattboys&state=#{w}&type=json"
    #   @osid_result = ActiveSupport::JSON.decode(open(URI.encode(osid_url)).read)
    # end 
     
    # Snocountry (free to 12/26, then paid)
    #apiKey=angel921.hacksam56
    # sc_url = "http://feeds.snocountry.com/conditions.php?apiKey=angel921.hacksam56&regions=northeast"
    sc_url = "http://feeds.snocountry.com/conditions.php?apiKey=angel921.hacksam56&regions=northeast"
    @sc_result = ActiveSupport::JSON.decode(open(URI.encode(sc_url)).read)
    scArray = @sc_result["items"]
    
    #@resorts.each do |resort| 
      # find the hash in scArray where id == resort.snocountry_id

      ## slow way:
      # scx = scArray.find { |h| h["id"] == resort.snowcountry_id}

      ## fast way (build a hash):
      #Hash[scArray.map { |h| h.values_at('id','newSnowMin')}]
      @scHash = scArray.inject({}) {|h,i| h[i["id"]]=i; h}

      # figure out star rating for each resort
      @scHash.each do |k, v|

          case v["primarySurfaceCondition"]
          when 'Packed Powder'
            p1 = 3
          when 'Powder'
            p1 = 4
          when 'Hard Pack'
            p1 = 2
          when 'Lose Granular'
            p1 = 3
          when 'Frozen Granular'
            p1 = 2
          when 'Wet Packed'
            p1 = 2
          when 'Wet Granular'
            p1 = 1
          when 'Wet Snow'
            p1 = 2
          when 'Spring Conditions'
            p1 = 3
          when 'Windblown'
            p1 = 2
          when 'Corn Snow'
            p1 = 1
          when 'Icy'
            p1 = 1
          when 'Variable Conditions'
            p1 = 2
          else
            p1 = 0
          end      
             
         case v["forecastBaseTemp"].to_i 
         when v["forecastBaseTemp"].to_i < 0
          p2 = 0
        when 0..15
          p2 = 1
        when 16..25
          p2 = 2
        when 26..35
          p2 = 3
        when 36..45
          p2 = 4
        when 46..55
          p2 = 1
        else
          p2 = 0
        end 

        p3 = [v["avgBaseDepthMin"].to_i/6,4].min
        p4 = [v["newSnowMin"].to_i/3,3].min

        case v["nightGrooming"]
        when "yes"
          p5 = 3
        else 
          p5 = 0
        end

        p6 = v["openDownHillTrails"].to_i / 20

         v["stars"] = (p1 + p2 + p3 + p4 + p5 + p6)

     end

        
     @c = @resorts.map do |resort|
        
        resort["resortStatus"] = @scHash[resort["snowcountry_id"].to_s]["resortStatus"]
        resort["openDownHillTrails"] = @scHash[resort["snowcountry_id"].to_s]["openDownHillTrails"]
        resort["openDownHillLifts"] = @scHash[resort["snowcountry_id"].to_s]["openDownHillLifts"]
        resort["newSnowMin"] = @scHash[resort["snowcountry_id"].to_s]["newSnowMin"]
        resort["newSnowMax"] = @scHash[resort["snowcountry_id"].to_s]["newSnowMax"]
        resort["snowLast48Hours"] = @scHash[resort["snowcountry_id"].to_s]["snowLast48Hours"]
        resort["primarySurfaceCondition"] = @scHash[resort["snowcountry_id"].to_s]["primarySurfaceCondition"]
        resort["avgBaseDepthMin"] = @scHash[resort["snowcountry_id"].to_s]["avgBaseDepthMin"]
        resort["avgBaseDepthMax"] = @scHash[resort["snowcountry_id"].to_s]["avgBaseDepthMax"]
        resort["snowComments"] = @scHash[resort["snowcountry_id"].to_s]["snowComments"]
        resort["stars"] = @scHash[resort["snowcountry_id"].to_s]["stars"] + (resort.verticaldrop.to_i / 350)
        resort["forecastWeather"] = @scHash[resort["snowcountry_id"].to_s]["forecastWeather"] 

        resort
      end

          # @resorts = Resort.order("cast(verticalDrop as int) desc")
        @resort_sorted = @resorts.sort_by { |h| h[:stars] }.reverse!


   # Resort.prep_for_view()

    # Last thing .. generate page
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resorts }
    end
  end

  # GET /resorts/1
  # GET /resorts/1.json
  def show
    @resort = Resort.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resort }
    end
  end

  # GET /resorts/new
  # GET /resorts/new.json
  def new
    @resort = Resort.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resort }
    end
  end

  # GET /resorts/1/edit
  def edit
    @resort = Resort.find(params[:id])
  end

  # POST /resorts
  # POST /resorts.json
  def create
    @resort = Resort.new(params[:resort])

    respond_to do |format|
      if @resort.save
        format.html { redirect_to @resort, notice: 'Resort was successfully created.' }
        format.json { render json: @resort, status: :created, location: @resort }
      else
        format.html { render action: "new" }
        format.json { render json: @resort.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /resorts/1
  # PUT /resorts/1.json
  def update
    @resort = Resort.find(params[:id])

    respond_to do |format|
      if @resort.update_attributes(params[:resort])
        format.html { redirect_to @resort, notice: 'Resort was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resort.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resorts/1
  # DELETE /resorts/1.json
  def destroy
    @resort = Resort.find(params[:id])
    @resort.destroy

    respond_to do |format|
      format.html { redirect_to resorts_url }
      format.json { head :no_content }
    end
  end
end

