class CreateHelpTopics < ActiveRecord::Migration
  def change
    create_table :help_topics do |t|
      t.string :name
      t.integer :topic_index
      t.text :summary
      t.text :body

      t.timestamps null: false
    end
  end
end
