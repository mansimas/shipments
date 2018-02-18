require 'discounter'

class DiscounterTest < Test::Unit::TestCase

  def test_discounts_for_21_S
    transactions = {
      :ignored=>[], 
      "2015-02"=>{
        "S"=>[
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>0, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>1, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>2, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>3, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>4, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>5, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>6, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>7, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>8, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>9, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>10, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>11, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>12, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>13, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>14, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>15, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>16, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>17, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>18, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>19, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>20, :month=>"2015-02"}
        ]
      }
    }

    discounts = Discounter.new(transactions).build_discounts

    expected = {
      :ignored=>[], 
      "2015-02"=>{
        "S"=>[
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>0, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>1, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>2, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>3, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>4, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>5, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>6, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>7, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>8, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>9, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>10, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>11, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>12, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>13, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>14, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>15, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>16, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>17, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>18, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>19, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>20, :month=>"2015-02"}
        ]
      }
    }  

    assert_equal discounts, expected
  end

  def test_discounts_for_7_L
    transactions = {
      :ignored=>[], 
      "2015-02"=>{
        "L"=>[
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>0, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>1, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>2, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>3, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>4, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>5, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>6, :month=>"2015-02"}
        ]
      }
    }

    discounts = Discounter.new(transactions).build_discounts

    expected = {
      :ignored=>[], 
      "2015-02"=>{
        "L"=>[
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>0, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>1, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>2, :month=>"2015-02", :discount=>6.9}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>3, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>4, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>5, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>6, :month=>"2015-02"}
        ]
      }
    }

    assert_equal discounts, expected
  end

  def test_discounts_for_different_months
    transactions = {
      :ignored=>[], 
      "2015-02"=>{
        "L"=>[
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>0, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>1, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>2, :month=>"2015-02"}
        ]
      }, 
      "2015-03"=>{
        "L"=>[
          {:date=>"2015-03-06", :size=>"L", :provider=>"LP", :index=>3, :month=>"2015-03"}, 
          {:date=>"2015-03-06", :size=>"L", :provider=>"LP", :index=>4, :month=>"2015-03"}, 
          {:date=>"2015-03-06", :size=>"L", :provider=>"LP", :index=>5, :month=>"2015-03"}
        ]
      }, 
      "2015-04"=>{
        "L"=>[
          {:date=>"2015-04-06", :size=>"L", :provider=>"LP", :index=>6, :month=>"2015-04"}
        ]
      }
    }

    discounts = Discounter.new(transactions).build_discounts

    expected = {
      :ignored=>[], 
      "2015-02"=>{
        "L"=>[
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>0, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>1, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>2, :month=>"2015-02", :discount=>6.9}
        ]
      }, 
      "2015-03"=>{
        "L"=>[
          {:date=>"2015-03-06", :size=>"L", :provider=>"LP", :index=>3, :month=>"2015-03"}, 
          {:date=>"2015-03-06", :size=>"L", :provider=>"LP", :index=>4, :month=>"2015-03"}, 
          {:date=>"2015-03-06", :size=>"L", :provider=>"LP", :index=>5, :month=>"2015-03", :discount=>6.9}
        ]
      }, 
      "2015-04"=>{
        "L"=>[
          {:date=>"2015-04-06", :size=>"L", :provider=>"LP", :index=>6, :month=>"2015-04"}
        ]
      }
    }

    assert_equal discounts, expected
  end

  def test_partial_discount
    transactions = {
      :ignored=>[], 
      "2015-02"=>{
        "L"=>[
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>0, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>1, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>2, :month=>"2015-02"}
        ], 
        "S"=>[
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>3, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>4, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>5, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>6, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>7, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>8, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>9, :month=>"2015-02"}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>10, :month=>"2015-02"}
        ]
      }
    }

    discounts = Discounter.new(transactions).build_discounts

    expected = {
      :ignored=>[], 
      "2015-02"=>{
        "L"=>[
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>0, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>1, :month=>"2015-02"}, 
          {:date=>"2015-02-06", :size=>"L", :provider=>"LP", :index=>2, :month=>"2015-02", :discount=>6.9}
        ], 
        "S"=>[
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>3, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>4, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>5, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>6, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>7, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>8, :month=>"2015-02", :discount=>0.5}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>9, :month=>"2015-02", :discount=>0.1}, 
          {:date=>"2015-02-05", :size=>"S", :provider=>"MR", :index=>10, :month=>"2015-02"}
        ]
      }
    }

    assert_equal discounts, expected
  end
end