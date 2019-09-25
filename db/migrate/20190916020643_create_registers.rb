class CreateRegisters < ActiveRecord::Migration[6.0]
  def change
    create_table :registers do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.datetime :occurred_at, null: false
      t.integer :type, null: false

      t.timestamps
    end

    add_index :registers, :occurred_at
    add_index :registers, :type
  end
end
