local round_status = 0

net.Receive("UpdateRoundStatus", function (len)
    round_status = net.ReadInt(4) -- присвоить в переменную round_status значение из передачи данных с другого файла
end)

function getRoundStatus()
    
   return round_status -- функция получение данных из локальной переменной

end