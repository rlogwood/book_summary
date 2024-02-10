# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
chat_gpt_models = [
  { name: 'gpt-3.5-turbo', tier: 'Free' },
  { name: 'gpt-4', tier: 'Tier-1' },
  { name: 'gpt-4-turbo-preview', tier: 'Tier-1' }
]

ChatGptModel.create(chat_gpt_models)