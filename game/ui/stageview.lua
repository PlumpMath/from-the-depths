
local DB        = require 'db'
local MOUSE     = require 'ui.mouse'
local vec2      = require 'cpml' .vec2
local StageView = require 'lux.class' :new{}

local setfenv = setfenv
local love    = love
local print   = print
local pairs   = pairs
local unpack  = unpack
local string  = string

function StageView:instance(_obj, _stage)

  setfenv(1, _obj)

  local _TILESIZE = DB.load('defs')['tile-size']
  local _RUINS = love.graphics.newImage("assets/textures/ruins.png")
  local _SETTLEMENT = love.graphics.newImage("assets/textures/settlement.png")

  local _debug = false

  local _clicked = {}
  local _current_settlement = nil

  --[[ Camera ]]--

  local _campos = vec2(0,0)
  local _camspd = vec2(0,0)

  local function _tileClicked(i, j, mbutton)
    local mpos = (MOUSE.pos() - _campos) * (1/_TILESIZE)
    local mi, mj = _stage.map().point2pos(mpos)
    return MOUSE.clicked(mbutton) and mi == i and mj == j
  end

  function settlementSelected(settlement, i, j)
    if _tileClicked(i, j, 1) then
      _clicked[settlement] = 0.2
      _current_settlement = settlement
      return true
    end
  end

  function targetSelected(settlement, i, j)
    if _tileClicked(i, j, 2) then
      _clicked[settlement] = 0.2
      return true
    end
  end

  function update(dt)
    _debug = love.keyboard.isDown('f1')
    for k,v in pairs(_clicked) do
      local clicked = _clicked[k] - dt
      _clicked[k] = clicked > 0 and clicked or nil
    end
    if MOUSE.down(3) then
      _camspd = _camspd + MOUSE.motion() * 8
    end
    _campos = _campos + _camspd * dt
    _camspd = _camspd - _camspd * 0.1
  end

  function draw()
    local g = love.graphics
    local colors = DB.load('defs')['colors']
    local map = _stage.map()
    g.setBackgroundColor(colors['charleston-green'])
    local w,h = map.size()
    g.push()
    g.translate(_campos:unpack())
    for i=1,h do
      for j=1,w do
        g.push()
        g.translate((j-1)*_TILESIZE, (i-1)*_TILESIZE)
        g.setColor(colors['pale-gold'])
        if map.tilespec(i,j) == DB.load('tiletypes')['ruins'] then
          g.draw(_RUINS, 0, 0)
        end
        local settlement = map.getTileData(i, j, 'settlement')
        if settlement then
          g.setColor(colors['tiffany-blue'])
          g.draw(_SETTLEMENT, 0, 0)
          if _current_settlement == settlement then
            local clicked = _clicked[settlement] or 0
            g.push()
            g.setColor(colors['pale-pink'])
            g.translate(_TILESIZE/2, _TILESIZE/2)
            g.scale(1 + clicked, 1 + clicked)
            g.rectangle('line', -_TILESIZE/2, -_TILESIZE/2,
                                _TILESIZE, _TILESIZE)
            g.pop()
          end
        end
        if _debug then
          local bucket = map.getTileData(i, j, 'agents')
          if bucket then
            g.setColor(colors['pale-pink'])
            g.print(string.format("%d", bucket.n), 0, 0)
          end
        end
        g.pop()
      end
    end
    for _,agent in _stage.eachAgent() do
      g.push()
      g.translate((agent.pos() * _TILESIZE):unpack())
      g.setColor(colors['tiffany-blue'])
      g.polygon('fill', 0, -8, 8, 8, -8, 8)
      g.pop()
    end
    g.pop()
  end

end

return StageView

