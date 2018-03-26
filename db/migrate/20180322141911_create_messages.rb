class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :user, foreign_key: true
      t.references :partner, foreign_key: { to_table: :users }

      t.timestamps
      t.index [:user_id, :partner_id]
    end
  end
end
