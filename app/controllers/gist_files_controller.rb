class GistFilesController < ApplicationController
  def show
    @gist_file = GistFile.find(params[:id])
    authorize @gist_file
  end
end
