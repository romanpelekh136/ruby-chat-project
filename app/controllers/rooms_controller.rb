class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def create
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
