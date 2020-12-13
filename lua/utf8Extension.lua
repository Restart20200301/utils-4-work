-- utf8 编码的字符串函数的扩展
-- 第一个参数必须为uft8编码的字符串
---@class utf8Extension
local utf8Extension = {}

---@param s string
---@return number
function utf8Extension.len(s)
    local res = utf8Extension._toLenArray(s)
    return #res - 1
end

---@param s string
---@param indexStart number
---@param indexEnd number default(len(s))
---@return string
function utf8Extension.substring(s, indexStart, indexEnd)
    indexStart = indexStart or 1
    local res = utf8Extension._toLenArray(s)
    indexEnd = indexEnd or #res
    local first = res[indexStart] + 1
    local last = res[indexEnd + 1]
    return string.sub(s, first, last)
end

---@param s string
---@return char
function utf8Extension.charAt(s, pos)
    local res = utf8Extension._toLenArray(s)
    pos = pos or 1
    pos = pos < 1 and 1 or pos
    pos = pos > #res and #res or pos
    return string.sub(s, res[pos] + 1, res[pos + 1])
end

---@param byte number
---@return number
function utf8Extension._charSize(byte)
    return byte < 128 and 1 or (byte < 224 and 2 or (byte < 240 and 3 or 4))
end

---@param s string
---@return any[]
function utf8Extension._toLenArray(s)
    local res = { 0 }
    local pos = 1
    while pos <= #s do
        local t = utf8Extension._charSize(string.byte(s, pos))
        table.insert(res, res[#res] + t)
        pos = pos + t
    end
    return res
end

return utf8Extension