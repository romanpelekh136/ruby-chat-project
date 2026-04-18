class MessageBlueprint < Blueprinter::Base
  identifier :id

  fields :body, :room_id, :user_id, :created_at
end
