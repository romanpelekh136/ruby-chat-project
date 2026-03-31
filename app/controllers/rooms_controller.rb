class RoomsController < ApplicationController
  before_action :set_room, only: [ :show, :destroy, :update, :edit ]
  def index
    @rooms = Room.order(created_at: :desc)
    @room = Room.new
  end

  def show
    @messages = @room.messages.includes(:user).order(created_at: :asc)
    @message = Message.new
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      @room.broadcast_prepend_to "rooms"
    else
      render status: :unprocessable_entity
    end
  end

  def destroy
    authorize @room

    @room.destroy
  end

  def update
    authorize @room

    if @room.update(room_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @room }
      end
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @room }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    authorize @room
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
