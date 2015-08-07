require 'spec_helper'

describe AppliancesController, :type => :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    let!(:appliance) { Appliance.create( name: 'DB Server', customer: 'ABC Dogfood' ) }
    it "returns http success" do
      get('show', { id: appliance.id} )
      expect(response).to be_success
    end
  end

end
