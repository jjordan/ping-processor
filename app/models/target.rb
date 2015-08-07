class Target < ActiveRecord::Base
  belongs_to :appliance

  validates :appliance_id, presence:   true

  validates :hostname,     presence:   true,
                           uniqueness: true

  validates :address,      presence:   true,
                           format:     {with: Resolv::IPv4::Regex}

  scope :reachable, -> { where(reachable: true) }
  scope :unreachable, -> { where(reachable: false) }
end
