class CreateSjabloonAnnouncements < ActiveRecord::Migration[6.0]
  def change
    create_table :sjabloon_announcements do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :show_site_wide
      t.string :announcement_type
      t.string :target
      t.datetime :published_at

      t.timestamps
    end
  end
end
