class GistFilesController < ApplicationController
  before_action :set_gist_file

  def show
  end

  def update
  end

  private

  def set_gist_file
    @gist_file = GistFile.find(params[:id])
    authorize @gist_file
  end
end
