# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

alvin = Maker.create(title: "Alvin")
caran = Maker.create(title: "Caran d'Ache")
faber = Maker.create(title: "Faber-Castell")
kaweco = Maker.create(title: "Kaweco")
rotring = Maker.create(title: "Rotring")
pentel = Maker.create(title: "Pentel")
pilot = Maker.create(title: "Pilot")

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
  # { title: "Lamy 2000", maker: "Lamy" },
  # { title: "Lamy Safari", maker: "Lamy" },
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
  { title: "Pilot Automac", maker_id: pilot.id },
  { title: "Pilot Dr. Grip", maker_id: pilot.id },
  { title: "Pilot S3", maker_id: pilot.id },
  { title: "Pilot S10", maker_id: pilot.id },
  { title: "Pilot S20", maker_id: pilot.id },
  { title: "Pilot S30", maker_id: pilot.id },
  # { title: "Platinum Pro-Use I (MSD-1000)", maker: "Platinum" },
  # { title: "Platinum Pro-Use II (MSD-1500)", maker: "Platinum" },
  # { title: "Platinum Pro-Use 171", maker: "Platinum" },
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
  # { title: "Staedtler graphite 925", maker: "Staedtler" },
  # { title: "Staedtler Mars Technico", maker: "Staedtler" },
  # { title: "Staedtler 925", maker: "Staedtler" },
  # { title: "Tombow Mono Graph Zero", maker: "Tombow" },
  # { title: "Tombow Zoom 505sh", maker: "Tombow" },
  # { title: "Uni 552", maker: "Uni" },
  # { title: "Uni Alpha-gel", maker: "Uni" },
  # { title: "Uni Alpha-gel Switch", maker: "Uni" },
  # { title: "Uni Kuru Toga", maker: "Uni" },
  # { title: "Uni Kuru Toga Dive", maker: "Uni" },
  # { title: "Ystudio Classic", maker: "YStudio" },
  # { title: "YStudio Classic Revolve Sketching", maker: "YStudio" },
  # { title: "Zebra DelGuard", maker: "Zebra" },
  # { title: "Zebra Drafix", maker: "Zebra" },
  # { title: "Zebra M301", maker: "Zebra" },
  # { title: "Zebra M701", maker: "Zebra" },
  # { title: "Pentel Sharp Kerry", maker: "Pentel" },
  # { title: "Tombow Zoom", maker: "Tombow" },
  # { title: "Blick Premier", maker: "Blick" }
])

User.create!(email: "kangkyu@example.com", password: "1234")
Ownership.find_or_create_by(user: User.first, item: Item.first)

u = User.create!(email: "jimmy@example.com", password: "1234abcd")
u.items.push items.first(10)

ig = ItemGroup.create(title: "Dave's Top 10")
ig.items.push items.first(3)

ItemGroup.create(title: "Kaleb's Picks")
