class CreateUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.timestamps
    end
    add_index :users, :username, unique:true 
    
    create_table :polls do |t|
      t.integer :author_id, null:false
      t.string :title, null:false
      t.timestamps
    end
    

    create_table :questions do |t|
      t.integer :poll_id, null:false
      t.text :body, null: false
      t.timestamps
    end

    create_table :answer_choices do |t|
      t.integer :question_id, null:false
      t.text :option, null:false
      t.timestamps
    end
    
    create_table :responses do |t|
      t.integer :user_id, null:false
      t.integer :option_id, null:false
      t.timestamps
    end

  end
end
