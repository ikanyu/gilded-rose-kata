require 'byebug'

class Update
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def reduce_quality_amount
    0
  end

  def maxed?
    item.quality = 50 if item.quality > 50
  end

  def minus_sell_in
    item.sell_in -= 1
  end

  def check_quality
    update_name = case item.name
    when "NORMAL ITEM" then NormalUpdate
    when "Aged Brie" then AgedBrieUpdate
    when "Sulfuras, Hand of Ragnaros" then SulfurasUpdate
    when "Backstage passes to a TAFKAL80ETC concert" then BackstagePassUpdate
    when "Conjured" then ConjuredUpdate
    end
    update_name.new(item).reduce_quality_amount
  end
end

class AgedBrieUpdate < Update
  def reduce_quality_amount
    minus = item.sell_in > 0 ? 1 : 2
    item.quality += minus
    maxed?
    minus_sell_in
  end
end

class SulfurasUpdate < Update
  def reduce_quality_amount
    0
  end
end

class BackstagePassUpdate < Update
  def reduce_quality_amount
    if item.sell_in <= 0
      minus_sell_in
      return item.quality = 0 
    end
    minus = if item.sell_in <= 5
      3
    elsif item.sell_in <= 10
      2
    else
      -1
    end
    minus_sell_in
    item.quality += minus
    maxed?
    item.quality = 0 if item.quality < 0
  end
end

class ConjuredUpdate < Update
  def reduce_quality_amount
    minus = item.sell_in > 0 ? -1 : -2
    item.quality += minus
    item.quality = 0 if item.quality < 0
    minus_sell_in
  end
end

class NormalUpdate < Update
  def reduce_quality_amount
    minus = item.sell_in > 0 ? -1 : -2
    item.quality += minus
    item.quality = 0 if item.quality < 0
    minus_sell_in
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
