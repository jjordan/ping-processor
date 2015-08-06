
class PingProcessor

  attr_reader :port, :timeout, :number_of_processes

  DEFAULTS = {
    port: 80,
    timeout: 1,
    number_of_processes: 10
  }

  def initialize( config={} )
    config = DEFAULTS.merge( config )
    @port = config[:port]
    @timeout = config[:timeout]
    @number_of_processes = config[:number_of_processes]
  end

  def batch_size( count )
    count / self.number_of_processes
  end

  def remainder( count )
    count % self.number_of_processes
  end

  def start( n, count )
    (self.batch_size( count ) * n) 
  end

  def run( dataset )
    0.upto( self.number_of_processes - 1 ).each do |n|
      fork do
        dataset.find_in_batches( 
                                batch_size: self.batch_size( dataset.count ),
                                start: self.start( n, dataset.count )
                                ) do |group|
          puts "\n\nGroup: #{n}\n\n"
          group.each do |target|
            threads = []
            threads << Thread.new do
              p1 = Net::Ping::TCP.new( target.address, self.port, self.timeout )
              
              check_ping( p1, target )
            end
            threads.each { |thr| thr.join }
          end
        end
      end
    end
  end

  private

  def check_ping( p1, target )
    puts "about to ping #{target.hostname}"
    if( p1.ping? )
      save_reachable_target( target )
    else
      save_unreachable_target( target )
    end
  end

  def save_reachable_target( target )
    puts "#{target.hostname} responded"
    target.transaction do
      target.reachable = true
      target.last_up = Time.now
      target.save
    end
  end

  def save_unreachable_target( target )
    puts "#{target.hostname} did not respond"
    target.transaction do
      target.reachable = false
      target.save
    end
  end

end

