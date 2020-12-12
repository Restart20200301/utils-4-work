---@class Functions
local Functions = {}

---@param func function
---@param this any
---other ...any
---@return function
function Functions.bind(func, this, ...)
    local t = { ... }
    local function f(...)
        local args = { (this == nil and nil or this) }
        for i = 1, #t do
            table.insert(args, t[i])
        end
        for _, v in ipairs({ ... }) do
            table.insert(args, v)
        end
        return func(table.unpack(args))
    end
    return f
end

return Functions