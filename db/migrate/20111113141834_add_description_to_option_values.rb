class AddDescriptionToOptionValues < ActiveRecord::Migration
  def self.up
    add_column :spree_option_values, :description, :text unless column_exists?(:spree_option_values, :description)
    add_column :spree_option_value_translations, :description, :text unless column_exists?(:spree_option_value_translations, :description)
  end

  def self.down
    remove_column :spree_option_values, :description
    remove_column :spree_option_value_translations, :description
  end
end
