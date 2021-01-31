class Home::InstallationComponent < ViewComponent::Base
  def initialize(title: true, long: true, defunkt: false, gh: false)
    @title = title
    @long = long
    @defunkt = defunkt
    @gh = gh
  end

  def render?
    @defunkt || @gh
  end

  private

  attr_reader :defunkt, :gh
end
