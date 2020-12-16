-- 字符串的扩展方法
-- 第一个参数必须为string类型
---@class StringExtension
local StringExtension = {}

---@param s string
---@return string
function StringExtension.capitalize(s)
    local n = string.byte(s)
    local min = string.byte('a')
    local max = string.byte('z')
    local t = string.byte('A')
    if n >= min and n <= max then
        return string.char(n + t - min) .. string.sub(s, 2)
    end
    return s
end

---@param s string
---@param searchString string
---@param pos number default(0)
function StringExtension.startsWith(s, searchString, pos)
    pos = pos or 1
    for i = 1, #searchString do
        if string.byte(searchString, i)  ~= string.byte(s, i + pos - 1) then
            return false
        end
    end
    return true
end

---@param s string
---@param separator string
---@return string[]
function StringExtension.split(s, separator)
    
end

return StringExtension