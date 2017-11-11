
--- TODO list
--  + [ ] Heap
--  + [ ] A* algorithm
--  + [ ] pathfinding agents

require 'lib'

local DB    = require 'db'
local Agent = require 'model.agent'
local Map   = require 'model.map'
local vec2  = require 'cpml' .vec2

local _SPAWN_DELAY = 2

local _map
local _spawns = {}
local _agents = {}

local function _addSpawn(pos, team)
  table.insert(_spawns, { pos = pos, team = team, delay = _SPAWN_DELAY })
end

local function _addAgent(pos, team)
  local agent = Agent('test')
  agent.setPos(pos)
  agent.setTarget(vec2(640, 360))
  table.insert(_agents, agent)
end

function love.load()
  _map = Map('test')
  _addSpawn(vec2(200,200), 1)
  _addSpawn(vec2(800,400), 1)
end

function love.update(dt)
  for _,spawn in ipairs(_spawns) do
    spawn.delay = spawn.delay - dt
    if spawn.delay < 0 then
      spawn.delay = spawn.delay + _SPAWN_DELAY
      _addAgent(spawn.pos, spawn.team)
    end
  end
  for _,agent in ipairs(_agents) do
    agent.move(dt)
  end
end

function love.draw()
  local g = love.graphics
  local colors = DB.load('defs').colors
  g.setBackgroundColor(colors['charleston-green'])
  local w,h = _map.size()
  for i=1,h do
    for j=1,w do
      if _map.tilespec(i,j) == DB.load('tiletypes')['ruins'] then
        g.push()
        g.translate(j*32, i*32)
        g.setColor(colors['pale-pink'])
        g.rectangle('fill', 4, 4, 24, 24)
        g.pop()
      end
    end
  end
  for _,agent in ipairs(_agents) do
    g.push()
    g.translate(agent.pos():unpack())
    g.setColor(colors['tiffany-blue'])
    g.polygon('fill', 0, -8, 8, 8, -8, 8)
    g.pop()
  end
end

