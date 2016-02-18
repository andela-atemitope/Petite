class Todo < Petite::PetiteRecord
  to_table :todo
  property :id, type: :integer, primary_key: true, autoincrement: true
  property :title, type: :text, nullable: false
  property :body, type: :text, nullable: false
  property :created_at, type: :text, nullable: false
  create_table
end
