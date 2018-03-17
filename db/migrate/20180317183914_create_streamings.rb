class CreateStreamings < ActiveRecord::Migration[5.0]
  def change
    create_table :streamings do |t|
      t.string   :title
      t.string   :slug
      t.text     :description
      t.datetime  :date
      t.string   :image
      t.string   :url
      t.references :user, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
