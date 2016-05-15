require_relative '../lib/gilded_rose'

describe "#update_quality" do

  context "with a single item" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    # before { update_quality([item]) }

    context "Normal Items" do
      let(:name) { "NORMAL ITEM" }
      it { update_quality([item]); expect(item.quality).to eql(initial_quality - 1) }
    end

    context "Aged Brie" do
      let(:name) { "Aged Brie" }
      it { 
        update_quality([item]); 
        expect(item.quality).to eql(initial_quality + 1);
        expect(item.quality).not_to be > 50; 
        expect(item.quality).not_to be < 0; 
      }
    end

    context "Sulfuras" do
      let(:name) { "Sulfuras, Hand of Ragnaros" }
      let(:initial_quality) { 80 }
      it { 
        update_quality([item]);
        expect(item.sell_in).to eql(initial_sell_in);
        expect(item.quality).to eql(initial_quality);
      }
    end

    context "Backstage Pass" do
      let(:name) { "Backstage passes to a TAFKAL80ETC concert" }
      let(:initial_quality) { 10 }  
      
      context "with 10 days or less" do
        let(:initial_sell_in) { 7 }
        it { 
          update_quality([item]); 
          expect(item.sell_in).to eql(initial_sell_in - 1);
          expect(item.quality).to eql(initial_quality + 2);
          expect(item.quality).not_to be > 50; 
          expect(item.quality).not_to be < 0; 
        }
      end

      context "with 5 days or less" do
        let(:initial_sell_in) { 4 }
        it { 
          update_quality([item]); 
          expect(item.sell_in).to eql(initial_sell_in - 1);
          expect(item.quality).to eql(initial_quality + 3);
          expect(item.quality).not_to be > 50; 
          expect(item.quality).not_to be < 0; 
        } 
      end

      context "after concert" do
        let(:initial_sell_in) { 0 }
        it { 
          update_quality([item]); 
          expect(item.sell_in).to eql(initial_sell_in - 1);
          expect(item.quality).to eql(0);
        } 
      end
    end

    context "Conjured" do
      let(:name) { "Conjured" }
      it { update_quality([item]) }
    end

  end

  context "with multiple items" do
    let(:items) {
      [
        Item.new("NORMAL ITEM", 5, 10),
        Item.new("Aged Brie", 3, 10),
      ]
    }

    before { update_quality(items) }

    # it "your specs here" do
    #   pending
    # end
  end
end
