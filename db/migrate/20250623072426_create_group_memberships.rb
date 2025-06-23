class CreateGroupMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :group_memberships do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :group, null: false, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
