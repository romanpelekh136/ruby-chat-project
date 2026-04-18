class RoomBlueprint < Blueprinter::Base
  identifier :id

  field :name

  view :extended do
    field :user_id, name: :creator_id
  end

  view :with_messages do
    association :messages, blueprint: MessageBlueprint
  end
end
