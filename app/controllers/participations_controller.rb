# frozen_string_literal: true

# controller for participation controller
class ParticipationsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :delete, :destroy, :edit, :update]
  def index
    @participation = Participation.all
  end

  def show
    @participation = Participation.find(params[:id])
  end

  def new
    @participation = Participation.new
    #if params.arity == 2
      @participation.game_id = params[:id]
      @participation.player_id = params[:player_id]
      if params[:player_id].present?
        @player = Player.find(params[:player_id])
      else
        @player = nil
      end
    #end
  end

  def games
    params.require(:id)
    @game = Game.all
  end

  def create
    @participation = Participation.new(participations_params)
    if @participation.save
      redirect_to root_path, notice: 'Participation saved'
    else
      render :new
    end
  end

  def delete
    @participation = Participation.find(params[:id])
    destroy
  end

  def destroy
    @participation = Participation.find(params[:id])
    @participation.destroy
    flash.notice = 'Delete Participation Successfully'
    redirect_to participations_path
  end

  def edit
    @participation = Participation.find(params[:id])
  end

  def update
    @participation = Participation.find(params[:id])
    if @participation.update(participations_params)
      flash[:update] = 'Participation has been successfully updated!'
      redirect_to(participation_path)
    else
      render 'edit'
    end
  end

  def participations_params
    params.require(:participation).permit(:player_id, :game_id, :time_on_ice_goalie, :shots_against_goalie, :saves_goalie, :goals_against_goalie, 
                                          :goals_skater, :assists_skater, :penalty_minutes_skater, :powerplay_minutes_skater, :powerplay_goals_skater)
  end

end
