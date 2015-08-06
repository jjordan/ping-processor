require 'spec_helper'

require 'ping_processor'

describe PingProcessor do
  let( :config ) do
    {
      port: 3000,
      timeout: 10,
      number_of_processes: 5
    }
  end

  subject { PingProcessor.new }

  it "can be instantiated with a config hash" do
    pp = nil
    expect { pp = PingProcessor.new( config ) }.not_to raise_error
    expect( pp ).to be_a( PingProcessor )
    expect( pp.port ).to eq( 3000 )
    expect( pp.timeout ).to eq( 10 )
    expect( pp.number_of_processes ).to eq( 5 )
  end

  it "has defaults for its options" do
    pp = nil
    expect { pp = PingProcessor.new }.not_to raise_error
    expect( pp ).to be_a( PingProcessor )
    expect( pp.port ).to eq( 80 )
    expect( pp.timeout ).to eq( 1 )
    expect( pp.number_of_processes ).to eq( 10 )
  end

  it "calcualtes a batch size" do
    expect( subject.batch_size( 1000 ) ).to eq( 100 )
  end

  it "calculates any remainder" do
    expect( subject.remainder( 1003 ) ).to eq( 3 )
  end

  it "calculates the record to start on" do
    expect( subject.start( 0, 100 ) ).to eq( 0 )
    expect( subject.start( 1, 100 ) ).to eq( 10 )
    expect( subject.start( 2, 100 ) ).to eq( 20 )
    expect( subject.start( 3, 100 ) ).to eq( 30 )
    expect( subject.start( 4, 100 ) ).to eq( 40 )
    expect( subject.start( 5, 100 ) ).to eq( 50 )
    expect( subject.start( 6, 100 ) ).to eq( 60 )
  end

  it "is run with a dataset" do
    subject.run( Target.where( ping_enabled: true ) )
  end
end
