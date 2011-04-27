class BussesController < ApplicationController
  #TODO: before_filter :auth_user_or_admin
  before_filter :authenticate_user!
  
  def index
    @busses = current_user.busses.map do |b| 
      location = $zonar.bus(b.fleet_id)
      { 
        :type => "Point",
        :coordinates => [
          location['currentlocations']['asset']['long'],
          location['currentlocations']['asset']['lat']
        ]
      }
    end
    
    
  end
  
  private
  def auth_user_or_admin
    #TODO: write
  end
end
