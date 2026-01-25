class ApiToken < ApplicationRecord
  belongs_to :user

  attr_accessor :raw_token

  before_create :generate_token_digest

  scope :active, -> { where("expires_at IS NULL OR expires_at > ?", Time.current) }

  def self.authenticate(token)
    return nil if token.blank?
    token_digest = Digest::SHA256.hexdigest(token)
    active.find_by(token_digest: token_digest)
  end

  def touch_last_used
    update_column(:last_used_at, Time.current)
  end

  def expired?
    expires_at.present? && expires_at < Time.current
  end

  private

  def generate_token_digest
    self.raw_token = SecureRandom.urlsafe_base64(32)
    self.token_digest = Digest::SHA256.hexdigest(raw_token)
  end
end
