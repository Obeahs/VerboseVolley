class CreatePages < ActiveRecord::Migration[7.2]
  def change
    create_table :pages do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
