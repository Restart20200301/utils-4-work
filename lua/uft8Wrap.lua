-- utf8 包装类, 包装lua的字符串类型
-- 字符串里的字节存储得保证是utf8编码才能使用

---@param byte number
---@return number
local function charSize(byte)
    return byte < 128 and 1 or (byte < 224 and 2 or (byte < 240 and 3 or 4))
end

---@param s string
---@return any[]
local function toLenArray(s)
    local res = { 0 }
    local pos = 1
    while pos <= #s do
        local t = charSize(string.byte(s, pos))
        table.insert(res, res[#res] + t)
        pos = pos + t
    end
    return res
end

---@param obj utf8Wrap
---@param s string
local function init(obj, s)
    obj._str = s
    obj._data = toLenArray(s)
    obj.length = #(obj._data) - 1
end

---@class utf8Wrap
local utf8Wrap = {}

---@param s string
---@return utf8Wrap
function utf8Wrap.new(s)
    local t = {}
    init(t, s)
    setmetatable(t, {
        __index = utf8Wrap,
        __concat = utf8Wrap.concat,
    })
    return t
end

---@param pos number
---@return string  char
function utf8Wrap:charAt(pos)
    if pos == nil or pos < 1 or pos > self.length then
        return ""
    end
    return string.sub(self._str, self._data[pos] + 1, self._data[pos + 1])
end

---@param indexStart number
---@param indexEnd number default(字符串长度)
function utf8Wrap:substring(indexStart, indexEnd)
    indexEnd = indexEnd or self.length
    return string.sub(self._str, self._data[indexStart] + 1, self._data[indexEnd + 1])
end

---@param searchString string
---@return boolean
function utf8Wrap:startsWith(searchString)
    return string.sub(self._str, 1, #searchString) == searchString
end

---@param searchString string
---@return boolean
function utf8Wrap:endsWith(searchString)
    return string.sub(self._str, - #searchString) == searchString
end

---@param indexStart number
---@param indexEnd number default(字符串长度)
function utf8Wrap:sub(indexStart, indexEnd)
    return self:substring(indexStart, indexEnd)
end

---@param other any
---@return string
function utf8Wrap:concat(other)
    return self._str .. other
end

function utf8Wrap:len()
    return self.length
end

function utf8Wrap:toString()
    return self._str
end

function utf8Wrap:toLowerCase()
    return string.lower(self._str)
end

function utf8Wrap:toUpperCase()
    return string.upper(self._str)
end

-- 调用了改变字符串的函数，需要调用这个函数重新赋值
---@param s string
function utf8Wrap:refresh(s)
    init(self, s)
    return s
end

return utf8Wrap