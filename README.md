# drtouch

Touch input library written in Ruby for DragonRuby GTK!

Portions of this library used by the developer (Rabia Alhaffar) to adapt his DragonRuby games to run on mobile platforms, Also the library supports touch emulation of one finger via mouse input.

## Setup

> NOTE: drtouch requires "Pro" version of DragonRuby GTK!

### Without Smaug

Download `drtouch.rb` as raw to `app` folder of your project and in `main.rb` require it:

```rb
require "app/drtouch.rb"
```

### With Smaug

Install package with `smaug add drtouch` and then require `smaug.rb` as ya used to!

## Usage

Once you setup and installed drtouch, In your `tick` function initialize drtouch and update with following:

```rb
drtouch = DRTouch.new   # As DRTouch is class, We create instance of class
drtouch.init
drtouch.update
```

Check `samples` folder to see how drtouch works.

## API

All drtouch library functions exposed in class `DRTouch` and API made to be simple to use.

```rb
# Functions
init()                                      # Initializes drtouch library.
update()                                    # Updates touches. 
down(i)                                     # Returns true if finger by index held/exists on screen or false if not.
up(i)                                       # Returns true if finger by index not on screen or false if not.
tap(i)                                      # Returns true if tapped/pressed with finger by index on screen or false if not.
release(i)                                  # Returns true if left finger by index after tap on screen or false if not.
touches()                                   # Returns touches count.
pos(i)                                      # Returns position of a finger touch on screen by index.
find(x, y)                                  # Returns finger index by position.
touched_rect(i, rect)                       # Returns true if finger by index touches a rectangle on screen or false if not.
mobile()                                    # Returns true if device is mobile or false if not.

# Internals, Used within the library
$gtk.args.state.drtouch.emulated            # State of touch emulation, 1 if emulated via mouse of 0 if on mobile.
$gtk.args.state.drtouch.current_touches     # Array of 1s and 0s of current touches state.
$gtk.args.state.drtouch.touches_pos         # Array of touches positions.
$gtk.args.state.drtouch.previous_touches    # Array of 1s and 0s of old touches state.
```

## DEV NOTES:

1. drtouch by default handles limit of touches from 2 hands, Which is 10 fingers.
2. drtouch initialized in hash `$gtk.args.state.drtouch` and that's to make it easy to serialize away of the state if data is big.

## License

```
MIT License

Copyright (c) 2021 - 2022 Rabia Alhaffar

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
