class User < ApplicationRecord
  has_secure_password
  has_secure_token :confirmation_token

  # validates :username,
  #           format: { with: /[a-zA-Z0-9_]{2, 20}/,
  #                     message: 'ne doit contenir que des caractères alphanumériques ou des underscores.' },
  #           uniqueness: { case_sensitive: false }
  # validates :email,
  #           format: { with: /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/ },
  #           uniqueness: { case_sensitive: false }
end
