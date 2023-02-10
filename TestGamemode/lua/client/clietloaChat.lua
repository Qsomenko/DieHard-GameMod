print('Chat loa loading')

local notify = {} -- пустая таблица

net.Receive( "notify", function() 
    
    local tbl = table.Copy( notify ) -- очищение таблицы при помощи пустой таблицы

    table.Add( tbl, net.ReadTable() ) -- читаем таблицу( дополняем таблицу значением)

    chat.AddText( unpack( tbl ) ) --  chat.AddText(распаковка (таблицы))

end)
