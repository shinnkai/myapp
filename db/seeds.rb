# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

item = Item.find_or_create_by(name: "車椅子",
                  explanation: "スタンダードタイプです。",
                  tax_out_price: 1500)
item.image.attach(io: File.open(Rails.root.join('app/assets/images/wheelchair-3605068_1280.jpeg')),
                  filename: 'wheelchair-3605068_1280.jpeg')

item = Item.find_or_create_by(name: "松葉杖",
                  explanation: "介護用松葉杖です。",
                  tax_out_price: 4300)
item.image.attach(io: File.open(Rails.root.join('app/assets/images/walker-gefe492424_640.png')),
                  filename: 'walker-gefe492424_640.png')

item = Item.find_or_create_by(name: "風呂椅子",
                  explanation: "介護用風呂いす（背もたれなし）です",
                  tax_out_price: 2800)
item.image.attach(io: File.open(Rails.root.join('app/assets/images/istockphoto-1189207028-1024x1024.jpeg')),
                  filename: 'istockphoto-1189207028-1024x1024.jpeg')

item = Item.find_or_create_by(name: "シルバーカー",
                  explanation: "4輪内収納有り、シルバーカーです。",
                  tax_out_price: 9400)
item.image.attach(io: File.open(Rails.root.join('app/assets/images/istockphoto-1031206120-612x612.jpeg')),
                  filename: 'istockphoto-1031206120-612x612.jpeg')

item = Item.find_or_create_by(name: "杖",
                  explanation: "１点、４点支えの杖です。",
                  tax_out_price: 2800)
item.image.attach(io: File.open(Rails.root.join('app/assets/images/istockphoto-995236422-612x612.jpeg')),
                  filename: 'istockphoto-995236422-612x612.jpeg')


