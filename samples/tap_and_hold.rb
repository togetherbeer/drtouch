# Written by Rabia Alhaffar in June 5, 2021
# Simple example shows how to handle hold and tap of finger touch.
def tick args
  drtouch = DRTouch.new
  drtouch.init
  drtouch.update
  
  args.state.hold_rect_color ||= { r: 34, g: 155, b: 255, a: 255 }
  args.state.tap_rect_color  ||= { r: 0,  g: 255, b: 0,   a: 255 }
  
  args.outputs.background_color = [ 0, 0, 0, 255 ]
  
  labels_color = { r: 255, g: 255, b: 255, a: 255 }
  
  args.outputs.primitives << ({
    x: 8,
    y: 16.from_top,
    text: "HOLD ON BLUE RECTANGLE TO TRIGGER TOUCH DOWN",
    size_enum: 4,
  }).merge(labels_color).label
  
  args.outputs.primitives << ({
    x: 8,
    y: 48.from_top,
    text: "TAP ON GREEN RECTANGLE TO TRIGGER TAP",
    size_enum: 4,
  }).merge(labels_color).label
  
  hold_rect = { x: 292, y: 300, w: 128, h: 128 }
  args.outputs.primitives << hold_rect.merge(args.state.hold_rect_color).solid
  
  tap_rect = { x: 820, y: 300, w: 128, h: 128, }
  args.outputs.primitives << tap_rect.merge(args.state.tap_rect_color).solid

  if drtouch.touched_rect(0, hold_rect)
    if drtouch.down(0)
      args.state.hold_rect_color = { r: 255, g: 0, b: 0, a: 255 }
    else
      args.state.hold_rect_color = { r: 34, g: 155, b: 255, a: 255 }
    end
  end
  
  if drtouch.touched_rect(0, tap_rect)
    if drtouch.tap(0)
      args.state.tap_rect_color = { r: 255, g: 0, b: 0, a: 255 }
    else
      args.state.tap_rect_color = { r: 0, g: 255, b: 0, a: 255 }
    end
  end
end
