luhn_credit_card
=====

### Usage

```
gem install luhn_credit_card
```

#### As a single number validator:

```ruby
credit_card = LuhnCreditCard.new('4111111111111111')

credit_card.type   # => 'VISA'
credit_card.status # => :valid
credit_card.valid? # => true
```

#### As a text file with numbers parser:

```
4111111111111111
4111111111111
4012888888881881
378282246310005
6011111111111117
5105105105105100
5105 1051 0510 5106
9111111111111111
```

```ruby
LuhnCreditCard.pretty_print_from_file(file_path)

# =>
"VISA: 4111111111111111 (valid)
VISA: 4111111111111 (invalid)
VISA: 4012888888881881 (valid)
AMEX: 378282246310005 (valid)
Discover: 6011111111111117 (valid)
MasterCard: 5105105105105100 (valid)
MasterCard: 5105105105105106 (invalid)
Unknown: 9111111111111111 (invalid)"
```

### Development

```
gem install bundler
bundle install
rspec spec
```
