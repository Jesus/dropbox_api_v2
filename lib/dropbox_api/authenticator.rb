# frozen_string_literal: true
require 'oauth2'

module DropboxApi
  class Authenticator < OAuth2::Client
    extend Forwardable

    def initialize(client_id, client_secret)
      @auth_code = OAuth2::Client.new(client_id, client_secret, {
        authorize_url: 'https://www.dropbox.com/oauth2/authorize',
        token_url: 'https://api.dropboxapi.com/oauth2/token'
      }).auth_code
    end

    def_delegators :@auth_code, :authorize_url, :get_token
  end


  class Token
    extend Forwardable
    def_delegators :@token, :token, :refresh_token, :expired

    def initialize(authenticator, token_hash = nil)
      @authenticator = authenticator
      load_token(token_hash) if token_hash
    end
    
    def self.from_code(authenticator, code) 
      self.new(authenticator, authenticator.get_token(code))
    end
    
    def load_token(token_hash) 
      if token_hash.is_a?(OAuth2::AccessToken)
        @token = token_hash 
      else
        @token = OAuth2::AccessToken.from_hash(@authenticator, token_hash)
      end
    end
    
    def refresh_token()
      @token = @token.refresh! 
      save!
    end
    
    def save_token(token_hash); end
    
    def save! 
      save_token(@token.to_hash)
    end

    def short_lived_token()
      refresh_token if @token.expired?
      @token.token
    end
  end
end
