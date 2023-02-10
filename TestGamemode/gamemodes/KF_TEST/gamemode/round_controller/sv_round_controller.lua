-- ниже создаем локаольную переменную и присваиваем ей значение 0
local round_status = 0 -- 0 = end, 1 = active
local activeRound = 1
-- переменны лучше держать вначале кода
local t = 0 --- t это time
local interval = 2
local zombieCount = 3
local isSpawning = false

local spawnPos = {
    Vector(-370, 210, -270),
    Vector(-420, 350, -350),
    Vector(-1110, 1400, -1250),
}

util.AddNetworkString("UpdateRoundStatus")
-- Функция "Запуска раунда":
function beginRound() -- глобальная функция, как и некоторые другие ниже
    round_status = 1
    updateClientRoundStatus() -- вызов функции - updateClientRoundStatus() для обновления данных на клиенте

    isSpawning = true -- когда (активируется функция beginRound()) стартует раунд, происходит спавн зомбей

end
-- глобальные функции видны в других файлах 
-- Функция окончания раунда:
function endRound()
    round_status = 0
    updateClientRoundStatus()
end

function getRoundStatus() -- возвращаем в функцию значение из локальной переменной round_status
return  round_status
end

local nextWaveWaiting = false
--[[
function getBestSpawn()

    local bestSpawn = Vector(0, 0, 0)
    local closestDistance = 0
    
    for k, v in pairs(spawnPos) do
        
        local closestZombieDistance = 100000

        for a, b in pairs(ents.FindByClass("npc_zobie")) do
            if b: GetPos():Distance(v) < closestZombieDistance then
                closestZombieDistance = b:GetPos():Distance(v)
            end
        end

    end


end
]]


hook.Add("Think", "WoveThink", function() -- крючек "Think" - переводится "думай"
    
    if round_status == 1 and isSpawning == true then -- ключивой момент, если значение переменной равно 1, то начинаются события
        
        nextWaveWaiting = false 

        if t < CurTime() then -- функция CurTime дает время сервера

            t = CurTime() + interval

            player:GetAll()[1]:ChatPrint("A Zombie spawning")
            -- chat.AddText("A Zombie spawning") - функция не будет работать, потому что без аргументов

            local temp =ents.Create("npc_zombie") -- temp - можно другое название
            temp:SetPos( spawnPos[math.random(1, table.Count(spawnPos))] ) -- случайный индекс/ключь тамблицы с аргементом
            temp:Spawn()
            temp:SetHealth(50 * activeRound) -- увелечение здровья с каждым раундом

            zombieCount = zombieCount - 1 -- вычитаем значение 

            if zombieCount <= 0 then -- когда значение zombieCount равно или меньше ноля, то спавн останавливается
                
                isSpawning = false

            end
            
        end

    end

   if round_status == 1 and isSpawning == false and table.Count(ents.FindByClass("npc_zombie")) == 0 and nextWaveWaiting == false then
        activeRound = activeRound + 1
        
        nextWaveWaiting = true

        timer.Simple( 10, function()

            zombieCount = 3 * activeRound 
            isSpawning = true

        end)


     end -- table.Count(ents.FindByClass("npc_zombie")) - скольок зомбей активны

end)

function  updateClientRoundStatus() -- посылаем на клиет данные из переменной round_status, на клиенте такая же переменная локальная
    --[[
    -- Можно использовать такой вариант для передачы данных клиентам
    for k, v in pairs(player.GetAll()) for 
    -- code
    end
    ]]
    -- а вот с использованием библиотеки util.:
    net.Start("UpdateRoundStatus")
        net.WriteInt(round_status, 4)
    net.Broadcast()

end