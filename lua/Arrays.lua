-- ==> hugo suu
-- lua版本的javascript Array.prototype.function
-- 所有函数第一个参数类型都必须是充当数组的table ==> any[]
---@class Arrays
local Arrays = {}

-- 多个数组合并成新数组
---@param array any[]
---other any[]
---@return any[]
function Arrays.concat(array, ...)
    local res = {}
    for _, v in ipairs(array) do
        table.insert(res, v)
    end
    for _, arr in ipairs({ ... }) do
        for _, v in ipairs(arr) do
            table.insert(res, v)
        end
    end
    return res
end

---@param array any[]
---@param func function
function Arrays.forEach(array, func)
    for i, v in ipairs(array) do
        func(v, i, array)
    end
end

---@param array any[]
---@param predicate function
---@return boolean
function Arrays.every(array, predicate)
    for _, v in ipairs(array) do
        if not predicate(v) then
            return false
        end
    end
    return true
end

---@param array any[]
---@param predicate function
---@return boolean
function Arrays.some(array, predicate)
    for _, v in ipairs(array) do
        if predicate(v) then
            return true
        end
    end
    return false
end

---@param array any[]
---@param predicate function
---@return any[]
function Arrays.filter(array, predicate)
    local res = {}
    for _, v in ipairs(array) do
        if predicate(v) then
            table.insert(res, v)
        end
    end
    return res
end

---@param array any[]
---@param func function
---@return any[]
function Arrays.map(array, func)
    local res = {}
    for _, v in ipairs(array) do
        table.insert(res, func(v))
    end
    return res
end

---@param array any[]
---@param reducer function
---@param initValue any 可选参数，默认为数组第一个值
---@return any
function Arrays.reduce(array, reducer, initValue)
    local hasInitVal = (initValue ~= nil)
    local value = hasInitVal and initValue or array[1]
    for i = (hasInitVal and 1 or 2), #array do
        value = reducer(value, array[i])
    end
    return value
end

---@param array any[]
---@param reducer function
---@param initValue any 可选参数，默认为数组最后一个元素的值
---@return any
function Arrays.reduceRight(array, reducer, initValue)
    local hasInitVal = (initValue ~= nil)
    local value = hasInitVal and initValue or array[#array]
    for i = (hasInitVal and #array or #array - 1), 1, -1 do
        value = reducer(value, array[i])
    end
    return value
end

---@param array any[]
---@return any[]
function Arrays.reverse(array)
    local l, r = 1, #array
    while l < r do
        array[l], array[r] = array[r], array[l]
        l = l + 1
        r = r - 1
    end
    return array
end

---@param array any[]
---@param first number 可选参数，默认为1
---@param last number  可选参数，默认为数组长度(包含边界)
---@return any[]
function Arrays.slice(array, first, last)
    local res = {}
    first = first or 1
    last = last or #array
    for i = first, last do
        table.insert(res, array[i])
    end
    return res
end

---@param array any[]
---@param value any
---@param fromIndex number 可选参数，默认为1
---@return boolean
function Arrays.includes(array, value, fromIndex)
    fromIndex = fromIndex or 1
    for i = fromIndex, #array do
        if array[i] == value then
            return true
        end
    end
    return false
end

---@param array any[]
---@param value any
---@param fromIndex number 可选参数，默认为1
---@return number
function Arrays.indexOf(array, value, fromIndex)
    fromIndex = fromIndex or 1
    for i = fromIndex, #array do
        if array[i] == value then
            return i
        end
    end
    return -1
end

---@param array any[]
---@param value any
---@param fromIndex number 可选参数，默认为数组长度
---@return number
function Arrays.lastIndexOf(array, value, fromIndex)
    fromIndex = fromIndex or #array
    for i = fromIndex, 1, -1 do
        if array[i] == value then
            return i
        end
    end
    return -1
end

---@param array any[]
---@param value any
---@param first number 可选参数，默认为1
---@param last number 可选参数，默认为数组长度
---@return any[]
function Arrays.fill(array, value, first, last)
    first = first or 1
    last = last or #array
    for i = first, last do
        array[i] = value
    end
    return array
end

---@param array any[]
---other any[]
---@return number
function Arrays.push(array, ...)
    for _, v in ipairs({ ... }) do
        table.insert(array, v)
    end
    return #array
end

---@param array any[]
---@return any
function Arrays.pop(array)
    local res = array[#array]
    table.remove(array, #array)
    return res
end

---@param array any[]
---@return any
function Arrays.shift(array)
    local res = array[1]
    table.remove(array, 1)
    return res
end

---@param array any[]
---other ...any
---@return number
function Arrays.unshift(array, ...)
    local t = { ... }
    for i = #t, 1, -1 do
        table.insert(array, 1, t[i])
    end
    return #array
end

---@param array any[]
---@param predicate function
---@return any | nil
function Arrays.find(array, predicate)
    for _, v in ipairs(array) do
        if predicate(v) then
            return v
        end
    end
end

---@param array any[]
---@param predicate function
---@return number
function Arrays.findIndex(array, predicate)
    for i, v in ipairs(array) do
        if predicate(v) then
            return i
        end
    end
    return -1
end

---@param array any[]
---@param separator string
---@return string
function Arrays.join(array, separator)
    separator = separator or ','
    return table.concat(array, separator)
end

---@param array any[]
---@param func function
function Arrays.sort(array, func)
    table.sort(array, func)
end

---@param array any[]
---@param start number
---@param deleteCount number
---other ... any
---@return any[]
function Arrays.splice(array, start, deleteCount, ...)
    local res = {}
    start = start or 1
    deleteCount = deleteCount or 0
    while deleteCount > 0 do
        table.insert(res, array[start])
        table.remove(array, start)
        deleteCount = deleteCount - 1
    end
    local t = { ... }
    for i = #t, 1, -1 do
        table.insert(array, start, t[i])
    end
    return res
end

return Arrays