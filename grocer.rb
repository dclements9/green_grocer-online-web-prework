require 'pry'

def consolidate_cart(cart)
  output_hash = {}
    item_array = []
      cart.each do |object|
        object.each do |item, description|
          item_array << item
          output_hash[item] = description
          output_hash[item][:count] = item_array.count(item)
      end
    end
  output_hash
end


def apply_coupons(cart, coupons)
coupon_cart = cart
coupons.each do |savings|
      savings_item = savings[:item]
    if coupon_cart.has_key?(savings_item)
        item_count = 0
        while coupon_cart[savings[:item]][:count] >= savings[:num]
            item_count += 1
            coupon_cart["#{savings[:item]} W/COUPON"] = {
              price: savings[:cost],
              clearance: coupon_cart[savings[:item]][:clearance],
              count: item_count}
            coupon_cart[savings[:item]][:count] -= savings[:num]
        end
      end
    end
  coupon_cart
end

def apply_clearance(cart)
  output_cart = cart
    cart.each do |item, description|
      if cart[item][:clearance] == true
          output_price = cart[item][:price] * 0.8
          output_cart[item][:price] = output_price.round(2)
    end
  end
 output_cart
end

def checkout(cart, coupons)
  merged_cart = consolidate_cart(cart)
  savings_cart = apply_coupons(merged_cart, coupons)
  output_cart = apply_clearance(savings_cart)

    total = 0
  output_cart.each do |item, description|
    total += description[:price] * description[:count]
  end
  #binding.pry
  if total > 100
    total *= 0.9
  
  end
  binding.pry
  total
end
