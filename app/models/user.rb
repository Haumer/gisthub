class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:github]
  validates :githubname, presence: true, uniqueness: true
  before_validation :valid_githubname?
  has_many :user_gists, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :usergroups, through: :groups

  after_create :create_personal_group

  def valid_githubname?
    data = Github::Api.new.check_for_valid_githubname(self.githubname)

    unless data["message"].nil?
      errors.add(:githubname, "does not seem to be valid!")
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.githubname = auth.info.nickname.downcase
      # user.name = auth.info.name   # assuming the user model has a name
      user.avatar_url = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
      user.save
    end
  end

  def create_personal_group
    Group.create(user: self, name: "Personal", personal: true)
  end
end
