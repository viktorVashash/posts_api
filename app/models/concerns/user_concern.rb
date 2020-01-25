module UserConcern
  extend ActiveSupport::Concern
  included do
    PASSWORD_CONSTRAINS = /((?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,})/
    EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}+\z/i
  end

end
