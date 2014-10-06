# Blinkbox::CommonHelpers

A bunch of helpful snippets of Ruby.

## TicToc

Track how long things took in your app:

```ruby
include Blinkbox::CommonHelpers::TicToc
tic
sleep 9
p toc
# => 9001
# (It is over 9000 because time is an illusion, lunchtime doubly so)
```

You can also track timespans in parallel:

```ruby
include Blinkbox::CommonHelpers::TicToc
tic :a
sleep 1
tic :b
sleep 1
p toc :b
# => 1000
sleep 1
p toc :a
# => 3000
```
