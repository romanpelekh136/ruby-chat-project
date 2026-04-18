module Api
  class RoomsController < Api::BaseController
    before_action :set_room, only: [ :show, :destroy ]

    def index
      @rooms = Room.order(created_at: :desc)
      render json: RoomBlueprint.render_as_hash(@rooms)
    end

    def show
      @messages = @room.messages.includes(:user).order(created_at: :asc)
      render json: MessageBlueprint.render_as_hash(@messages)
    end

    def create
      @room = Room.create!(room_params.merge(user: current_user))
      render json: RoomBlueprint.render_as_hash(@room), status: :created
    end

    def destroy
      authorize @room

      @room.destroy
      head :no_content
    end

    private

    def set_room
      @room = Room.find(params[:id])
    end

    def room_params
      params.require(:room).permit(:name)
    end
  end
end
