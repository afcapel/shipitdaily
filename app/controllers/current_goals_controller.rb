class CurrentGoalsController < ApplicationController

  def show
    @goal  = current_user.goals.current

    if @goal.completed?
      render "shipped"
    elsif @goal.planned?
      render "track_goal"
    else
      render "show"
    end
  end

  def create
    current_user.goals.plan(params[:goal])
    redirect_to root_path
  end

  def update
    goal = current_user.goals.current

    if params[:commit][/shipped/]
      goal.complete
    else
      goal.abandon
    end

    redirect_to root_path
  end

  def reset
    current_user.goals.create(:state => "undefined")

    redirect_to root_path
  end
end