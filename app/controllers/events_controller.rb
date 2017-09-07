class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to 'event', notice: 'Вы создали новое событие'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'Событие обновлено'
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'Событие успешно удалено'
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :adress, :datetime, :description)
  end
end
