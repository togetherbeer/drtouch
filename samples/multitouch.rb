# Written by Rabia Alhaffar in June 5, 2021
# Freaking-Simple example that illustrates how to handle multiple fingers with DragonRuby and drtouch!
# NOTE: This is only example doesn't work with mouse input when using more than one finger...
def tick args
  drtouch = DRTouch.new
  drtouch.init
  drtouch.update
  
  args.outputs.background_color = [ 0, 0, 0, 255 ]
  
  args.outputs.primitives << {
    x: 300,
    y: 16.from_top,
    text: "TAP/MOVE WITH MORE THAN ONE FINGER ON SCREEN",
    size_enum: 6,
    r: 255,
    g: 255,
    b: 255,
    a: 255,
  }.label
  
  drtouch.touches.times.map do |i|
    pos = drtouch.pos(i)
    
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
      y: ((i * 32) + 8).from_top,
      text: "x#{i + 1}: #{pos.x}, y#{i + 1}: #{pos.y}",
      size_enum: 2,
      r: 255,
      g: 0,
      b: 0,
      a: 255
    }.label
  end
end
