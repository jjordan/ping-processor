class AppliancesController < ApplicationController
  def index
    @appliances = Appliance.all
    @total_reachable = Target.where( reachable: true ).count
    @total_unreachable = Target.where( reachable: false ).count
    @percentage_reachable = calculate_percentage( @total_reachable, (@total_reachable + @total_unreachable) )
    @percentage_unreachable = calculate_percentage( @total_unreachable, (@total_reachable + @total_unreachable) )
  end

  def show
    @appliance = Appliance.find( params[:id] )
    @total_reachable = @appliance.targets.reachable.count
    @total_unreachable = @appliance.targets.unreachable.count
    @percentage_reachable = calculate_percentage( @total_reachable, (@total_reachable + @total_unreachable) )
    @percentage_unreachable = calculate_percentage( @total_unreachable, (@total_reachable + @total_unreachable) )
  end
end
