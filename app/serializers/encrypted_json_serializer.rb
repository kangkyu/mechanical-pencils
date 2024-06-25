class EncryptedJsonSerializer
  def self.dump(hash_data)
    return if hash_data.nil?

    hash_data.transform_values do |value|
      crypt.encrypt_and_sign(value)
    end
  end

  def self.load(encrypted)
    return if encrypted.nil?

    encrypted.transform_values do |value|
      crypt.decrypt_and_verify(value)
    end
  end

  def self.crypt
    secret_base = Rails.application.secret_key_base

    len = ActiveSupport::MessageEncryptor.key_len
    # salt = SecureRandom.random_bytes(len)
    salt = secret_base.first(len)
    ActiveSupport::MessageEncryptor.new(salt, secret_base)
  end
end
