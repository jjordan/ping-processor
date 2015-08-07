class TargetsController < ApplicationController
skip_before_filter  :verify_authenticity_token

  def index
    @targets = Target.all
    @total_reachable = @targets.reachable.count
    @total_unreachable = @targets.unreachable.count
    @percentage_reachable = calculate_percentage( @total_reachable, (@total_reachable + @total_unreachable) )
    @percentage_unreachable = calculate_percentage( @total_unreachable, (@total_reachable + @total_unreachable) )
  end

  def show
    @target = Target.find( params[:id] )
  end

  def update
    @target = Target.find( params[:id] )
    p1 = Net::Ping::TCP.new( @target.address, 80, 1 )
    if( p1.ping? )
      @target.reachable = true
      @target.last_up = Time.now
    else
      @target.reachable = false
    end
    unless @target.save
      render :nothing => true, :status => :internal_server_error
    end
  end

end
