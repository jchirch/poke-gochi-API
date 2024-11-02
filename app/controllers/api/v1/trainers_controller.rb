class Api::V1::TrainersController < ApplicationController

  def show
    begin
      trainer = Trainer.find(params[:id])
      render json: TrainerSerializer.new(trainer)
    rescue StandardError => exception
      render json: ErrorSerializer.format_error(exception, "404"), status: :not_found
    end
  end
end

