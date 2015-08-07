class AddReachableIndexToTargets < ActiveRecord::Migration
  def change
    add_index :targets, [:reachable], name: "index_targets_on_reachable"
  end
end
