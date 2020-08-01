class Home::InstallationComponent < ViewComponent::Base
  def initialize(title:, long:)
    @title = title
    @long = long
  end
end
