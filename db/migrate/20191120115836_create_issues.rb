class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :title
      t.string :description
      t.string :type
      t.string :priority
      t.string :status
      t.string :asignee
      t.string :creator
      t.date :created
      t.date :updated
      t.integer :vote
      t.integer :watch

      t.timestamps
    end
  end
end
