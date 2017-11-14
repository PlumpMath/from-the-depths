
local DB          = require 'db'
local Queue       = require 'lux.common.Queue'
local Settlement  = require 'lux.class' :new{}

local setfenv = setfenv
local print   = print

function Settlement:instance(_obj)

  setfenv(1, _obj)

  local _DELAY    = DB.load('defs')['gameplay']['spawn-delay']
  local _pending  = Queue(128)
  local _count    = 0
  local _next     = false

  function tick(dt)
    if not _pending.isEmpty() then
      _count = _count + dt
      if _count >= _DELAY then
        _count = _count - _DELAY
        _next = true
      end
    else
      _count = _DELAY
    end
  end

  function requestSpawn(n, target)
    for i=1,n do
      _pending.push('test')
    end
  end

  function nextSpawn()
    if _next then
      _next = false
      return _pending.pop()
    end
  end

end

return Settlement

