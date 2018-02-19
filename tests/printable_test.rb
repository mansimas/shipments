require 'printable'

# Testing Printable class
class PrintableTest < Test::Unit::TestCase
  def test_only_mr_s
    discounts = {
      ignored: [],
      '2015-02' => {
        'S' => [
          { date: '2015-02-05', size: 'S', provider: 'MR', index: 0, month: '2015-02', discount: 0.5 }
        ]
      }
    }

    data = Printable.new(discounts).build_data

    assert_equal data, ['2015-02-05 S MR 1.50 0.50']
  end

  def test_with_different_months
    discounts = {
      ignored: [],
      '2015-02' => {
        'L' => [
          { date: '2015-02-06', size: 'L', provider: 'LP', index: 0, month: '2015-02' },
          { date: '2015-02-06', size: 'L', provider: 'LP', index: 1, month: '2015-02' },
          { date: '2015-02-06', size: 'L', provider: 'LP', index: 2, month: '2015-02', discount: 6.9 }
        ]
      },
      '2015-03' => {
        'L' => [
          { date: '2015-03-06', size: 'L',  provider: 'LP', index: 3, month: '2015-03'},
          { date: '2015-03-06', size: 'L', provider: 'LP', index: 4, month: '2015-03'},
          { date: '2015-03-06', size: 'L', provider: 'LP', index: 5, month: '2015-03', discount: 6.9 }
        ]
      },
      '2015-04' => {
        'L' => [
          { date: '2015-04-06', size: 'L', provider: 'LP', index: 6, month: '2015-04' }
        ]
      }
    }

    data = Printable.new(discounts).build_data

    expected = [
      '2015-02-06 L LP 6.90 -',
      '2015-02-06 L LP 6.90 -',
      '2015-02-06 L LP 0.00 6.90',
      '2015-03-06 L LP 6.90 -',
      '2015-03-06 L LP 6.90 -',
      '2015-03-06 L LP 0.00 6.90',
      '2015-04-06 L LP 6.90 -'
    ]

    assert_equal data, expected
  end

  def test_with_ignored
    discounts = {
      ignored: [
        { arrayed: ['2015-0201', 'S', 'MR'], index: 0 }
      ],
      '2015-02' => {
        'S' => [
          { date: '2015-02-01', size: 'S', provider: 'MR', index: 1, month: '2015-02', discount: 0.5 }
        ]
      }
    }

    data = Printable.new(discounts).build_data

    expected = [
      '2015-0201 S MR Ignored',
      '2015-02-01 S MR 1.50 0.50'
    ]

    assert_equal data, expected
  end
end
