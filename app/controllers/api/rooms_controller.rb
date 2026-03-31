class Api::RoomsController < Api::BaseController
   before_action :set_room, only: [ :show ]

  def index
    @rooms = Room.order(created_at: :desc)
    render json: @rooms
  end

  def show
    @messages = @room.messages.includes(:user).order(created_at: :asc)
    render json: @messages
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
