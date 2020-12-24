-- lua版本的javascript Array.prototype.function
-- python list function
-- 所有函数第一个参数类型都必须是充当数组的table ==> any[]
---@class Arrays
local Arrays = {}

-- 默认比较函数
local function _cmp(a, b)
    return a - b
end

-- 负索引转正
---@param array any[]
---@param index number
---@return number
local function _n2p(array, index)
    return index < 0 and (#array + index + 1) or index
end

-- js Array function

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
    first = _n2p(array, first)
    last = last or #array
    last = _n2p(array, last)
    for i = first, last, (first < last and 1 or -1) do
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
    fromIndex = _n2p(array, fromIndex)
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
    fromIndex = _n2p(array, fromIndex)
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
    fromIndex = _n2p(array, fromIndex)
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
    first = _n2p(array, first)
    last = last or #array
    last = _n2p(array, last)
    for i = first, last, (first < last and 1 or -1) do
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

-- python list function

---@param array any[]
---@param value any
function Arrays.append(array, value)
    table.insert(array, value)
end

---@param array any[]
---@param value any
---@return number
function Arrays.count(array, value)
    local cnt = 0
    for _, v in ipairs(array) do
        cnt = cnt + (v == value and 1 or 0)
    end
    return cnt
end

---@param array any[]
---@param other any[]
function Arrays.extend(array, other)
    for _, v in ipairs(other) do
        table.insert(array, v)
    end
end

-- 已经存在了同名函数
-- function Arrays.pop(array, index)
--     -- body
-- end

---@param array any[]
---@param obj any
function Arrays.remove(array, obj)
    for i, v in ipairs(array) do
        if obj == v then
            table.remove(array, i)
            return
        end
    end
end

---@param array any[]
---@param v any
---@param start number
---@param endPos number
function Arrays.index(array, v, start, endPos)
    start = start or 1
    start = _n2p(array, start)
    endPos = endPos or #array
    endPos = _n2p(array, endPos)
    for i = start, endPos, (start < endPos and 1 or -1) do
        if v == array[i] then
            return i
        end
    end
    return -1
end

---@param array any[]
function Arrays.clear(array)
    for i = #array, 1, -1 do
        table.remove(array, i)
    end
end

---@param array any[]
---@return any[]
function Arrays.copy(array)
    local res = {}
    for _, v in ipairs(array) do
        table.insert(array, v)
    end
    return res
end

-- 自定义 新增

---@param array any[]
---@param predicate function
function Arrays.removeIf(array, predicate)
    for i = #array, 1, -1 do
        if predicate(array[i]) then
            table.remove(array, i)
        end
    end 
end

---@param array any[]
---@param cmp function
---@return any
function Arrays.min(array, cmp)
    cmp = cmp or _cmp
    local min = array[1]
    for i = 2, #array do
        if cmp(array[i], min) < 0 then
            min = array[i]
        end
    end
    return min
end

---@param array any[]
---@param cmp function
---@return any
function Arrays.max(array, cmp)
    cmp = cmp or _cmp
    local max = array[1]
    for i = 2, #array do
        if cmp(array[i], max) > 0 then
            max = array[i]
        end
    end
    return max
end

---@param array any[]
---@param v any
---@param cmp function
---@return number
function Arrays.binarySearch(array, v, cmp)
    cmp = cmp or _cmp
    local first, last = 1, #array
    while first <= last do
        local mid = math.floor((first + last) / 2)
        if array[mid] < v then
            first = mid + 1
        elseif array[mid] > v then
            last = mid - 1
        else
            return mid
        end
    end
    return -1
end

---@param array any[]
---@param first number
---@param last number
---@return ...
function Arrays.unpack(array, first, last)
    return table.unpack(array, first, last)
end

return Arrays