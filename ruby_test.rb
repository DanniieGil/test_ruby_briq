# Instrucciones:
# - Implementa el código necesario para que el código de cada uno de los ejercicios funcione.
# - No uses ActiveRecord, usa solo objetos "normales" de ruby.
# - Trabaja la implementación ejercicio por ejercicio.

#### Escribe aquí el código ####

#### Termina tu código ####

#### 1 ####
## Inventario ##

class Product
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

iPod = Product.new('iPod', 229.00)
iMac = Product.new('iMac', 1199.00)
iPhone = Product.new('iPhone', 49.00)

puts iPod.inspect
puts iMac.inspect
puts iPhone.inspect

# # #### 2 ####
# # ## Agregar productos al carrito ##
class Cart
  attr_reader :items

  def initialize
    @items = []
  end

  def add(product, _quantity = 1)
    product_exit_in_cart = @items.find { |item| item[:name] == product.name }

    if product_exit_in_cart
      product_exit_in_cart[:quantity] += 1
      product_exit_in_cart[:price] += product.price
    else
      @items.push({ name: product.name, quantity: _quantity, price: product.price * _quantity })
    end
  end

  def price
    @items.inject(0) { |sum, item| sum + item[:price] }
  end

  def discount
    items.reduce(0) do |discount_total, item|
      # Discount => 1xiMac -> (1xiPhone - 20%)
      if item[:name] == 'iMac' && item[:quantity] >= 1
        product_to_apply_discount = items.find { |item| item[:name] == 'iPhone' }
        price_unit_product_to_apply_discount = product_to_apply_discount[:price] / product_to_apply_discount[:quantity]
        discount_20_percent_off = if product_to_apply_discount[:quantity] >= 2
                                    price_unit_product_to_apply_discount * 0.2 * item[:quantity]
                                  else
                                    price_unit_product_to_apply_discount * 0.2
                                  end
        discount_total + discount_20_percent_off
      # Discount => iPod 2x1,
      elsif item[:name] == 'iPod' && item[:quantity] >= 2
        discount_total + (item[:quantity] - (item[:quantity] / 2.00).round) * (item[:price] / item[:quantity])
      else
        discount_total
      end
    end
  end
end

cart = Cart.new
second_cart = Cart.new

cart.add(iMac)
cart.add(iPhone)
cart.add(iPod, 2)

second_cart.add(iMac, 2)
second_cart.add(iPod)
second_cart.add(iPod)
second_cart.add(iPhone, 5)

puts 'CARTS COMPLETED:'
puts 'FIRST_CART:'
puts cart.inspect

puts '------------------'
puts 'SECOND_CART:'
puts second_cart.inspect

#
# #### 3 ####
# # Detalle de la compra ##
#
puts 'CARTS DETAILED:'
puts 'FIRST_CART:'
cart.items.each do |item|
  puts "#{item[:name]} - #{item[:quantity]} - #{item[:price]} US$"
end

puts '------------------'
puts 'SECOND_CART:'
second_cart.items.each do |item|
  puts "#{item[:name]} - #{item[:quantity]} - #{item[:price]} US$"
end

# #
# # #### 4 ####
# # # Calcular el total del carrito ##
puts '------------------'
puts 'TOTAL_PRICES_CARTS:'
puts "Los productos de tu PRIMER carrito valen: $ #{cart.price}"
puts "Los productos de tu SEGUNDO carrito valen: $ #{second_cart.price}"

# #
# # #### 5 ####
# # ## Descuentos: iPods 2 x 1, iMac => (iPhone - 20%)

puts '------------------'
puts 'DISCOUNT_FIRST_CART:'
puts "Tu compra aplica un descuento de: $ #{cart.discount}."
puts "El total de tu compra es de #{cart.price - cart.discount}."

puts '------------------'
puts 'DISCOUNT_SECOND_CART:'
puts "Tu compra aplica un descuento de: $ #{second_cart.discount}."
puts "El total de tu compra es de #{second_cart.price - second_cart.discount}."

# #
# # ### 6 (Bonus) ###
# # puts "Agrega al inventario todos los productos de la familia mac con sus precios actuales de apple.com"
# # puts "Puedes traer la informacion de http://store.apple.com/"

class Inventory
  attr_reader :store

  def initialize
    @store = []
  end

  def add(product, category, image)
    @store.push({ name: product.name, price: product.price, category: category, image: image })
  end

  def delete(product)
    @store.delete(product)
  end

  def update(product)
    @store.update(product)
  end
end

puts '------------------'
puts 'INVENTORY:'
inventory = Inventory.new

inventory.add(Product.new('MacBook Air with M1 Chip', 999), %w[laptop portatil],
              'https://store.storeimages.cdn-apple.com/4982/test')
inventory.add(Product.new('MacBook Air with M2 Chip', 1199), ['laptop'],
              'https://store.storeimages.cdn-apple.com/4982/test')
inventory.add(Product.new('MacBook Pro 14in', 1999), ['laptop'], 'https://store.storeimages.cdn-apple.com/1/test')
inventory.add(Product.new('iMac 24in', 1299), ['laptop'], 'https://store.storeimages.cdn-apple.com/2/test')
inventory.add(Product.new('iPhone 14 Pro', 9999), ['phone'], 'https://store.storeimages.cdn-apple.com/3/test')
inventory.add(Product.new('iPhone 14 Pro Max', 9999), ['phone'], 'https://store.storeimages.cdn-apple.com/4/test')
inventory.add(Product.new('iPhone 14 Pro', 799), ['phone'], 'https://store.storeimages.cdn-apple.com/5/test')
inventory.add(Product.new('iPhone 13 Mini', 599), ['phone'], 'https://store.storeimages.cdn-apple.com/6/test')
inventory.add(Product.new('iPhone SE', 429), ['phone'], 'https://store.storeimages.cdn-apple.com/7/test')
inventory.add(Product.new('iPhone 12', 599), ['phone'], 'https://store.storeimages.cdn-apple.com/8/test')
inventory.add(Product.new('iPad Pro', 799), ['tablet'], 'https://store.storeimages.cdn-apple.com/9/test')
inventory.add(Product.new('iPad Air', 599), ['tablet'], 'https://store.storeimages.cdn-apple.com/10/test')
inventory.add(Product.new('iPad 10th', 449), ['tablet'], 'https://store.storeimages.cdn-apple.com/11/test')
inventory.add(Product.new('iPad 9th', 329), ['tablet'], 'https://store.storeimages.cdn-apple.com/12/test')
inventory.add(Product.new('iPad Mini', 499), ['tablet'], 'https://store.storeimages.cdn-apple.com/13/test')
inventory.add(Product.new('Apple Watch Ultra', 799), %w[watch smartwatch reloj], 'https://store.storeimages.cdn-apple.com/14/test')
inventory.add(Product.new('Apple Watch Series 8', 399), %w[watch smartwatch reloj],
              'https://store.storeimages.cdn-apple.com/15/test')
inventory.add(Product.new('Apple Watch SE', 249), %w[watch smartwatch reloj],
              'https://store.storeimages.cdn-apple.com/16/test')
inventory.add(Product.new('AirPods 3rd', 169), %w[airpods headphone],
              'https://store.storeimages.cdn-apple.com/17/test')
inventory.add(Product.new('AirPods 2rd', 129), %w[airpods headphone],
              'https://store.storeimages.cdn-apple.com/18/test')
inventory.add(Product.new('AirPods Max', 549), %w[airpods headphone],
              'https://store.storeimages.cdn-apple.com/19/test')

# puts inventory.inspect
inventory.store.each do |item|
  puts "#{item[:name]} - #{item[:quantity]} - #{item[:price]} US$ - #{item[:category]} - #{item[:image]}"
end
