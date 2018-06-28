module Api
  class CalendarsController < ApplicationController

    def index
      @events = Calendar.order(created_at: :desc)
      render json: { status: 'Success', message: 'All Events', data: @events }, status: :ok
    end

    def create
      @event = Calendar.new(calendar_params)
      respond_to do |format|
        if @event.save
          format.html { redirect_to calendar_path, notice: 'Event Saved!'}
          format.json { render :show, status: :created, location: @event }
        else
          format.html {redirect_to calendar_path, notice: 'Event Not Saved!'}
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    def show
      @event = Calendar.find(params[:id])
      render json: { status: 'Success', message: "Loaded Event #{@event.id}", data: @event }, status: :ok
    end

    # Did not get to implement in UI/UX
    def update
      @event = Calendar.find(params[:id])
      if @event.update_attributes(calendar_params)
        render json: { status: 'Success', message: 'Event Updated!', data: @event }, status: :ok
      else
        render json: { status: 'Error', message: 'Event Not Updated!', data: @event.errors }, status: :unprocessable_entity
      end
    end

    # Did not get to implement in UI/UX
    def destroy
      @event = Calendar.find(params[:id])
      @event.destroy
      render json: { status: 'Success', message: 'Deleted Event', data: @event }, status: :ok
    end

    private
    def calendar_params
      params.require(:calendar).permit(:title, :body, :location, :start_time, :end_time)
    end

  end
end