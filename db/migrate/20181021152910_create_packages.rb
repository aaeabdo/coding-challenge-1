class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages, id: :uuid do |t|
      t.string     :name,             null: false
      t.string     :version,          null: false
      t.datetime   :publication_date, null: false
      t.string     :title,            null: false
      t.text       :description,      null: false
      t.json       :authors,          null: false
      t.json       :maintainers,      null: false
      t.timestamps null: false
    end
  end
end
