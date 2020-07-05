class GistFiles::FileComponent < ViewComponent::Base
  def initialize(file)
    @file = file
    @user = file.user_gist.user
  end

  def render?
    @file.present?
  end
end
