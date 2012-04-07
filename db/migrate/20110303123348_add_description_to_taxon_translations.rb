class AddDescriptionToTaxonTranslations < ActiveRecord::Migration
  def self.up
    add_column :spree_taxon_translations, :description, :text unless column_exists?(:spree_taxon_translations, :description)
  end

  def self.down
    remove_column :spree_taxon_translations, :description
  end
end
