class AddStatusAndLastUpToTarget < ActiveRecord::Migration
  def change
    add_column :targets, :reachable, :boolean, default: false
    add_column :targets, :last_up, :datetime
  end
end
