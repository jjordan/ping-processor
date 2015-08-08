class AppliancesController < ApplicationController
  def index
    @q = Appliance.ransack( params[:q] )
    @appliances = @q.result.paginate( page: params[:page], per_page: 10 )
    @total_reachable = Target.reachable.count
    @total_unreachable = Target.unreachable.count
    @percentage_reachable = calculate_percentage( @total_reachable, (@total_reachable + @total_unreachable) )
    @percentage_unreachable = calculate_percentage( @total_unreachable, (@total_reachable + @total_unreachable) )
  end

  def show
    q_params = params[:q] || {}
    @q = Target.ransack( {appliance_id_eq: params[:id]}.merge( q_params ) )
    @appliance = Appliance.find( params[:id] )
    @targets = @q.result.paginate( page: params[:page], per_page: 10 )
    @total_reachable = @appliance.targets.reachable.count
    @total_unreachable = @appliance.targets.unreachable.count
    @percentage_reachable = calculate_percentage( @total_reachable, (@total_reachable + @total_unreachable) )
    @percentage_unreachable = calculate_percentage( @total_unreachable, (@total_reachable + @total_unreachable) )
  end
end
