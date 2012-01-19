class CreateCompanySalespersonContracts < ActiveRecord::Migration
  def change
    create_table :company_salesperson_contracts do |t|
      t.integer :salesperson_id
      t.integer :company_id

      t.timestamps
    end
  end
end
