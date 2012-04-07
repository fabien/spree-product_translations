class AddTranslationTables < ActiveRecord::Migration
  def self.up
    Spree::Product.create_translation_table! :name => :string, :description => :text, :meta_description => :text, :meta_keywords => :text
    Spree::Property.create_translation_table! :presentation => :string
    Spree::Prototype.create_translation_table! :name => :string
    Spree::Taxonomy.create_translation_table! :name => :string
    Spree::Taxon.create_translation_table! :name => :string, :description => :text
    Spree::OptionType.create_translation_table! :presentation => :string
    Spree::OptionValue.create_translation_table! :presentation => :string
  end

  def self.down
    Spree::Product.drop_translation_table!
    Spree::Property.drop_translation_table!
    Spree::Prototype.drop_translation_table!
    Spree::Taxonomy.drop_translation_table!
    Spree::Taxon.drop_translation_table!
    Spree::OptionType.drop_translation_table!
    Spree::OptionValue.drop_translation_table!
  end
end
