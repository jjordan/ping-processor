require 'spec_helper'

require 'ping_processor'

describe PingProcessor do
  let( :config ) do
    {
      port: 3000,
      timeout: 10,
      batch_size: 50,
      debug: true
    }
  end

  subject { PingProcessor.new }

  it "can be instantiated with a config hash" do
    pp = nil
    expect { pp = PingProcessor.new( config ) }.not_to raise_error
    expect( pp ).to be_a( PingProcessor )
    expect( pp.port ).to eq( 3000 )
    expect( pp.timeout ).to eq( 10 )
    expect( pp.batch_size ).to eq( 50 )
    expect( pp.debug ).to eq( true )
  end

  it "has defaults for its options" do
    pp = nil
    expect { pp = PingProcessor.new }.not_to raise_error
    expect( pp ).to be_a( PingProcessor )
    expect( pp.port ).to eq( 80 )
    expect( pp.timeout ).to eq( 1 )
    expect( pp.batch_size ).to eq( 100 )
    expect( pp.debug ).to eq( false )
  end

  it "is run with a dataset" do
    subject.run( Target.where( ping_enabled: true ) )
  end
end
