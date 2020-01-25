module JwtConcern
  extend ActiveSupport::Concern
  SESSION_TIME = 1.month.freeze
  attr_accessor :token_expiration_date

  def token
    JwtToken.encode(id: self.id, exp: SESSION_TIME.from_now.to_i)
  end

  def token_expired?
    self.token_expiration_date < DateTime.now.utc
  end

  module ClassMethods
    def retrieve_by_token(token)
      data = JwtToken.decode(token).first
      user = User.find(data['id'])
      user.token_expiration_date = Time.at(data['exp'])
      user
    end
  end

  class JwtToken
    class << self

      def encode(options = {})
        ::JWT.encode(options, Rails.application.secrets.secret_key_base)
      end

      def decode(token)
        ::JWT.decode(token, Rails.application.secrets.secret_key_base)
      end
    end
  end
end