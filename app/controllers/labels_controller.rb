class LabelsController < ApplicationController
  def new
    @label = Label.new
    authorize @label
  end

  def create
    @label = Label.new(label_params)
    authorize @label
    @label.user = current_user
    if @label.save!
      redirect_to user_path(slug: @label.user.githubname)
    else
      render :new
    end
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
