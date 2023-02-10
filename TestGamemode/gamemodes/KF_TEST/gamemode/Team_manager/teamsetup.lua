local ply = FindMetaTable("Player") -- присвоить значение переменной ply = таблицу из функции FindMetaTable("Player") с аргуметом Player

local teams = {} -- пустая таблица

teams[0] = {
    name = "First",
    color = Vector( 1.0, 0, 0 ),
    weapons = {"weapon_crowbar"} 
} -- новый ключь с аргументами
teams[1] = {
    name = "Two",
    color = Vector( 0, 0, 1.0 ),
    weapons = {"weapon_crossbow", "weapon_revolver"} 
} -- новый ключь с аргументами

-- ply:SetupTeam - добовляет в таблицу :Team - из этой ячейки можно извликать данные

function ply:SetupTeam( n ) -- в n функция получает оргумент из другой функции; n это будует индекс
    if ( not teams[n] ) then return end -- вернуть ничего или вернуть значение из таблицы в функцию выше

    self:SetTeam( n ) -- номер таблицы в переменной n
    self:SetPlayerColor( teams[n].color ) -- присвоить значение из таблицы
    self:SetHealth ( 100 )
    self:SetMaxHealth( 100 )
    self:SetWalkSpeed( 150 )
    self:SetRunSpeed( 220 )
    self:SetModel( "models/player/Group01/male_0" .. math.random(1, 9) .. ".mdl" )

    self:GiveWeapons( n ) 
end
--[[
    n - будет индексом, поступает из файла init
    Попросту говоря, чтобы не путатся в данных и аргументах, надо знать назначение таблицы
]]

function ply:GiveWeapons( n )
    for k, weapon in pairs( teams[n].weapons ) do
        self:Give( weapon )
    end
end
