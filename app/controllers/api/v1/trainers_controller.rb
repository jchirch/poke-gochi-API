class Api::V1::TrainersController < ApplicationController
  def show
    trainer = Trainer.find(params[:id])
    render json: TrainerSerializer.new(trainer)
  end
end