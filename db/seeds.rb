# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Brands (using Maker model)
feastables = Maker.find_or_create_by(title: "Feastables", origin: "USA", homepage: "https://feastables.com")
teddy_fresh = Maker.find_or_create_by(title: "Teddy Fresh", origin: "USA", homepage: "https://teddyfresh.com")
prime = Maker.find_or_create_by(title: "Prime Hydration", origin: "USA", homepage: "https://drinkprime.com")
chamberlain_coffee = Maker.find_or_create_by(title: "Chamberlain Coffee", origin: "USA", homepage: "https://chamberlaincoffee.com")
tsuki = Maker.find_or_create_by(title: "Tsuki", origin: "USA", homepage: "https://tsuki-co.com")
cloak = Maker.find_or_create_by(title: "Cloak", origin: "USA", homepage: "https://cloakbrand.com")
maverick = Maker.find_or_create_by(title: "Maverick", origin: "USA", homepage: "https://maverickclothing.com")
apres = Maker.find_or_create_by(title: "Apres Bev", origin: "USA", homepage: "https://apresbev.com")
og_merch = Maker.find_or_create_by(title: "Official Merch Co", origin: "USA")
youngla = Maker.find_or_create_by(title: "YoungLA", origin: "USA", homepage: "https://youngla.com")

# Influencers
mrbeast = Influencer.find_or_create_by(name: "MrBeast") do |i|
  i.platform = "YouTube"
  i.handle = "@MrBeast"
  i.profile_url = "https://youtube.com/@MrBeast"
  i.follower_count = 340_000_000
  i.bio = "Philanthropist and entrepreneur known for extreme challenge videos and Feastables."
end

logan_paul = Influencer.find_or_create_by(name: "Logan Paul") do |i|
  i.platform = "YouTube"
  i.handle = "@LoganPaul"
  i.profile_url = "https://youtube.com/@LoganPaul"
  i.follower_count = 23_000_000
  i.bio = "Entertainer, WWE wrestler, and co-founder of Prime Hydration."
end

emma_chamberlain = Influencer.find_or_create_by(name: "Emma Chamberlain") do |i|
  i.platform = "YouTube"
  i.handle = "@emmachamberlain"
  i.profile_url = "https://youtube.com/@emmachamberlain"
  i.follower_count = 12_000_000
  i.bio = "Content creator and founder of Chamberlain Coffee."
end

ethan_klein = Influencer.find_or_create_by(name: "Ethan Klein") do |i|
  i.platform = "YouTube"
  i.handle = "@h3h3productions"
  i.profile_url = "https://youtube.com/@h3h3productions"
  i.follower_count = 6_000_000
  i.bio = "Podcaster and co-founder of Teddy Fresh."
end

markiplier = Influencer.find_or_create_by(name: "Markiplier") do |i|
  i.platform = "YouTube"
  i.handle = "@markiplier"
  i.profile_url = "https://youtube.com/@markiplier"
  i.follower_count = 37_000_000
  i.bio = "Gaming creator and co-founder of Cloak brand."
end

valkyrae = Influencer.find_or_create_by(name: "Valkyrae") do |i|
  i.platform = "YouTube"
  i.handle = "@Valkyrae"
  i.profile_url = "https://youtube.com/@Valkyrae"
  i.follower_count = 4_000_000
  i.bio = "Gaming streamer and content creator."
end

items = Item.create!([
  { title: "Feastables Chocolate Bar", maker_id: feastables.id, influencer: mrbeast,
    data: { category: "Food & Drink", size: "One Size", limited_edition: "No", amazon_url: "https://feastables.com/products/chocolate-bar" } },
  { title: "Feastables Gummy Bears", maker_id: feastables.id, influencer: mrbeast,
    data: { category: "Food & Drink", limited_edition: "No", amazon_url: "https://feastables.com/products/gummy-bears" } },
  { title: "MrBeast Logo Hoodie", maker_id: og_merch.id, influencer: mrbeast,
    data: { category: "Apparel", size: "M", color: "Black", limited_edition: "No", amazon_url: "https://shopmrbeast.com" } },
  { title: "MrBeast Logo Tee", maker_id: og_merch.id, influencer: mrbeast,
    data: { category: "Apparel", size: "L", color: "White", limited_edition: "No" } },
  { title: "MrBeast 100M Sub Jacket", maker_id: og_merch.id, influencer: mrbeast,
    data: { category: "Apparel", size: "L", color: "Purple", limited_edition: "Yes" } },
  { title: "Prime Hydration Bottle - Ice Pop", maker_id: prime.id, influencer: logan_paul,
    data: { category: "Food & Drink", limited_edition: "No", amazon_url: "https://drinkprime.com" } },
  { title: "Prime Hydration Bottle - Meta Moon", maker_id: prime.id, influencer: logan_paul,
    data: { category: "Food & Drink", limited_edition: "No" } },
  { title: "Prime Energy Can", maker_id: prime.id, influencer: logan_paul,
    data: { category: "Food & Drink", limited_edition: "No" } },
  { title: "Maverick Logo Hoodie", maker_id: maverick.id, influencer: logan_paul,
    data: { category: "Apparel", size: "XL", color: "Red", limited_edition: "No" } },
  { title: "Chamberlain Coffee Early Bird Blend", maker_id: chamberlain_coffee.id, influencer: emma_chamberlain,
    data: { category: "Food & Drink", limited_edition: "No", amazon_url: "https://chamberlaincoffee.com" } },
  { title: "Chamberlain Coffee Matcha Kit", maker_id: chamberlain_coffee.id, influencer: emma_chamberlain,
    data: { category: "Food & Drink", limited_edition: "Yes" } },
  { title: "Chamberlain Coffee Mug", maker_id: chamberlain_coffee.id, influencer: emma_chamberlain,
    data: { category: "Home & Living", color: "Cream", limited_edition: "No" } },
  { title: "Teddy Fresh Color Block Hoodie", maker_id: teddy_fresh.id, influencer: ethan_klein,
    data: { category: "Apparel", size: "L", color: "Multi", limited_edition: "No", amazon_url: "https://teddyfresh.com" } },
  { title: "Teddy Fresh Patchwork Pants", maker_id: teddy_fresh.id, influencer: ethan_klein,
    data: { category: "Apparel", size: "M", limited_edition: "No" } },
  { title: "Teddy Fresh Care Bear Collab Tee", maker_id: teddy_fresh.id, influencer: ethan_klein,
    data: { category: "Apparel", size: "S", limited_edition: "Yes" } },
  { title: "Cloak Midnight Hoodie", maker_id: cloak.id, influencer: markiplier,
    data: { category: "Apparel", size: "L", color: "Black", limited_edition: "No", amazon_url: "https://cloakbrand.com" } },
  { title: "Cloak Stealth Joggers", maker_id: cloak.id, influencer: markiplier,
    data: { category: "Apparel", size: "M", color: "Gray", limited_edition: "No" } },
  { title: "Tsuki Dreamy Planner", maker_id: tsuki.id, influencer: valkyrae,
    data: { category: "Accessories", limited_edition: "Yes" } },
  { title: "YoungLA Raw Gear Tee", maker_id: youngla.id,
    data: { category: "Apparel", size: "M", color: "White", limited_edition: "No", amazon_url: "https://youngla.com" } },
  { title: "Apres Bev Sparkling Water Pack", maker_id: apres.id,
    data: { category: "Food & Drink", limited_edition: "No" } }
])

user = User.create!(email: "kangkyu@example.com", password: "1234")
o = Ownership.find_or_create_by(user: user, item: Item.first)

User.create!(email: "admin@lininglink.com", password: "1234abcd")

u = User.create!(email: "jimmy@example.com", password: "1234abcd")
u.items.push items.first(10)

ig = ItemGroup.create(title: "MrBeast Empire")
ig.items.push Item.where(influencer: mrbeast)

ItemGroup.create(title: "Best Food & Drink Merch")
