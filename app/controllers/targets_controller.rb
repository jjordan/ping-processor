class TargetsController < ApplicationController
skip_before_filter  :verify_authenticity_token

  def index
    @targets = Target.all
    @total_reachable = @targets.reachable.count
    @total_unreachable = @targets.unreachable.count
    @percentage_reachable = "%.2f" % [(@total_reachable.to_f / (@total_reachable + @total_unreachable) ) * 100]
    @percentage_unreachable = "%.2f" % [(@total_unreachable.to_f / (@total_reachable + @total_unreachable) ) * 100]
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
