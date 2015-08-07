class AppliancesController < ApplicationController
  def index
    @appliances = Appliance.all
    @total_reachable = Target.where( reachable: true ).count
    @total_unreachable = Target.where( reachable: false ).count
    @percentage_reachable = "%.2f" % [(@total_reachable.to_f / (@total_reachable + @total_unreachable) ) * 100]
    @percentage_unreachable = "%.2f" % [(@total_unreachable.to_f / (@total_reachable + @total_unreachable) ) * 100]
  end

  def show
    @appliance = Appliance.find( params[:id] )
    @total_reachable = @appliance.targets.reachable.count
    @total_unreachable = @appliance.targets.unreachable.count
    @percentage_reachable = "%.2f" % [(@total_reachable.to_f / (@total_reachable + @total_unreachable) ) * 100]
    @percentage_unreachable = "%.2f" % [(@total_unreachable.to_f / (@total_reachable + @total_unreachable) ) * 100]
  end
end
