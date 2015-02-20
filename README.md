### Usage

#### On a single number:

```ruby
credit_card = LuhnCreditCard.new('4111111111111111')

credit_card.type   # => 'VISA'
credit_card.status # => :valid
credit_card.valid? # => true
```

#### On a file like this (.txt):

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

### Dev

```
gem install bundler
bundle install
rspec spec
```