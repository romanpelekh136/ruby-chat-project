class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to @room
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
