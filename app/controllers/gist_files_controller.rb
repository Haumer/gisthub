class GistFilesController < ApplicationController
  before_action :set_gist_file

  def show
  end

  def update
    @gist_file.update(gist_file_params)
    redirect_back(fallback_location: root_path)
  end

  private

  def gist_file_params
    params.require(:gist_file).permit(:markdown_display)
  end

  def set_gist_file
    @gist_file = GistFile.find(params[:id])
    authorize @gist_file
  end
end
