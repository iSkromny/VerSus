-- template: versus
-- author: iSkromny


-- Шаблон представляет собой карту, разделённую на 8 частей:
-- две зоны респа (имеет по два проходу в каждую из двух смежных больших зон), 
-- четыре больших зоны (имеют по два прохода в центр), 
-- одну большую центральную зону.

-- При генерации желательно добиться расстановки, где розовая зона будет располагаться по центру и соединена (визуально) со всеми большими зонами:
-- Наилучшее расположение зон при генерации:
-- -- -- -- 
-- -- -- -- -- -- -- -- белая/жёлтая смежная зона с респом 1           бирюзовая/синяя смежная зона с респом 2
--                              \       /               \ \             / /         \         / 
-- -- -- -- красная зона, респ игрока 1                 розовая зона центра          серая зона, респ игрока 2     
--                              /       \               / /             \ \         /         \ 
-- -- -- -- -- -- -- -- жёлтая/белая смежная зона с респом 1           синяя/бирюзовая смежная зона с респом 2
-- -- -- -- 
-- При несоблюдении расстановки зон может случиться, что из одной из больших зон не будет выхода в центр, тем самым игрок упрётся в тупик.



-- vars describe subrace types
local Subrace0 = { Subrace.Neutral, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, Subrace.NeutralHuman, Subrace.NeutralBarbarian }
local Subrace1 = { Subrace.NeutralGreenSkin, Subrace.NeutralBarbarian, Subrace.NeutralMarsh, Subrace.NeutralWolf, Subrace.NeutralElf, Subrace.NeutralHuman }
local Subrace2 = { Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralElf, 
                    Subrace.NeutralHuman, Subrace.NeutralBarbarian }
local Subrace3 = { Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralElf, Subrace.NeutralHuman,  Subrace.NeutralMarsh,
                    Subrace.NeutralBarbarian, Subrace.NeutralDragon, Subrace.Neutral }
local SubraceGO = { Subrace.NeutralDragon, Subrace.NeutralElf }


-- Ресурсы на респе
function getStartMines(race)
    local zoneMines = { }
    zoneMines.gold = 2
	if race == Race.Human then
		zoneMines.lifeMana = 2
	elseif race == Race.Dwarf then
		zoneMines.runicMana = 2
	elseif race == Race.Undead then
		zoneMines.deathMana = 2
	elseif race == Race.Heretic then
		zoneMines.infernalMana = 2
	elseif race == Race.Elf then
		zoneMines.groveMana = 2
	end
    return zoneMines
end
-- ресурсы в большой зоне
function getMinesBZ(race)
    local r1 = math.random(0, 3)
	local mines = {
		    gold = 1,
	}
	if race == Race.Human then
		mines.lifeMana = 1
		mines.runicMana = 1
		if r1 == 0 then
			mines.groveMana = 1
		elseif r1 == 1 then
			mines.infernalMana = 1
		elseif r1 == 2 then
			mines.deathMana = 1
		elseif r1 == 3 then
			mines.gold = 2
		end
	elseif race == Race.Dwarf then
		mines.runicMana = 1
		mines.lifeMana = 1
		if r1 == 0 then
			mines.deathMana = 1
		elseif r1 == 1 then
			mines.groveMana = 1
		elseif r1 == 2 then
			mines.infernalMana = 1
		elseif r1 == 3 then
			mines.gold = 2
		end
	elseif race == Race.Undead then
		mines.deathMana = 1
		mines.infernalMana = 1
		if r1 == 0 then
			mines.groveMana = 1
		elseif r1 == 1 then
			mines.runicMana = 1
		elseif r1 == 2 then
			mines.lifeMana = 1
		elseif r1 == 3 then
			mines.gold = 2
		end
	elseif race == Race.Heretic then
		mines.infernalMana = 1
		mines.deathMana = 1
		if r1 == 0 then
			mines.groveMana = 1
		elseif r1 == 1 then
			mines.runicMana = 1
		elseif r1 == 2 then
			mines.lifeMana = 1
		elseif r1 == 3 then
			mines.gold = 2
		end
	elseif race == Race.Elf then
		mines.groveMana = 1
		mines.lifeMana = 1
		if r1 == 0 then
			mines.runicMana = 1
		elseif r1 == 1 then
			mines.infernalMana = 1
		elseif r1 == 2 then
			mines.deathMana = 1
		elseif r1 == 3 then
			mines.gold = 2
		end
	end

	return mines

end

-- ресурсы в центральной зоне
function getMinesVS()
	local resourceType = math.random(0, 4)
	local mines = {
		gold = 1,
	}
	if resourceType == 0 then
		mines.runicMana = 1
	elseif resourceType == 1 then
		mines.lifeMana = 1
	elseif resourceType == 2 then
		mines.deathMana = 1
	elseif resourceType == 3 then
		mines.groveMana = 1
	elseif resourceType == 4 then
		mines.infernalMana = 1
	end
  return mines
end

-- funtion getTown



-- Вернет субрасы которые соответствуют указанной расе
function getNativeSubraces(race)
    if race == Race.Human then
        return { Subrace.Human }
    end
    if race == Race.Dwarf then
        return { Subrace.Dwarf }
    end
    if race == Race.Heretic then
        return { Subrace.Heretic }
    end
    if race == Race.Undead then
        return { Subrace.Undead }
    end
    if race == Race.Elf then
        return { Subrace.Elf }
    end
    return { Subrace.Neutral }
end
-- _______________________________________________________________________________

function ili(x, y)
    local random = math.random(0,1)
    if random == 0 then return x
    elseif random == 1 then return y
    end
end

local ScrollCapital = {'g000ig5098','g000ig5061'} -- свитки энта или скелета для империи
local TalismanCapital = {'g001ig0267', 'g000ig9101', 'g001ig0265', 'g001ig0260', 'g001ig0269', 'g001ig0261', 'g001ig0271', 'g001ig0264', 'g001ig0268', 'g001ig0272', 'g000ig5041'} -- талисманы в стольне
local OrbsWardCapital = {'g001ig0056', 'g001ig0054', 'g001ig0055', 'g001ig0053', 'g001ig0058', 'g001ig0057'} -- сферы защиты отряда
local OrbsCapital = {'g000ig9019', 'g001ig0189', 'g000ig9017', 'g000ig9033', 'g001ig0299', 'g001ig0453', 'g000ig9013', 'g001ig0301', 'g001ig0157', 'g001ig0304', 'g001ig0303', 
    'g001ig0300', 'g001ig0302', 'g000ig9034'} -- сферы урона/исцеления слабые
local smallValuableCapital = {'g000ig7001', 'g001ig0431', 'g000ig7002'} -- драгоценность от 50/75/100


local ArtT1 = {'g001ig0071', 'g001ig0611', 'g001ig0418', 'g000ig2001', 'g000ig2002', 'g000ig3001', 'g001ig0100', 'g001ig0182'}
local JewelT1 = {'g001ig0101', 'g000ig4008', 'g000ig3008', 'g001ig0428', 'g000ig4006', 'g001ig0494', 'g000ig4004', 'g001ig0495', 'g001ig0497', 'g000ig4003', 'g000ig4005', 
    'g000ig4001', 'g000ig4002', 'g001ig0493'}

-- Города т1-т5
function getTown(townTier)
    -- local zoneTown = { }
    local expValue = { }

    if ( townTier == 1 ) then
        expValue.min = 230
        expValue.max = 280
    elseif ( townTier == 2) then
        expValue.min = 320
        expValue.max = 390
    elseif ( townTier == 3) then
        expValue.min = 580
        expValue.max = 640
    elseif ( townTier == 4) then
        expValue.min = 700
        expValue.max = 780
    elseif ( townTier == 5) then
        expValue.min = 1190
        expValue.max = 1610
    end

    local townGuard = { }

    if ( townTier == 1 ) then
        townGuard = Subrace0
    elseif ( townTier == 2) then
        townGuard = Subrace1
    elseif ( townTier == 3) then
        townGuard = Subrace2
    elseif ( townTier == 4 or townTier > 4) then
        townGuard = Subrace3
    end

    return {
        tier = townTier,
        garrison = {
            subraceTypes = townGuard,
            value = expValue,
            loot = {}
            },
        stack = {
            value = { min = 230, max = 260 },
            loot = {}

        }
    }

end

function getRuins(ruinsTier, ruinsGold, ruinsGusrd, ruinsItem)

    return {
        gold = ruinsGold,
        guard = ruinsGusrd,
        loot = {
            items = ruinsItem,
        }
    }
end



-- Описывает стартовую зону
function getStartZone(zoneId, playerRace, zoneSize)

    local StartItem = {
        { id = 'g000ig0001', min = 4, max = 4}, -- res
        { id = 'g000ig0006', min = 4, max = 4}, -- 100hp
        { id = 'g000ig0005', min = 4, max = 4}, -- 50hp
        { id = 'g001ig0180', min = 2, max = 2}, -- 25hp
        { id = 'g001ig0329', min = 1, max = 1}, -- защита от горения
        { id = 'g001ig0327', min = 1, max = 1} -- защита от мороза

    }

    if playerRace == Race.Human then
        table.insert(StartItem, {id = 'g001ig0277', min = 1, max = 1}) -- шар маны жизни 200
        table.insert(StartItem, {id = 'g000ig0024', min = 1, max = 1}) -- защита от огня
        table.insert(StartItem, {id = 'g000ig0023', min = 1, max = 1}) -- защита от земли
        table.insert(StartItem, {id = ScrollCapital[math.random(#ScrollCapital)], min = 1, max = 1}) -- свиток энт малый или скелет
        table.insert(StartItem, {id = TalismanCapital[math.random(#TalismanCapital)], min = 1, max = 1})
        table.insert(StartItem, {id = OrbsCapital[math.random(#OrbsCapital)], min = 1, max = 2})
        table.insert(StartItem, {id = smallValuableCapital[math.random(#smallValuableCapital)], min = 1, max = 1})
    elseif playerRace == Race.Elf then
        table.insert(StartItem, {id = 'g001ig0281', min = 1, max = 1}) -- шар маны лесного элексира 200
        table.insert(StartItem, {id = 'g001ig0036', min = 1, max = 1}) -- защита от смерти
        table.insert(StartItem, {id = 'g000ig0022', min = 1, max = 1}) -- защита от воды
        table.insert(StartItem, {id = TalismanCapital[math.random(#TalismanCapital)], min = 1, max = 1})
        table.insert(StartItem, {id = OrbsCapital[math.random(#OrbsCapital)], min = 1, max = 2})
        table.insert(StartItem, {id = smallValuableCapital[math.random(#smallValuableCapital)], min = 1, max = 1})
    elseif playerRace == Race.Heretic then
        table.insert(StartItem, {id = 'g001ig0278', min = 1, max = 1}) -- шар маны преисподней 200
        table.insert(StartItem, {id = 'g000ig0022', min = 1, max = 1}) -- защита от воды
        table.insert(StartItem, {id = 'g000ig0021', min = 1, max = 1}) -- защита от воздуха
        table.insert(StartItem, {id = TalismanCapital[math.random(#TalismanCapital)], min = 1, max = 1})
        table.insert(StartItem, {id = OrbsCapital[math.random(#OrbsCapital)], min = 1, max = 2})
        table.insert(StartItem, {id = smallValuableCapital[math.random(#smallValuableCapital)], min = 1, max = 1})
    elseif playerRace == Race.Dwarf then
        table.insert(StartItem, {id = 'g001ig0279', min = 1, max = 1}) -- шар маны рун 200
        table.insert(StartItem, {id = 'g000ig0021', min = 1, max = 1}) -- защита от вохдуха
        table.insert(StartItem, {id = 'g001ig0036', min = 1, max = 1}) -- защита от смерти
        table.insert(StartItem, {id = TalismanCapital[math.random(#TalismanCapital)], min = 1, max = 1})
        table.insert(StartItem, {id = OrbsCapital[math.random(#OrbsCapital)], min = 1, max = 2})
        table.insert(StartItem, {id = smallValuableCapital[math.random(#smallValuableCapital)], min = 1, max = 1})
    elseif playerRace == Race.Undead then
        table.insert(StartItem, {id = 'g001ig0280', min = 1, max = 1}) -- шар маны смерти 200
        table.insert(StartItem, {id = 'g000ig0022', min = 1, max = 1}) -- защита от воды
        table.insert(StartItem, {id = 'g000ig0021', min = 1, max = 1}) -- защита от воздуха
        table.insert(StartItem, {id = TalismanCapital[math.random(#TalismanCapital)], min = 1, max = 1})
        table.insert(StartItem, {id = OrbsCapital[math.random(#OrbsCapital)], min = 1, max = 2})
        table.insert(StartItem, {id = smallValuableCapital[math.random(#smallValuableCapital)], min = 1, max = 1})
    end

	return {
		id = zoneId,
		type = Zone.PlayerStart,
		race = playerRace,
		size = zoneSize,

        capital = {
            garrison = {
                value = { min = 50, max = 50 },
                subraceTypes = getNativeSubraces(playerRace),
                
                loot = {
                    itemTypes = { Item.PotionBoost, },
                    value = { min = 450, max = 600 },
                    itemValue = { min = 150, max = 200 },
                    items = StartItem
                
                }
            },
        },
        -- ресурсы респа
        mines = getStartMines(playerRace),

        -- отряды на респе        
        stacks = {
            {
                count = 8,
                value = { min = 1920, max = 2080 },
                subraceTypes = Subrace0
            },
            {
                count = 4,
                value = { min = 1280, max = 4 * 1440 },
                subraceTypes = Subrace1
            }
        },
        
        -- Руины в стартовой зоне
        ruins = {
            getRuins(1, { min = 300, max = 350}, Subrace0, ArtT1)},
        -- }
        
        -- {
        --     {
        --         gold = { min = 300, max = 350 },
        --         loot = {
        --             itemTypes = { Item.Armor },
        --             value = {min = 300, max = 300},
        --             itemValue = {min = 300, max = 300}

        --         },
        --         guard = {
        --             value = { min = 320, max = 380 },
        --             subraceTypes = Subrace1,
        --         }
        --     }
        -- },
        -- Города в стартовой зоне
        towns = { getTown(1), getTown(2)}
    }
end

-- Описывает большую зону
function getBigZone(zoneId, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBZ,
    
        -- отряды
        stacks = {
            {
                subraceTypes = Subrace3,
                count = 10,
                value = { min = 10 * 350, max = 10 * 350 },
                loot = {
                    itemTypes = { Item.Valuable },
                    value = { min = 10 * 600, max = 10 * 600 },
                    itemValue = { min = 10, max = 400 }
                }
                
            },
            -- ещё отряды
            {
                subraceTypes = Subrace3,
                count = 10,
                value = { min = 10 * 500, max = 10 * 500 },
                loot = {
                    itemTypes = { Item.PotionHeal, Item.PotionRevive },
                    value = { min = 10 * 600, max = 10 * 600 }
                }
            }
        },
        
        -- Торговец 
        merchants = {
            {
                goods = {
                    itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
                    value = { min = 8000, max = 9500 }
                }
            }
        },
        
        -- Башня мага 
        mages = {
            {
                spellLevel = { min = 2, max = 4 },
                value = { min = 5000, max = 6000 }
            }
        },
        
        -- Города
		towns = { getTown(3), getTown(4)}
	}
end

-- Описывает буферную зону - дикую и варварскую!

-- function getBufferZone(zoneId, zoneSize)
-- 	return {
-- 		id = zoneId,
-- 		type = Zone.Junction,
-- 		size = zoneSize,
        
--         stacks = {
--             -- 5 отрядов варваров и нейтральных людей, 650 опыта каждый
--             {
--                 count = 5,
--                 value = { min = 5 * 650, max = 5 * 650 },
--                 subraceTypes = { Subrace.NeutralBarbarian, Subrace.NeutralHuman }
--             },
--             -- 5 отрядов зеленокожих, болотных жителей и волков, 500 опыта каждый
--             {
--                 count = 5,
--                 value = { min = 5 * 500, max = 5 * 500 },
--                 subraceTypes = { Subrace.NeutralGreenSkin, Subrace.NeutralMarsh, Subrace.NeutralWolf }
--             }
--         }
-- 	}
-- end


-- Описывает VS зону - дикую и варварскую!

function getVSZone(zoneId, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesVS,
        towns = { getTown(5) },
        stacks = {
            -- 5 отрядов варваров и нейтральных людей, 650 опыта каждый
            {
                count = 10,
                value = { min = 5 * 6500, max = 5 * 6900 },
                subraceTypes = { Subrace3 }
            },
            -- 5 отрядов зеленокожих, болотных жителей и волков, 500 опыта каждый
            {
                count = 10,
                value = { min = 5 * 6500, max = 5 * 6900 },
                subraceTypes = { Subrace3 }
            }
        }
	}
end



-- Номера больших зон
local bigZone1Id = 2
local bigZone2Id = 3
local bigZone3Id = 6
local bigZone4Id = 7
-- Номера стартовых зон
local startZone1Id = 0 -- красная зона
local startZone2Id = 5 -- серая зона
-- Номера буферных зон
local bufferZone1Id = 1
local bufferZone2Id = 4
-- Номер главной зоны
local VSZoneId = 8


function getZones(races)

	local BigZoneSize = 1200
	local StartZoneSize = 800
	-- local BufferZoneSize = 600
	local VSZoneSize = 1200

	local zones = {}

	zones[1] = getStartZone(0, races[1], StartZoneSize)   -- 
	zones[2] = getBigZone(1, BigZoneSize) --
    zones[3] = getBigZone(2, BigZoneSize) -- 
	zones[4] = getVSZone(6, VSZoneSize) --
	zones[5] = getBigZone(5, BigZoneSize)
    zones[6] = getBigZone(4, BigZoneSize)  -- 
	zones[7] = getStartZone(3, races[2], StartZoneSize) -- 


	return zones
end

-- Описывает соединение зон
function getConnections()
	return {
		-- Выход с респа 1 в большие зоны
		{ from = 0, to = 1 },
        { from = 0, to = 1 },
        { from = 0, to = 5 },
        { from = 0, to = 5 },
        -- Проходы между 1 большой зоной и центром
		{ from = 1, to = 6 },
        { from = 1, to = 6 },
        -- Проходы между 2 большой зоной и центром
		{ from = 2, to = 6 },
        { from = 2, to = 6 },
        -- Проходы между большими соседними зонами
        { from = 1, to = 2 },
        { from = 5, to = 4 },

        -- Проходы между 3 большой зоной и центром
        { from = 5, to = 6 },
        { from = 5, to = 6 },
        -- Проходы между 4 большой зоной и центром
        { from = 4, to = 6 },
        { from = 4, to = 6 },
        -- Выход с респа 2 в большие зоны
        { from = 3, to = 2 },
        { from = 3, to = 2 },
        { from = 3, to = 4 },
        { from = 3, to = 4 }
	}
end

-- Описывает содержимое которое будет генерироваться на карте сценария
function getTemplateContents(races, scenarioSize)
	return {
        -- Зоны зависят от выбранных игроком рас.
        -- В зависимости от расы будут выбраны нужные типы источников маны в стартовых зонах
		zones = getZones(races),
		connections = getConnections()
	}
end

-- Это основное описание шаблона.
-- Все функции, включая getTemplateContents могут быть названы как удобно автору шаблона
-- и принимать любые параметры по его усмотрению.
-- Задача шаблона показать относительно простой пример карты для 2 игроков.
-- Не судите баланс отрядов и наград строго - я не PvP игрок,
-- а шаблон рассчитан быть работоспособным для любого из модов и ванильной игры.
-- Хороший и сбалансированный PvP шаблон должен учитывать особенности мода, ценности юнитов и предметов.
template = {
	name = 'VerSus',
    -- Краткая информация для игрока чего ждать от игры на этом шаблоне.
	description = 'VerSus 0.1 by iSkromny, sMNS 2.0, 72x72, 2 players, two zones to players, 1 zone in the center',
	-- Для простоты этот пример рассчитан лишь на карты размером 72 х 72
    minSize = 72,
	maxSize = 72,
    -- На карте всегда 2 игрока
	maxPlayers = 2,
	roads = 45,
	forest = 40,
	startingGold = 1100,
	
	getContents = getTemplateContents
}
