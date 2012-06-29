namespace :spree do
  namespace :extensions do
    namespace :product_translations do
      desc "Copies pre-existing data to globalize's translation tables"
      task :globalize_legacy_data => :environment do
        I18n.locale = I18n.default_locale

        @sql = ActiveRecord::Base.connection

        # wrapper to deal with differences in result sets from mysql, sqlite and postgres
        def fetch_first_row(query)
          result = @sql.execute(query)
          row = if defined?(PGresult) && result.is_a?(PGresult) #postgres
                  result.getvalue(0,0)
                elsif result.is_a?(Array) #sqlite
                  result[0][0]
                elsif defined?(Mysql2::Result) && result.is_a?(Mysql2::Result) #mysql2
                  result.first.first
                else #mysql
                  result.fetch_row.first
                end
        end

        puts "updating product names, description, meta_keywords and meta_description..."
        Spree::Product.all.each do |p|
          p.name = fetch_first_row("select spree_products.name from spree_products where spree_products.id=#{p.id}")
          p.description = fetch_first_row("select spree_products.description from spree_products where spree_products.id=#{p.id}")
          p.meta_keywords = fetch_first_row("select spree_products.meta_keywords from spree_products where spree_products.id=#{p.id}")
          p.meta_description = fetch_first_row("select spree_products.meta_description from spree_products where spree_products.id=#{p.id}")
          p.save!
        end
        puts "done."

        puts "updating taxonomy names..."
        Spree::Taxonomy.all.each do |t|
          t.name = fetch_first_row("select spree_taxonomies.name from spree_taxonomies where spree_taxonomies.id=#{t.id}")
          t.save!
        end
        puts "done."

        puts "updating taxon names and permalinks..."
        Spree::Taxon.all.each do |t|
          t.name = fetch_first_row("select spree_taxons.name from spree_taxons where spree_taxons.id=#{t.id}")
          t.save!
        end
        puts "done."

        puts "updating property presentations..."
        Spree::Property.all.each do |p|
          p.presentation = fetch_first_row("select spree_properties.presentation from spree_properties where spree_properties.id=#{p.id}")
          p.save!
        end
        puts "done."

        puts "updating product property values..."
        Spree::ProductProperty.all.each do |p|
          p.value = fetch_first_row("select spree_product_properties.value from spree_product_properties where spree_product_properties.id=#{p.id}")
          p.save!
        end
        puts "done."

        puts "updating prototype names..."
        Spree::Prototype.all.each do |p|
          p.name = fetch_first_row("select spree_prototypes.name from spree_prototypes where spree_prototypes.id=#{p.id}")
          p.save!
        end
        puts "done."

        puts "updating option type presentations..."

        Spree::OptionType.all.each do |p|
          p.presentation = fetch_first_row("select spree_option_types.presentation from spree_option_types where spree_option_types.id=#{p.id}")
          p.save!
        end
        puts "done."

        Spree::OptionValue.all.each do |p|
          p.presentation = fetch_first_row("select spree_option_values.presentation from spree_option_values where spree_option_values.id=#{p.id}")
          p.save!
        end
        puts "done."
      end
    end
  end
end
