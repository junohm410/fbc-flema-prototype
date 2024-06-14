class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :avatar

      t.timestamps
    end

    add_index :users, [:uid, :provider], unique: true
  end
end
