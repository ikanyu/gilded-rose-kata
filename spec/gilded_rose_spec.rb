require_relative '../lib/gilded_rose'

describe "#update_quality" do

  context "with a single item" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    context "Normal Items" do
      let(:name) { "NORMAL ITEM" }

      context "before sell_in date ended" do
        it { 
          update_quality([item]); 
          expect(item.quality).to eql(initial_quality - 1) 
        }
      end

      context "on last day of sell_in date" do
        let(:initial_sell_in) { 0 }
        let(:initial_quality) { 5 }
        it { 
          update_quality([item]); 
          expect(item.quality).to eql(initial_quality - 2);
        }
      end

      context "after sell_in date ended" do
        let(:initial_sell_in) { -1 }
        let(:initial_quality) { 1 }
        it {
          update_quality([item]); 
          expect(item.quality).to eql(0); 
        }
      end

      context "quality never negative" do
        let(:initial_sell_in) { 1 }
        let(:initial_quality) { 0 }
        it {
          update_quality([item]);
          expect(item.quality).to eql(0);
        }
      end
    end

    context "Aged Brie" do
      let(:name) { "Aged Brie" }
      context "with normal cases" do 
        it { 
          update_quality([item]); 
          expect(item.quality).to eql(initial_quality + 1);
          expect(item.quality).not_to be > 50; 
          expect(item.quality).not_to be < 0; 
        }
      end

      context "with maximum quality equals to 50" do
        let(:initial_sell_in) { -1 }
        let(:initial_quality) { 50 }
        it {
          update_quality([item]); 
          expect(item.sell_in).to eql(initial_sell_in - 1);
          expect(item.quality).to eql(50);
        }
      end

      context "on last day of sell_in date" do
        let(:initial_sell_in) { 0 }
        let(:initial_quality) { 10 }
        it { 
          update_quality([item]); 
          expect(item.sell_in).to eql(initial_sell_in - 1);
          expect(item.quality).to eql(initial_quality + 2);
          expect(item.quality).not_to be > 50; 
          expect(item.quality).not_to be < 0; 
        }
      end

      context "after sell_in date" do
        let(:initial_sell_in) { 10 }
        let(:initial_quality) { 5 }
        it { 
          update_quality([item]); 
          expect(item.sell_in).to eql(initial_sell_in - 1);
          expect(item.quality).to eql(initial_quality + 1);
        }
      end
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
      
      context "with 0 days of sell_in date" do
        let(:initial_sell_in) { -1 }
        it { 
          update_quality([item]); 
          expect(item.sell_in).to eql(initial_sell_in - 1);
          expect(item.quality).to eql(0);
        } 
      end

      context "with maximum quality" do
        let(:initial_sell_in) { 10 }
        let(:initial_quality) { 50 }
        it {
          update_quality([item]);
          expect(item.quality).to eql(50);
        }
      end

    end

    context "Conjured" do
      let(:name) { "Conjured" }

      context "before sell_in date" do
        let(:initial_sell_in) { 5 }
        it { 
          update_quality([item]); 
          expect(item.sell_in).to eql(initial_sell_in - 1);
          expect(item.quality).to eql(initial_quality - 1);        
        }
      end

      context "after sell_in date" do
        let(:initial_sell_in) { 0 }
        it {
          update_quality([item]);
          expect(item.sell_in).to eql(initial_sell_in - 1);
          expect(item.quality).to eql(initial_quality - 2);        
        }
      end
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
  end
end
