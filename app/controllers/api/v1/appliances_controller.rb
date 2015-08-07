module Api
  module V1
    class AppliancesController < ApiController

      def index
        @appliances = Appliance.all
        render :index
      end

      def show
        @appliance = Appliance.find( params[:id] )
        render :show
      end

    end
  end
end
