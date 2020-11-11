class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:github]
  validates :githubname, presence: true, uniqueness: true
  before_validation :valid_githubname?
  after_create :import_gists
  has_many :user_gists, dependent: :destroy
  has_many :gist_files, through: :user_gists
  has_many :groups, dependent: :destroy
  has_many :usergroups, dependent: :destroy
  has_many :other_groups, through: :usergroups, source: :group
  has_many :labels, dependent: :destroy

  after_create :create_personal_group
  acts_as_voter

  def valid_githubname?
    github_user = Github::Api.new(self)

    errors.add(:githubname, "does not seem to be valid") if github_user.valid?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.githubname = auth.info.nickname.downcase
      user.github_token = auth.credentials.token
      user.avatar_url = auth.info.image
      user.save
    end
  end

  def already_personal_group_gist?(gist)
    personal_group_gists.where(user_gist: gist).present?
  end

  def personal_group_gists
    personal_group.group_gists
  end

  def personal_group
    self.groups.find_by_personal(true)
  end

  def create_personal_group
    Group.create(user: self, name: "Personal", personal: true)
  end

  def import_gists
    ImportForGroupJob.perform_later(self.id)
  end
end
