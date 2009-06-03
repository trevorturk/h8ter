class RemoveNameAndActivationStuffFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :name
    remove_column :users, :activation_code
    remove_column :users, :activated_at
    remove_column :users, :state
    remove_column :users, :deleted_at
  end

  def self.down
    add_column :users, :name, :string, :limit => 100, :default => '', :null => true
    add_column :users, :activation_code, :string, :limit => 40
    add_column :users, :activated_at, :datetime
    add_column :users, :state, :string, :null => :no, :default => 'passive'
    add_column :users, :deleted_at, :datetime
  end
end
