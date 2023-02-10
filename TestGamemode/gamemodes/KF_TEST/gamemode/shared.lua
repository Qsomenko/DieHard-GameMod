GM.Name = "BestGameMode"
GM.Author = "SolBadGuy"
GM.Email = "stolikki.klanov@mail.ru"
GM.Website = "N/A"

team.SetUp( 0, "First", Color( 255, 0, 0))
team.SetUp( 1, "Two", Color( 0, 0, 255))

function GM:Initialize() -- не нужно использовать hook(крючки) для функционирования этой функции
    --[[
        GM: - это посути как hook(крючек)
        hook.Add("Initialize", "NameHook", function())
    ]]
    self.BaseClass.Initialize(self)
    print("Gamemode запущен полностью")
end
-- GM:Initialize работает в процессе загруски карты (под самый конец)