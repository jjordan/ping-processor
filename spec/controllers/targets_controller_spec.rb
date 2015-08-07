require 'spec_helper'

describe TargetsController, :type => :controller do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    let!(:appliance) { Appliance.create( name: 'DB Server', customer: 'ABC Dogfood' ) }
    let!(:target) do
      Target.create(
                    appliance_id: appliance.id,
                    hostname: 'abc.dogfood.com',
                    address: '127.0.0.1'
                    )
    end

    it "returns http success" do
      get('show', { id: target.id } )
      expect(response).to be_success
    end
  end

end
