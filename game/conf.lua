
function love.conf(t)
  t.identity = "aigame-simulator"
  t.version = "0.10.2"
  t.console = false
  t.accelerometerjoystick = false
  t.externalstorage = false
  t.gammacorrect = true

  t.window.title = "AI Game Simulator"
  t.window.icon = nil
  t.window.width = 1280
  t.window.height = 720
  t.window.borderless = true
  t.window.resizable = false
  t.window.minwidth = 1
  t.window.minheight = 1
  t.window.fullscreen = false
  t.window.fullscreentype = "desktop"
  t.window.vsync = true
  t.window.msaa = 0
  t.window.display = 1
  t.window.highdpi = false
  t.window.x = nil
  t.window.y = nil

  t.modules.audio = true              -- Enable the audio module (boolean)
  t.modules.event = true              -- Enable the event module (boolean)
  t.modules.graphics = true           -- Enable the graphics module (boolean)
  t.modules.image = true              -- Enable the image module (boolean)
  t.modules.joystick = true           -- Enable the joystick module (boolean)
  t.modules.keyboard = true           -- Enable the keyboard module (boolean)
  t.modules.math = true               -- Enable the math module (boolean)
  t.modules.mouse = true              -- Enable the mouse module (boolean)
  t.modules.physics = true            -- Enable the physics module (boolean)
  t.modules.sound = true              -- Enable the sound module (boolean)
  t.modules.system = true             -- Enable the system module (boolean)
  t.modules.timer = true              -- Enable the timer module (boolean),
                                      -- Disabling it will result 0 delta time
                                      -- in love.update
  t.modules.touch = true              -- Enable the touch module (boolean)
  t.modules.video = true              -- Enable the video module (boolean)
  t.modules.window = true             -- Enable the window module (boolean)
  t.modules.thread = true             -- Enable the thread module (boolean)
end
