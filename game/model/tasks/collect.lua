
local task = {}

local findsettlement  = require 'model.tasks.helpers.find_settlement'
local seek            = require 'model.tasks.helpers.seek'
local yield           = coroutine.yield

function task.run(agent, stage, children)
  local chosen = findsettlement(stage, 'harvest')
  return seek(agent, stage, chosen, 'collect')
end

return task

