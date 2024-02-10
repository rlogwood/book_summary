class CreateChatGptModels < ActiveRecord::Migration[7.1]
  def change
    create_table :chat_gpt_models do |t|
      t.string :name
      t.string :tier

      t.timestamps
    end
  end
end
