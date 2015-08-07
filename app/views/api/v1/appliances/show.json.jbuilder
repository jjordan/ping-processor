json.appliance do
  json.name @appliance.name
  json.customer @appliance.customer
  json.total_hosts @appliance.targets.count
  json.number_up @appliance.targets.reachable.count
  json.number_down @appliance.targets.unreachable.count
end
