require 'byebug'

class Update
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def check_quality
    case item.name
    when "NORMAL ITEM"
      if item.sell_in > 0
        item.quality -= 1
      else
        (item.quality - 2) < 0 ? item.quality = 0 : item.quality -= 2
      end
    when "Aged Brie"
      if item.sell_in > 0
        item.quality += 1
      else
        item.quality += 2
      end
      item.sell_in -= 1
      item.quality = 50 if item.quality >= 50
    when "Sulfuras, Hand of Ragnaros"
    when "Backstage passes to a TAFKAL80ETC concert"
      if item.sell_in <= 0
        item.quality = 0
      elsif item.sell_in <= 5
        item.quality += 3
      elsif item.sell_in <= 10
        item.quality += 2
      else
        item.quality -= 1
      end
      item.sell_in -= 1
    when "Conjured"
      if item.sell_in > 0
        item.quality -= 1
      else
        item.quality -= 2
      end
      item.sell_in -= 1
    else
      # puts "none"
    end
  end
end

def update_quality(items)
  items.each do |item|
    Update.new(item).check_quality
  #   if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert' # item == 'Normal Item'
  #     if item.quality > 0
  #       if item.name != 'Sulfuras, Hand of Ragnaros'
  #         item.quality -= 1
  #       end
  #     end
  #   else
  #     if item.quality < 50 # item == 'Aged Brie or Backstage passes'
  #       item.quality += 1
  #       if item.name == 'Backstage passes to a TAFKAL80ETC concert'
  #         if item.sell_in < 11
  #           if item.quality < 50
  #             item.quality += 1
  #           end
  #         end
  #         if item.sell_in < 6
  #           if item.quality < 50
  #             item.quality += 1
  #           end
  #         end
  #       end
  #     end
  #   end
  #   if item.name != 'Sulfuras, Hand of Ragnaros'
  #     item.sell_in -= 1
  #   end
  #   if item.sell_in < 0
  #     if item.name != "Aged Brie"
  #       if item.name != 'Backstage passes to a TAFKAL80ETC concert'
  #         if item.quality > 0
  #           if item.name != 'Sulfuras, Hand of Ragnaros'
  #             item.quality -= 1
  #           end
  #         end
  #       else
  #         item.quality = item.quality - item.quality
  #       end
  #     else
  #       if item.quality < 50
  #         item.quality += 1
  #       end
  #     end
  #   end
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
