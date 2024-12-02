# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :citext
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :favorites, class_name: "Favorite", foreign_key: "user_id", dependent: :destroy
  has_many :favorite_locations, through: :favorites, source: :location

  # Ensure email is present, unique, and correctly formatted
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Ensure username is present and unique
  validates :username, presence: true, uniqueness: true

  # Password validation logic
  validates :password, length: { minimum: 8, allow_blank: true }, format: { with: /(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])/,
    message: "must include at least one uppercase letter, one digit, and one special character" }, if: :password_required?

  # Ensure admin is set to false by default
  attribute :admin, :boolean, default: false

  # Allow updates without requiring password if not provided
  def update(params)
    super
  rescue => e
    Rails.logger.debug "Validation errors: #{errors.full_messages}"
    raise e
  end

  private

  # Determine if password is required for validation
  def password_required?
    new_record? || password.present?
  end
end
