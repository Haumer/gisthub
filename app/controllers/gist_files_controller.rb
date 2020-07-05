class GistFilesController < ApplicationController
  def show
    @gist_file = GistFile.find(params[:id])
  end
end
