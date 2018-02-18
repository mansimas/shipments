require 'file_iterator'

class FileIteratorTest < Test::Unit::TestCase

  def test_empty_file
    transactions = load_file('testing_1.txt').build_transactions
    assert_equal transactions, { :ignored=>[] }
  end

  def test_unknown_line
    transactions = load_file('testing_2.txt').build_transactions
    assert_equal transactions, { :ignored=>[ { :arrayed=>["oneline"], :index=>0 } ] }
  end

  def test_many_unknown_lines
    transactions = load_file('testing_3.txt').build_transactions

    expected = {
      :ignored=>[
        { :arrayed=>["."], :index=>0 }, 
        { :arrayed=>["'a"], :index=>1 }, 
        { :arrayed=>["324"], :index=>2 }, 
        { :arrayed=>["0'"], :index=>3 }, 
        { :arrayed=>["234"], :index=>4 }, 
        { :arrayed=>["asd,123-fds/asd", "sda", "123*", "*", "--"], :index=>5 }, 
        { :arrayed=>["3", "44", "cc", "3"], :index=>6 }, 
        { :arrayed=>["12", "a", "9-0-"], :index=>7 }
      ]
    }

    assert_equal transactions, expected
  end

  def test_unknown_line_and_known_line
    transactions = load_file('testing_4.txt').build_transactions

    expected = {
      :ignored=>[
        { :arrayed=>["2015-0201", "S", "MR"], :index=>0 }
      ], 
      "2015-02"=>{
        "S"=>[
          { :date=>"2015-02-01", :size=>"S", :provider=>"MR", :index=>1, :month=>"2015-02" }
        ]
      }
    }

    assert_equal transactions, expected
  end

  def test_S_M_L_lines
    transactions = load_file('testing_5.txt').build_transactions

    expected = {
      :ignored=>[], 
      "2015-02"=>{
        "L"=>[
          { :date=>"2015-02-11", :size=>"L", :provider=>"LP", :index=>0, :month=>"2015-02" }
        ], 
        "M"=>[
          {:date=>"2015-02-13", :size=>"M", :provider=>"LP", :index=>1, :month=>"2015-02"}
        ], 
        "S"=>[
          {:date=>"2015-02-15", :size=>"S", :provider=>"MR", :index=>2, :month=>"2015-02"}
        ]
      }
    }

    assert_equal transactions, expected
  end

  def test_not_allowed_date_formats
    transactions = load_file('testing_6.txt').build_transactions

    expected = {
      :ignored=>[
        { :arrayed=>["2015.02.11", "L", "LP"], :index=>0 }, 
        { :arrayed=>["2015-02.13", "M", "LP"], :index=>1 }, 
        { :arrayed=>["2015_02_15", "S", "MR"], :index=>2 }, 
        { :arrayed=>["20150215", "S", "MR"], :index=>3 }, 
        { :arrayed=>["02-11-2015", "S", "MR"], :index=>4 },
        { :arrayed=>["1899-02-02", "S", "MR"], :index=>5 },
        { :arrayed=>["2101-02-02", "S", "MR"], :index=>6 },
        { :arrayed=>["2000-02-32", "S", "MR"], :index=>7 },
        { :arrayed=>["2000-13-02", "S", "MR"], :index=>8 }
      ]
    }
    
    assert_equal transactions, expected
  end

  def load_file(file)
    base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
    FileIterator.new("#{base_dir}/tests/file_iterator_files/#{file}")
  end
end
