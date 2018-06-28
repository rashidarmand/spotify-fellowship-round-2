class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.string :title
      t.string :body
      t.string :location
      t.datetime :start_time
      t.datetime :end_time
      t.timestamps
    end
  end
end
