# PlasticWrap

A decorator.

## Installation

Add this line to your application's Gemfile:

    gem 'plastic_wrap'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plastic_wrap

## Usage

PlasticWrap is easy to use. There are 2 variants of wrapping.

The easiest and most maleable is Light.
This uses SimpleDelegator under the covers to do all the heavy lifting.

```ruby
class Leftovers
  def best_before
    @best_before ||= Time.now
  end
end

class ReadableBestBefore < PlasticWrap::Light
  def best_before
    super.strftime('%m-%y')
  end
end


ReadableBestBefore.wrap(Leftovers.new).best_before #=> 1-2001
```
The other variant is Heavy. This uses Delegator under the covers for its lifting.
You may want to use this is you don't want to deal with tracing through method_missing calls.

```ruby
class Leftovers
  def best_before
    @best_before ||= Time.now
  end
end

class ReadableBestBefore < PlasticWrap.create_wrap(Leftovers)
  def best_before
    super.strftime('%m-%y')
  end
end


ReadableBestBefore.wrap(Leftovers.new).best_before #=> 1-2001
```

No matter which variant you decide to use; the wrap method accepts Enumerables
and will return an array of nicely wrapped models. You also get the benefit of all the built-in
Rails helpers in your decorators.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
