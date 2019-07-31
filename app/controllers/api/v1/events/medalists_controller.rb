class Api::V1::Events::MedalistsController < ApplicationController
  def show
    event = Event.find(params[:id])
    render json: {
      event: event.name,
      medalists: event.get_medalists
    }
  end
end
