class CreateExceptionLogs < ActiveRecord::Migration
  def change
    create_table :exception_logs do |t|
      t.references :user, :foreign_key => true
      t.column :ip, :string
      t.column :exception, :string
      t.column :controller, :string
      t.column :action, :string
      t.column :params, :text
      t.column :session, :text
      t.timestamps
    end
  end
end
