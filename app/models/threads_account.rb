class ThreadsAccount < ApplicationRecord
  belongs_to :user

  store_accessor :tokens, :short_access_token, :long_access_token
  serialize :tokens, coder: EncryptedJsonSerializer
end
