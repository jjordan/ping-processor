class AddPingEnabledToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :ping_enabled, :boolean, default: true
  end
end
