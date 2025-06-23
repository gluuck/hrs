class CreateReportingRelationships < ActiveRecord::Migration[8.0]
  def change
    create_table :reporting_relationships do |t|
      t.references :subordinate, null: false, foreign_key: { to_table: :employees }
      t.references :supervisor, polymorphic: true, null: false
      t.string :connection_type

      t.timestamps
    end
  end
end
