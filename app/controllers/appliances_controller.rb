class AppliancesController < ApplicationController
  def index
    @appliances = Appliance.all.paginate( page: params[:page], per_page: 10 )
    @total_reachable = Target.reachable.count
    @total_unreachable = Target.unreachable.count
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
