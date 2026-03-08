require "net/http"
require "json"

class DescriptionReaderClient
  def self.sync
    new.sync
  end

  def sync
    entries = fetch_channels
    return if entries.nil?

    entries.each do |entry|
      url = entry["url"]
      channels = entry["channels"] || []
      next if url.blank?

      item = upsert_item(url)
      next if item.nil?

      channels.each do |channel|
        influencer = find_or_create_influencer(channel)
        item.influencers << influencer if influencer && !item.influencers.include?(influencer)
      end
    end
  end

  private

  def fetch_channels
    uri = URI.join(base_url, "/channels")
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https", open_timeout: 5, read_timeout: 5) do |http|
      http.get(uri.path)
    end

    return nil unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body)
  rescue StandardError => e
    Rails.logger.warn("Description Reader fetch failed: #{e.message}")
    nil
  end

  def upsert_item(url)
    item = Item.where("data->>'amazon_url' = ?", url).first_or_initialize
    item.amazon_url ||= url
    item.title ||= title_from_url(url)
    item.item_maker ||= default_maker
    item.save!
    item
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.warn("Failed to upsert item for #{url}: #{e.message}")
    nil
  end

  def default_maker
    @default_maker ||= Maker.find_or_create_by!(title: "Unknown")
  end

  def find_or_create_influencer(channel)
    uuid = channel["uuid"]
    return nil if uuid.blank?

    influencer = Influencer.find_or_initialize_by(identifier: uuid)
    influencer.name ||= channel["title"]
    influencer.handle ||= channel["handle"]
    influencer.platform ||= "YouTube"
    influencer.save!
    influencer
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.warn("Failed to upsert influencer: #{e.message}")
    nil
  end

  def title_from_url(url)
    path = URI.parse(url).path
    slug = path.split("/").find { |seg| seg.match?(/[a-zA-Z].*-/) }
    slug&.tr("-", " ")&.strip || url
  rescue URI::InvalidURIError
    url
  end

  def base_url
    ENV.fetch("DESCRIPTION_READER_URL", "http://localhost:3000")
  end
end
