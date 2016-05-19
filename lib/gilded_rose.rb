class Update
  attr_accessor :item

  def initialize(item)
    @item = item
  end

  def reduce_quality_amount
    0
  end

  def max_limit
    50
  end

  def min_limit
    0
  end

  def maxed?
    item.quality = max_limit if item.quality > max_limit
  end

  def minus_sell_in
    item.sell_in -= 1
  end

  def quality_too_small?
    item.quality = min_limit if item.quality < min_limit
  end

  def update_all(name)
    name = name.new(item)
    name.reduce_quality_amount
    name.minus_sell_in
    name.maxed?
    name.quality_too_small?
  end

  def update_quality(items)
    items.each do |item|
      item.check_class
    end
  end

  def check_class
    updator_name = case item.name
    when "NORMAL ITEM" then NormalUpdator
    when "Aged Brie" then AgedBrieUpdator
    when "Sulfuras, Hand of Ragnaros" then SulfurasUpdator
    when "Backstage passes to a TAFKAL80ETC concert" then BackstagePassUpdator
    when "Conjured" then ConjuredUpdator
    end
    update_all(updator_name)
  end
end

class AgedBrieUpdator < Update
  def reduce_quality_amount
    item.quality += (item.sell_in > 0 ? 1 : 2)
  end
end

class SulfurasUpdator < Update
  def reduce_quality_amount
    0
  end

  def minus_sell_in 
  end

  def maxed?
  end
end

class BackstagePassUpdator < Update
  def reduce_quality_amount
    return item.quality = 0 if item.sell_in <= 0
    minus = if item.sell_in <= 5
      3
    elsif item.sell_in <= 10
      2
    else
      -1
    end
    item.quality += minus
  end
end

class ConjuredUpdator < Update
  def reduce_quality_amount
    item.quality += (item.sell_in > 0 ? -1 : -2)
  end
end

class NormalUpdator < Update
  def reduce_quality_amount
    item.quality += (item.sell_in > 0 ? -1 : -2)
  end
end

def update_quality(items)
  items.each do |item|
    Update.new(item).check_class
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
