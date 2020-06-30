class GistsController < ApplicationController
  def create
    @gist = Gist.create(gist_params)
  end

  def destroy

  end

  private

  def gist_params
    params.require(:gist).permit()
  end
end
