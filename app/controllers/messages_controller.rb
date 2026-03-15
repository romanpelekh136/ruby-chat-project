class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.build(message_params)
    @message.user = current_user

    if @message.save
    else
      render :create, status: :unprocessable_content
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
