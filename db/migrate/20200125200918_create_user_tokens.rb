class CreateUserTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :user_tokens do |t|
      t.string :auth_token

      t.timestamps
    end
  end
end
