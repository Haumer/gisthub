class GistsController < ApplicationController
  def create
    @gist = Gist.create(gist_params)
  end

  def destroy

  end

  def hide
    @gist = Gist.find(params[:id])
    @gist.update(hide: !@gist.hide)
    redirect_to user_path(slug: @gist.user.githubname)
  end

  def star
    @gist = Gist.find(params[:id])
    @gist.update(star: !@gist.star)
    redirect_to user_path(slug: @gist.user.githubname)
  end

  private

  def gist_params
    params.require(:gist).permit()
  end
end
