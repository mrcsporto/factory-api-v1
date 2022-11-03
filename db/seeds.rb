# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  puts "Cadastrando centros de inventários."

    10.times do |i|
      InventoryCenter.create!(
      name: Faker::Commerce.unique.brand
    )
  end

  puts "Centros de inventários cadastrados!"

  ########################

  puts "Cadastrando produtos..."

    InventoryCenter.all.each do |inventory|
      Random.rand(10).times do |i|
        products = Product.create!(
          product_sku:Faker::Barcode.ean(8),
          quantity:Faker::Number.between(from: 1, to: 1000)
        )

        inventory.products << products
        inventory.save!
      end
    end

  puts "Produtos cadastrados com sucesso!"



