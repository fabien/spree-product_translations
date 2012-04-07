class AddProductPropertyTranslationTable < ActiveRecord::Migration
  def self.up
    Spree::ProductProperty.create_translation_table! :value => :string
  end

  def self.down
    Spree::ProductProperty.drop_translation_table!
  end
end
