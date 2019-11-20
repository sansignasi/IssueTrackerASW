class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :Title
      t.string :Description
      t.string :Type
      t.string :Priority
      t.string :Status
      t.string :Asigned
      t.string :Creator
      t.datetime :Created
      t.datetime :Updated
      t.integer :Vote
      t.integer :Watch

      t.timestamps
    end
  end
end
