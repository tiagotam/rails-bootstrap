class CreateCompany < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.column :name, :string, :null => false
      t.column :uuid, :string, :null => false
      t.timestamps
    end
  end
end
