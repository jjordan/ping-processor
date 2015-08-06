
class PingProcessor

  attr_reader :port, :timeout, :batch_size, :debug

  DEFAULTS = {
    port: 80,
    timeout: 1,
    batch_size: 100,
    debug: false
  }

  def initialize( config={} )
    config = DEFAULTS.merge( config )
    @port = config[:port]
    @timeout = config[:timeout]
    @batch_size = config[:batch_size]
    @debug = config[:debug]
  end

  def run( dataset )
    puts "Total targets to check: #{dataset.count}"
    total = 0
    n = 1
    dataset.find_in_batches( 
                            batch_size: self.batch_size
                            ) do |group|
      puts "\n\nGroup: #{n}\n\n" if debug
      n += 1
      threads = []
      ping_results_by_id = {}
      group.each do |target|

        threads << Thread.new do
          p1 = Net::Ping::TCP.new( target.address, self.port, self.timeout )
              
          results = check_ping( p1 )
          ping_results_by_id[ target.id ] = results
        end

      end

      threads.each { |thr| thr.join }
      ping_results_by_id.each_pair do |id, results|
        total += 1
        t = group.find {|t| t.id == id}
        save_ping( results, t )
      end

    end
    puts "Total targets checked: #{total}"
  end

  private

  def check_ping( p1 )
    puts "about to ping #{p1.inspect}" if debug
    results = {}
    if( p1.ping? )
      puts "responded" if debug
      results[:reachable] = true
      results[:last_up] = Time.now
    else
      puts "did not respond" if debug
      results[:reachable] = false
    end
    return results
  end

  def save_ping( results, target )
    puts "updating target: #{target.id}" if debug
    target.update( results )
  end

end

