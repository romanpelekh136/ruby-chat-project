class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    @room = Room.new
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.includes(:user).order(created_at: :asc)
    @message = Message.new
  end

  def create
    @room = Room.new(name: room_params[:name], user_id: current_user.id)
    if @room.save
      render turbo_stream: turbo_stream.replace(
        "new_room_form",
        partial: "form",
        locals: { room: Room.new })
    else
      render turbo_stream: turbo_stream.replace(
        "new_room_form",
        partial: "form",
        locals: { room: @room })
    end
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end
end
