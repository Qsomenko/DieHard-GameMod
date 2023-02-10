-- New!

--[[
    bool(логический) тип данных:
]]
bool = true -- 
-- пример:

if( bool == false ) then
    -- same code

end
-- __________________________________
--[[
    Цифровой тип данных:
]]
number = 100 -- 
number2 = number/2
-- пример в функции:

if( number > number2 ) then
    -- code
end
-- __________________________________
--[[
    Tекстовый тип данных:
]]
str = "Same String" -- 
str2 = "Text"
str3 = str .. str2 .. " is here"
-- пример в функции:
if( str == "That" ) then
    
    -- code

end
-- __________________________________
--[[
    Tип данных таблица:
]]
local tables = {} 
tables[1] = "Hey!"
tables[2] = "Bad"
tables[32] = "Sol"
--
tablesTest = { bool, number, float, str, tablse }
--
tables1 = {
    [1] = "best",
    [2] = "Ana",
    [3] = "Bot",
}
tables1["string"] = "ball" -- добовление индекста с аргументом
tables1.color = "red" 
for k, v in pairs(tables1) do -- перебор таблицы
    print(k .. " == " .. v)
end
--
vec = Vector( 10, 20, 30 )
vec:Add( Vector( 1, 2, 3 ) )

resultant = Vector( 11, 22, 33)
-- __________________________________
--[[
    Gmod Classes:
    Data type
]]

-- Класс игрок:
ply:KillSilentPIst()
ply:SetHealth()
ply:Frags()
ply:Ping()

-- Класс entities:
entities:GetOwner()

-- Класс panel:
panel:SetHeight( 60 )
--[[
    Разминочка:
]]

for i = 1, 10 do
    print( i )
end 
--
while number < 120 do
    number = number + 1
end
