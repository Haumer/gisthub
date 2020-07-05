class Groups::LabelComponent < ViewComponent::Base
  def initialize(group)
    @group = group
  end

  def render?
    @group
  end
end
