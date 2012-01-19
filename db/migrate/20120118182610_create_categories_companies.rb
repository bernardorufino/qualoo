class CreateCategoriesCompanies < ActiveRecord::Migration
  def up
    create_table :categories_companies do |t|
      t.references :company, :category
    end
  end

  def down
    drop_table :categories_companies;
  end
end
