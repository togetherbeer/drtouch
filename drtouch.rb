# Written by Rabia Alhaffar in May 28, 2021
# drtouch, Touch library for DragonRuby.
# Updated: June 5, 2021

# DRTouch class, Handles the API implementation of drtouch library!
class DRTouch
  def init
    $gtk.args.state.drtouch.emulated         ||= !mobile ? 1 : 0
    $gtk.args.state.drtouch.current_touches  ||= [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
    $gtk.args.state.drtouch.touches_pos      ||= []
    $gtk.args.state.drtouch.previous_touches ||= [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ]
  end

  def update
    $gtk.args.state.drtouch.previous_touches = $gtk.args.state.drtouch.current_touches
    
    if ($gtk.args.state.drtouch.emulated == 0)
      count = 0
  
      $gtk.args.inputs.touch.each { |k, v|
        $gtk.args.state.drtouch.current_touches[count] = 1
        $gtk.args.state.drtouch.touches_pos[count] = { x: v.x, y: v.y }
        count += 1
      }
    
      (10 - count).times.map do |i|
        $gtk.args.state.drtouch.current_touches[count + i] = 0
        $gtk.args.state.drtouch.touches_pos[count + i] = { x: -1, y: -1 }
      end
    else
      $gtk.args.state.drtouch.current_touches[0] = $gtk.args.inputs.mouse.button_left ? 1 : 0
      $gtk.args.state.drtouch.touches_pos[0] = { x: $gtk.args.inputs.mouse.x, y: $gtk.args.inputs.mouse.y }
      
      9.times.map do |i|
        $gtk.args.state.drtouch.current_touches[1 + i] = 0
        $gtk.args.state.drtouch.touches_pos[1 + i] = { x: -1, y: -1 }
      end
    end
  end
  
  def down(i)
    return ($gtk.args.state.drtouch.current_touches[i] == 1)
  end
  
  def up(i)
    return ($gtk.args.state.drtouch.current_touches[i] == 0)
  end
  
  def tap(i)
    if $gtk.args.state.drtouch.emulated == 0
      return ($gtk.args.state.drtouch.current_touches[i] == 1 && $gtk.args.state.drtouch.previous_touches[i] == 0)
    else
      if (i == 0)
        return $gtk.args.inputs.mouse.click
      end
    end
  end
  
  def release(i)
    if $gtk.args.state.drtouch.emulated == 0
      return ($gtk.args.state.drtouch.current_touches[i] == 0 && $gtk.args.state.drtouch.previous_touches[i] == 0)
    else
      if (i == 0)
        return !$gtk.args.inputs.mouse.click
      end
    end
  end
  
  def touches
    count = 0
    
    $gtk.args.state.drtouch.current_touches.length.times.map do |t|
      if $gtk.args.state.drtouch.current_touches[t] == 1
        count += 1
      end
    end
    
    return count
  end
  
  def pos(i)
    t = $gtk.args.state.drtouch.touches_pos[i]
    
    if t
      return { x: t.x, y: t.y }
    else
      return { x: -1, y: -1 }
    end
  end
  
  def find(x, y)
    10.times.map do |i|
      tpos = pos(i)
    
      if ((tpos.x == x) && (tpos.y == y))
        return i
      end
    end
  end
  
  def touched_rect(i, r)
    p = pos(i)
    return ({ x: p.x, y: p.y, w: 1, h: 1 }).intersect_rect?(r)
  end
  
  def emulate
    $gtk.args.state.drtouch.emulated = 1
  end
  
  def mobile
    return ($gtk.platform == "iOS" || $gtk.platform == "Android")
  end
end
