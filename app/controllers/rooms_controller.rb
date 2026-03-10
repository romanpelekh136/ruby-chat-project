class RoomsController < ApplicationController
  def index
    @rooms = Room.order(created_at: :desc)
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.includes(:user).order(created_at: :asc)
    @message = Message.new
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      @room.broadcast_prepend_to "rooms", partial: "rooms/room", locals: { room: @room, current_user: nil }
    end
  end

  def destroy
    @room = Room.find(params[:id])
    authorize @room

    @room.destroy
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
