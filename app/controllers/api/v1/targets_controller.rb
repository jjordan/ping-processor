module Api
  module V1
    class TargetsController < ApiController

      def index
        @targets = Target.all
        render :index
      end

      def show
        @target = Target.find( params[:id] )
        render :show
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
        results = { reachable: @target.reachable, last_up: @target.last_up }
        if @target.save
          results[:saved] = true
          results[:status] = :ok
        else
          results[:saved] = false
          results[:status] = :internal_server_error
        end
        render json: results, status: results[:status]
      end

    end
  end
end
