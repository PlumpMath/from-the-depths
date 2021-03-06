
local TASK = {}

function TASK.run(agent, stage, children)
  for _,child in ipairs(children) do
    if not child.run(agent, stage) then
      return false
    end
  end
  return true
end

return TASK

