class GistLabelsController < ApplicationController
  def new
    @gist_label = GistLabel.new
    authorize @gist_label
  end

  def create
    @gist_label = GistLabel.new(gist_label_params)
    authorize @gist_label
    @gist = UserGist.find(params[:gist_label][:gist])
    @gist_label.user_gist = @gist
    if @gist_label.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def gist_label_params
    params.require(:gist_label).permit(:label_id)
  end
end
