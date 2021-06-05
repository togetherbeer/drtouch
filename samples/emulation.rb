# Written by Rabia Alhaffar in June 5, 2021
# Example shows touch emulation via mouse (Limited to one finger due to how mouse input works...)
# This example also works with touch input.
def tick args
  drtouch = DRTouch.new
  drtouch.init
  drtouch.update
  
  args.outputs.background_color = [ 0, 0, 0, 255 ]
  
  args.outputs.primitives << {
    x: 320,
    y: 16.from_top,
    text: "TAP AND MOVE YOUR FINGER OVER THE SCREEN",
    size_enum: 6,
    r: 255,
    g: 255,
    b: 255,
    a: 255,
  }.label
  
  if drtouch.down(0)
    pos = drtouch.pos(0)
  
    args.outputs.primitives << {
      x: pos.x,
      y: pos.y,
      w: 50,
      h: 50,
      r: 34,
      g: 155,
      b: 255,
      a: 255,
    }.solid
    
    args.outputs.primitives << {
      x: 16,
      y: 8.from_top,
      text: "x1: #{pos.x}, y1: #{pos.y}",
      size_enum: 2,
      r: 255,
      g: 0,
      b: 0,
      a: 255
    }.label
  end
end
