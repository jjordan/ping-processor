json.total_targets @targets.count
json.total_reachable @targets.reachable.count
json.total_unreachable @targets.unreachable.count

json.targets @targets do |target|
  json.hostname target.hostname
  json.address target.address
  json.reachable target.reachable
  json.last_up target.last_up
  json.appliance_name target.appliance.name
  json.customer target.appliance.customer
end
