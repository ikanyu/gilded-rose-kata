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

  def quality_too_small?
    item.quality = 0 if item.quality < 0
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
    update_name.new(item).minus_sell_in
    update_name.new(item).maxed?
    update_name.new(item).quality_too_small?
  end
end

class AgedBrieUpdate < Update
  def reduce_quality_amount
    item.quality += (item.sell_in > 0 ? 1 : 2)
  end
end

class SulfurasUpdate < Update
  def reduce_quality_amount
    0
  end

  def minus_sell_in 
  end

  def maxed?
  end
end

class BackstagePassUpdate < Update
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

class ConjuredUpdate < Update
  def reduce_quality_amount
    item.quality += (item.sell_in > 0 ? -1 : -2)
  end
end

class NormalUpdate < Update
  def reduce_quality_amount
    item.quality += (item.sell_in > 0 ? -1 : -2)
  end
end

def update_quality(items)
  items.each do |item|
    Update.new(item).check_quality
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)
