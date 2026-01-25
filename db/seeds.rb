# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

alvin = Maker.find_or_create_by(title: "Alvin")
caran = Maker.find_or_create_by(title: "Caran d'Ache")
faber = Maker.find_or_create_by(title: "Faber-Castell")
kaweco = Maker.find_or_create_by(title: "Kaweco")
rotring = Maker.find_or_create_by(title: "Rotring")
pentel = Maker.find_or_create_by(title: "Pentel")
pilot = Maker.find_or_create_by(title: "Pilot")
zebra = Maker.find_or_create_by(title: "Zebra")
platinum = Maker.find_or_create_by(title: "Platinum")
lamy = Maker.find_or_create_by(title: "Lamy")
uni = Maker.find_or_create_by(title: "Uni")
staedtler = Maker.find_or_create_by(title: "Staedtler")

items = Item.create!([
                       { title: "Alvin Draft-Matic", maker_id: alvin.id },
                       { title: "Alvin Pro-Matic MC5", maker_id: alvin.id },
                       { title: "Alvin \"Scott\" B/2", maker_id: alvin.id },
                       { title: "Alvin \"TECH\" D/A", maker_id: alvin.id },
                       # { title: "Bic Criterium", maker: "Bic" },
                       { title: "Caran d'Ache 22", maker_id: caran.id },
                       { title: "Caran d'Ache 849", maker_id: caran.id },
                       { title: "Caran d'Ache 884", maker_id: caran.id },
                       { title: "Caran d'Ache Ecridor", maker_id: caran.id },
                       { title: "Faber-Castell TK 4600", maker_id: faber.id },
                       { title: "Faber-Castell TK 9400", maker_id: faber.id },
                       { title: "Faber-Castell TK 9500", maker_id: faber.id },
                       { title: "Faber-Castell Poly Matic", maker_id: faber.id },
                       { title: "Faber-Castell TK-Fine Vario L", maker_id: faber.id },
                       # { title: "Hightide Penco Prime", maker: "Hightide Penco" },
                       # { title: "Hribarcain Magno Ti", maker: "Hribarcain" },
                       # { title: "HMM Pencil", maker: "HMM" },
                       # { title: "IJ Instruments", maker: "IJ Instruments" },
                       # { title: "Ito-Ya Helvetica", maker: "Ito-Ya" },
                       { title: "Kaweco Special AL", maker_id: kaweco.id },
                       { title: "Kaweco Special Brass", maker_id: kaweco.id },
                       { title: "Kaweco Special Brass S", maker_id: kaweco.id },
                       # { title: "Kita Boshi 680", maker: "Kita Boshi" },
                       # { title: "Koh-i-noor", maker: "Koh-i-noor" },
                       # { title: "Kokuyo Enpitsu Sharp MX", maker: "Kokuyo" },
                       { title: "Lamy 2000", maker_id: lamy.id },
                       { title: "Lamy Safari", maker_id: lamy.id },
                       # { title: "Manufactum Druckbleistift", maker: "Manufactum" },
                       # { title: "Mitsubishi Field Pencil", maker: "Mitsubishi" },
                       # { title: "Mitsubishi Uni", maker: "Mitsubishi" },
                       # { title: "Modern Fuel", maker: "Modern Fuel" },
                       # { title: "Ohto Conception", maker: "Ohto" },
                       # { title: "Ohto no-noc", maker: "Ohto" },
                       # { title: "Ohto Promecha 500P", maker: "Ohto" },
                       # { title: "Ohto Promecha PM-1000S", maker: "Ohto" },
                       # { title: "Ohto Super Promecha PM-1500P", maker: "Ohto" },
                       # { title: "OHTO Maruta", maker: "Ohto" },
                       # { title: "OHTO Sharp Pencil", maker: "Ohto" },
                       # { title: "Pacific Arc Collegiate", maker: "Pacific Arc" },
                       # { title: "Pacific Arc Chromagraph", maker: "Pacific Arc" },
                       # { title: "Pacific Arc Professional", maker: "Pacific Arc" },
                       # { title: "Pacific Arc Tech Pro", maker: "Pacific Arc" },
                       # { title: "Pacific Arc Premium", maker: "Pacific Arc" },
                       # { title: "Parker Jotter", maker: "Parker" },
                       { title: "Pentel Graph 1000 For Pro", maker_id: pentel.id },
                       { title: "Pentel GraphGear 500", maker_id: pentel.id },
                       { title: "Pentel GraphGear 1000", maker_id: pentel.id },
                       { title: "Pentel orenz", maker_id: pentel.id },
                       { title: "Pentel orenznero", maker_id: pentel.id },
                       { title: "Pentel Orenz AT", maker_id: pentel.id },
                       { title: "Pentel P20X", maker_id: pentel.id },
                       { title: "Pentel Smash", maker_id: pentel.id },
                       { title: "Pentel Sharp Kerry", maker_id: pentel.id },
                       { title: "Pilot Automac", maker_id: pilot.id },
                       { title: "Pilot Dr. Grip", maker_id: pilot.id },
                       { title: "Pilot S3", maker_id: pilot.id },
                       { title: "Pilot S10", maker_id: pilot.id },
                       { title: "Pilot S20", maker_id: pilot.id },
                       { title: "Pilot S30", maker_id: pilot.id },
                       { title: "Platinum Pro-Use I (MSD-1000)", maker_id: platinum.id },
                       { title: "Platinum Pro-Use II (MSD-1500)", maker_id: platinum.id },
                       { title: "Platinum Pro-Use 171", maker_id: platinum.id },
                       { title: "Rotring Tikky", maker_id: rotring.id },
                       { title: "Rotring 300", maker_id: rotring.id },
                       { title: "Rotring 500", maker_id: rotring.id },
                       { title: "Rotring 600", maker_id: rotring.id },
                       { title: "Rotring 800", maker_id: rotring.id },
                       { title: "Rotring 800+", maker_id: rotring.id },
                       { title: "Rotring Rapid Pro", maker_id: rotring.id },
                       # { title: "Scrikks PRO-S", maker: "Scrikks" },
                       # { title: "Scrikks Graph-X", maker: "Scrikks" },
                       # { title: "Scrikks Twist", maker: "Scrikks" },
                       # { title: "Spoke 4", maker: "Spoke" },
                       # { title: "Spoke 5-1", maker: "Spoke" },
                       # { title: "Spoke 6", maker: "Spoke" },
                       { title: "Staedtler graphite 925", maker_id: staedtler.id },
                       { title: "Staedtler Mars Technico", maker_id: staedtler.id },
                       { title: "Staedtler 925", maker_id: staedtler.id },
                       # { title: "Tombow Mono Graph Zero", maker: "Tombow" },
                       # { title: "Tombow Zoom 505sh", maker: "Tombow" },
                       { title: "Uni 552", maker_id: uni.id },
                       { title: "Uni Alpha-gel", maker_id: uni.id },
                       { title: "Uni Alpha-gel Switch", maker_id: uni.id },
                       { title: "Uni Kuru Toga", maker_id: uni.id },
                       { title: "Uni Kuru Toga Dive", maker_id: uni.id },
                       # { title: "Ystudio Classic", maker: "YStudio" },
                       # { title: "YStudio Classic Revolve Sketching", maker: "YStudio" },
                       { title: "Zebra DelGuard", maker_id: zebra.id },
                       { title: "Zebra Drafix", maker_id: zebra.id },
                       { title: "Zebra M301", maker_id: zebra.id },
                       { title: "Zebra M701", maker_id: zebra.id }
                       # { title: "Tombow Zoom", maker: "Tombow" },
                       # { title: "Blick Premier", maker: "Blick" }
                     ])

def attach_item_image(title, image_file)
  return unless Item.exists?(title: title)

  Item.find_by(title: title).image.attach(filename: image_file,
                                          io: File.open(Rails.root.join("app/assets/images/#{image_file}").to_s))
end

attach_item_image "Alvin Draft-Matic", "alvin-draft-matic.png"
attach_item_image "Pentel Sharp Kerry", "pentel-sharp-kerry.png"
attach_item_image "Rotring Tikky", "rotring-tikky.jpg"
attach_item_image "Caran d'Ache Ecridor", "caran-dache-ecridor.png"
attach_item_image "Lamy 2000", "lamy-2000.png"
attach_item_image "Uni Kuru Toga", "uni-kuru-toga-pipe-slide.jpg"
attach_item_image "Staedtler 925", "staedtler-925.jpg"

user = User.create!(email: "kangkyu@example.com", password: "1234")
o = Ownership.find_or_create_by(user: user, item: Item.first)

def attach_proof(ownership_id, image_file)
  return unless Ownership.exists?(id: ownership_id)

  Ownership.find(ownership_id).proof.attach(filename: image_file,
                                            io: File.open(Rails.root.join("app/assets/images/#{image_file}").to_s))
end

attach_proof o.id, "alvin-draft-matic-user.jpg"

User.create!(email: "admin@lininglink.com", password: "1234abcd")

u = User.create!(email: "jimmy@example.com", password: "1234abcd")
u.items.push items.first(10)

ig = ItemGroup.create(title: "Dave's Top 10")
ig.items.push items.first(3)

ItemGroup.create(title: "Kaleb's Picks")
