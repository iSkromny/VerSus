-- template: versus
-- author: iSkromny




-- Шаблон представляет собой карту, разделённую на 9 частей:
-- две зоны респа: имеют по два проходу в одну из больших зон и по одному проходу в буферную зону
-- буферная зона: соединяет респ и большую зону
-- четыре больших зоны (имеют по два прохода в центр), 
-- одну большую центральную зону.


--  Игрок 1      зона        Игрок 2 
--  
--  красная      респ        белая
--  бирюзовая    буфер       розовая
--  серая       большая      синяя 
--  чёрная      большая2     зелёная
--  жёлтая       центр       жёлтая
-----------------------------------------------
--  серая--<------------бирюзовая--<-----красная(респ)
--  чёрная---------->--\\-жёлтая-\\--<---зелёная
--  белая(респ)------->--розовая----->---синяя
-----------------------------------------------
-- !!!Жёлтой зоны должны касаться зелёная, синяя, серая и чёрная зоны!!!

-- При генерации желательно добиться расстановки, где розовая зона будет располагаться по центру и соединена (визуально) со всеми большими зонами:
-- Наилучшее расположение зон при генерации:
-- -- -- -- 

-- -- -- -- 
-- При несоблюдении расстановки зон может случиться, что из одной из больших зон не будет выхода в центр, тем самым игрок упрётся в тупик.
------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- vars describe subrace types
local Squad0 = { Subrace.Neutral, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, Subrace.NeutralHuman, Subrace.NeutralBarbarian }

local Squad1 = { Subrace.NeutralGreenSkin, Subrace.NeutralBarbarian, Subrace.NeutralMarsh, Subrace.NeutralWolf, Subrace.NeutralElf, Subrace.NeutralHuman }

local Squad2 = { Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralWolf,
                    Subrace.Neutral, Subrace.NeutralBarbarian, Subrace.NeutralWater }

local Squad3 = { Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, 
                    Subrace.Neutral, Subrace.NeutralBarbarian, Subrace.NeutralWater, Subrace.NeutralHuman }

local SquadGO = { Subrace.NeutralDragon, Subrace.NeutralElf,Subrace.NeutralHuman }


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
function getMinesBigZone(race)
    local resourceType = math.random(0, 3)
	local mines = {
		    gold = 1,
	}
	if race == Race.Human then
		mines.lifeMana = 1
		mines.runicMana = 1
		if resourceType == 0 then
			mines.groveMana = 1
		elseif resourceType == 1 then
			mines.infernalMana = 1
		elseif resourceType == 2 then
			mines.deathMana = 1
		elseif resourceType == 3 then
			mines.gold = 2
		end
	elseif race == Race.Dwarf then
		mines.runicMana = 1
		mines.lifeMana = 1
		if resourceType == 0 then
			mines.deathMana = 1
		elseif resourceType == 1 then
			mines.groveMana = 1
		elseif resourceType == 2 then
			mines.infernalMana = 1
		elseif resourceType == 3 then
			mines.gold = 2
		end
	elseif race == Race.Undead then
		mines.deathMana = 1
		mines.infernalMana = 1
		if resourceType == 0 then
			mines.groveMana = 1
		elseif resourceType == 1 then
			mines.runicMana = 1
		elseif resourceType == 2 then
			mines.lifeMana = 1
		elseif resourceType == 3 then
			mines.gold = 2
		end
	elseif race == Race.Heretic then
		mines.infernalMana = 1
		mines.deathMana = 1
		if resourceType == 0 then
			mines.groveMana = 1
		elseif resourceType == 1 then
			mines.runicMana = 1
		elseif resourceType == 2 then
			mines.lifeMana = 1
		elseif resourceType == 3 then
			mines.gold = 2
		end
	elseif race == Race.Elf then
		mines.groveMana = 1
		mines.lifeMana = 1
		if resourceType == 0 then
			mines.runicMana = 1
		elseif resourceType == 1 then
			mines.infernalMana = 1
		elseif resourceType == 2 then
			mines.deathMana = 1
		elseif resourceType == 3 then
			mines.gold = 2
		end
	end

	return mines

end

-- ресурсы в центральной зоне
function getMinesVS()
	local resourceType = math.random(0, 4)
	local mines = {
		gold = 2,
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


local ArtT1 = {'g001ig0071', 'g001ig0611', 'g001ig0418', 'g000ig2001', 'g000ig2002', 'g000ig3001', 'g001ig0100', 'g001ig0182'} -- fарты 
local JewelT1 = {'g001ig0101', 'g000ig4008', 'g000ig3008', 'g001ig0428', 'g000ig4006', 'g001ig0494', 'g000ig4004', 'g001ig0495', 'g001ig0497', 'g000ig4003', 'g000ig4005',
    'g000ig4001', 'g000ig4002', 'g001ig0493'} -- реликвии

----------------------
    -- Отряды в зонах
----------------------
function getStack(tier, stackCount, itemsTable)

    local squadStack = { }
    if (tier == 1 or tier == 2) then
        squadStack = Squad0
    elseif (tier == 3) then
        squadStack = Squad1
    elseif (tier == 4) then
        squadStack = Squad2
    elseif (tier == 5) then
        squadStack = Squad3
    elseif (tier == 6) then
        squadStack = SquadGO
    end

    local expValueStack = { }
    if (tier == 1) then
        expValueStack.min = 240 * stackCount
        expValueStack.max = 290 * stackCount
    elseif (tier == 2) then
        expValueStack.min = 320 * stackCount
        expValueStack.max = 370 * stackCount
    elseif (tier == 3) then
        expValueStack.min = 410 * stackCount
        expValueStack.max = 470 * stackCount
    elseif (tier == 4) then
        expValueStack.min = 700 * stackCount
        expValueStack.max = 780 * stackCount
    elseif (tier == 5) then
        expValueStack.min = 900 * stackCount
        expValueStack.max = 980 * stackCount
    elseif (tier == 6) then
        expValueStack.min = 1190 * stackCount
        expValueStack.max = 1510 * stackCount
    end
    return {
        count = stackCount,
        subraceTypes = squadStack,
        value = expValueStack,
        loot = {
            items = itemsTable
        }
    }
end

----------------------------------------
    -- Отхрана объектов (города, руины)
----------------------------------------
function getGuard(tier, itemsTable)

    local squad = { }
    if (tier == 1 or tier == 2) then
        squad = Squad0
    elseif (tier == 3) then
        squad = Squad1
    elseif (tier == 4) then
        squad = Squad2
    elseif (tier == 5) then
        squad = Squad3
    elseif (tier == 6) then
        squad = SquadGO
    end

    local expValueGuard = { }
    if (tier == 1) then
        expValueGuard.min = 230
        expValueGuard.max = 280
    elseif (tier == 2) then
        expValueGuard.min = 320
        expValueGuard.max = 390
    elseif (tier == 3) then
        expValueGuard.min = 580
        expValueGuard.max = 640
    elseif (tier == 4) then
        expValueGuard.min = 700
        expValueGuard.max = 780
    elseif (tier == 5) then
        expValueGuard.min = 900
        expValueGuard.max = 980
    elseif (tier == 6) then
        expValueGuard.min = 1190
        expValueGuard.max = 1510
    end
    return {
        subraceTypes = squad,
        value = expValueGuard,
        loot = {
            items = itemsTable
        }
    }
end


------------------
  -- Города т1-т5
------------------
function getTown(townTier, getGuard)

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
        townGuard = Squad0
    elseif ( townTier == 2) then
        townGuard = Squad1
    elseif ( townTier == 3) then
        townGuard = Squad2
    elseif ( townTier == 4 or townTier > 4) then
        townGuard = Squad3
    end

    return {
        tier = townTier,
        garrison = {
            subraceTypes = townGuard,
            value = expValue,
            loot = {}
            },
        stack = getGuard
    }

end

------------
  -- Руины
------------
function getRuins(ruinsGold, getGuard, ruinsItem)

    return {
        gold = ruinsGold,
        guard = getGuard,
        loot = {
            items = ruinsItem,
        }
    }
end

----------------
    -- Сундуки
----------------
function getBags(tier, countBags) -- если зона такая-то, то сундуков столько то

    -- local i = 0
    -- local countBags = 0

    -- if tier == 1 then
    --     countBags = countBags + 2
    -- elseif tier == 2 then
    --     countBags = countBags + 3
    -- elseif tier == 3 then
    --     countBags = countBags + 5
    -- elseif tier == 4 then
    --     countBags = countBags + 4
    -- end

    local itemsBags = { }
    if tier == 1 then
        table.insert(itemsBags, { id = 'g000ig0006', min = 1, max = 1 }) -- хил 100
        
    elseif tier == 2 then
        table.insert(itemsBags, { id = 'g000ig0001', min = 1, max = 2 }) -- воскрес
        
    elseif tier == 3 then
        table.insert(itemsBags, { id = 'g000ig0001', min = 0, max = 1 }) -- воскрес
        table.insert(itemsBags, { id = 'g001ig0378', min = 1, max = 3 }) -- хил 75
        
    elseif tier == 4 then
        table.insert(itemsBags, { id = 'g000ig0001', min = 1, max = 2 }) -- воскрес
        table.insert(itemsBags, { id = 'g001ig0378', min = 1, max = 3 }) -- хил 75
        
    end

    return {
            
            count = countBags,
            loot = {
                -- itemTypes = { Item.PotionHeal, Item.Scroll, Item.Orb, Item.PotionBoost },
                -- value = { min = 1400, max = 1800 },
                items = itemsBags,
                -- items = {
                --     { id = 'g000ig0006', min = 1, max = 1 },
                --     { id = 'g000ig0001', min = 0, max = 1 }, -- воскрес
                --     { id = 'g001ig0378', min = 1, max = 3 } -- хил 75
                -- },
                -- itemValue = { min = 100, max = 300 }
            },
        }
    
    
end





----------------------------
-- Описывает стартовую зону
----------------------------
function getStartZone(zoneId, playerRace, zoneSize)

    local StartItem = {
        { id = 'g000ig0001', min = 4, max = 4}, -- res
        { id = 'g000ig0006', min = 4, max = 4}, -- 100hp
        { id = 'g000ig0005', min = 4, max = 4}, -- 50hp
        { id = 'g001ig0180', min = 2, max = 2}, -- 25hp
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
            getStack(1, 7, {}),
            getStack(2, 9, {}),
            getStack(3, 5, {}),
        },
        
        -- Руины в стартовой зоне
        ruins = {
            getRuins({ min = 300, max = 350}, getGuard(1)),
            getRuins({ min = 340, max = 390}, getGuard(2))},

        -- Города в стартовой зоне
        towns = { getTown(1, getGuard(1)), getTown(2, getGuard(2))},

        bags = getBags(2, 3)

        }
end

-------------------------
-- Описывает большую зону
-------------------------
function getBigZone1(zoneId, zoneSize) -- зелёная зона
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone,

        -- отряды
        stacks = {
            getStack(3, 11, {}),
            getStack(4, 9, {}),
            getStack(5, 7, {})
        },

        -- Руины
        ruins = {
            getRuins({ min = 440, max = 490}, getGuard(3)),
            getRuins({ min = 340, max = 390}, getGuard(2))
        },

        -- Лагерь наёмников
        mercenaries = {
            {
            subraceTypes = { Subrace.Neutral, Subrace.NeutralMarsh, Subrace.NeutralWolf, Subrace.NeutralBarbarian },
            value = { min = 300, max = 900 },
            units = {
                    -- {id = 'g006uu1026', level = 2, unique = true}
                },
            guard = getGuard(3)
                }

        },

        -- Лавка торговца 
        merchants = {
            {   goods = {
                    itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
                    value = { min = 8000, max = 9500 }
                }
            }
        },

        -- Башня мага 
        mages = {
            { spellLevel = { min = 2, max = 4 },
               value = { min = 5000, max = 6000 }
            }
        },

        bags = getBags(3, 5),

        -- Города
		towns = { getTown(3, getGuard(3)), getTown(4, getGuard(4))}
	}
end

function getBigZone2(zoneId, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone,

        -- отряды
        stacks = {
            getStack(3, 11, {}),
            getStack(4, 9, {}),
            getStack(5, 7, {})
        },

        -- Руины
        ruins = {
            getRuins({ min = 440, max = 490}, getGuard(3)),
            getRuins({ min = 340, max = 390}, getGuard(2))
        },

        -- Лавка торговца
        merchants = {
            {   goods = {
                    itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
                    value = { min = 8000, max = 9500 }
                }
            }
        },
        -- Тренер
        trainers = {
            guard = getGuard(3)
        },

        -- Башня мага 
        mages = {
            { spellLevel = { min = 2, max = 4 },
               value = { min = 5000, max = 6000 }
            }
        },

        bags = getBags(3, 5),

        -- Города
		towns = { getTown(3, getGuard(3)), getTown(4, getGuard(4))}
	}
end

function getBigZone4(zoneId, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone,

        -- отряды
        stacks = {
            getStack(2, 7, {}),
            getStack(3, 9, {}),
            getStack(4, 7, {}),
            getStack(5, 5, {})
        },

        ruins = {
            getRuins({ min = 340, max = 390}, getGuard(2)),
            getRuins({ min = 440, max = 490}, getGuard(3)),
            getRuins({ min = 590, max = 680}, getGuard(4))
        
        },

        -- Торговец 
        merchants = {
            {   goods = {
                    itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
                    value = { min = 8000, max = 9500 }
                }
            }
        },
        -- Тренер
        trainers = {
            guard = getGuard(3)
        },

        -- Башня мага 
        mages = {
            { spellLevel = { min = 2, max = 4 },
               value = { min = 5000, max = 6000 }
            }
        },

        -- Города
		towns = { getTown(4, getGuard(4)), getTown(4, getGuard(4))}
	}
end

function getBigZone5(zoneId, zoneSize) -- серая
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone,

        -- отряды
        stacks = {
            getStack(2, 7, {}),
            getStack(3, 9, {}),
            getStack(4, 7, {}),
            getStack(5, 5, {})
        },

        ruins = {
            getRuins({ min = 340, max = 390}, getGuard(2)),
            getRuins({ min = 440, max = 490}, getGuard(3)),
            getRuins({ min = 590, max = 680}, getGuard(4))
        },

        -- Лагерь наёмников
        mercenaries = {
            {
            subraceTypes = { Subrace.Neutral, Subrace.NeutralMarsh, Subrace.NeutralWolf, Subrace.NeutralBarbarian },
            value = { min = 300, max = 900 },
            units = {
                    -- {id = 'g006uu1026', level = 2, unique = true}
                },
            guard = getGuard(3)
                }
        },

        -- Торговец 
        merchants = {
            {   goods = {
                    itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
                    value = { min = 8000, max = 9500 }
                }
            }
        },

        -- Башня мага 
        mages = {
            { spellLevel = { min = 2, max = 4 },
               value = { min = 5000, max = 6000 }
            }
        },

        -- Города
		towns = { getTown(4, getGuard(4)), getTown(4, getGuard(4))}
	}
end

--------------------------------------------------
  -- Описывает буферную зону игрока 1
--------------------------------------------------
function getBufferZone1(zoneId, zoneSize)
	return {
		id = zoneId,
		type = Zone.Junction,
		size = zoneSize,
        
        stacks = {
            getStack(3, 5, {})
        },

        -- Торговец 
        merchants = {
            {   goods = {
                    itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
                    value = { min = 8000, max = 9500 }
                }
            },
                guard = getGuard(3)
        },

        ruins = {
            getRuins({ min = 475, max = 525}, getGuard(3))
        },

        bags = getBags(1, 3)
	}
end

--------------------------------------------------
  -- Описывает буферную зону игрока 2
--------------------------------------------------
function getBufferZone2(zoneId, zoneSize)
	return {
		id = zoneId,
		type = Zone.Junction,
		size = zoneSize,
        
        stacks = {
            getStack(3, 5, {})
        },

        -- Торговец 
        merchants = {
            {   goods = {
                    itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
                    value = { min = 8000, max = 9500 }
                }
            },

                guard = getGuard(3)
        },

        ruins = {
            getRuins({ min = 475, max = 525}, getGuard(3))
        },

        bags = getBags(1, 3)
	}
end



-------------------------
-- Описывает центральную зону
-------------------------
function getVSZone(zoneId, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesVS,
        
        -- Stack
        stacks = {
            getStack(2, 7, {}),
            getStack(3, 9, {}),
            getStack(4, 7, {}),
            getStack(5, 5, {})
        },

        -- Ruins
        ruins = {
            getRuins({ min = 920, max = 1100}, getGuard(5)),
            getRuins({ min = 590, max = 680}, getGuard(4)),
            getRuins({ min = 590, max = 680}, getGuard(4))
        },

        -- Merchant
        merchants = {
            {   goods = {
                    itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
                    value = { min = 8000, max = 9500 }
                }
            }
        },

        -- Magic tower
        mages = {
            { spellLevel = { min = 2, max = 4 },
               value = { min = 5000, max = 6000 }
            }
        },
        -- Towns
        towns = { getTown(4, getGuard(4)), getTown(5, getGuard(5))}
	}
end



-- Номера больших зон
local bigZone1Id = 1
local bigZone2Id = 2
local bigZone4Id = 4
local bigZone5Id = 5
-- Номера стартовых зон
local startZone1Id = 0
local startZone2Id = 3
-- Номера буферных зон
local bufferZone1Id = 7
local bufferZone2Id = 8
-- Номер центральной зоны
local VSZoneId = 6


function getZones(races)

	local BigZoneSize = 1200
	local StartZoneSize = 800
	local BufferZoneSize = 600
	local VSZoneSize = 1200

	local zones = {}

	zones[1] = getStartZone(0, races[1], StartZoneSize)  --- красная зона
	zones[2] = getBufferZone1(7, BufferZoneSize)  ---------- бирюзовая зона
	zones[3] = getBigZone5(5, BigZoneSize) ----------------- серая зона
    zones[4] = getBigZone1(1, BigZoneSize) ----------------- зелёная зона
	zones[5] = getVSZone(6, VSZoneSize) -------------------- жёлтая зона
	zones[6] = getBigZone4(4, BigZoneSize) ----------------- чёрная зона
    zones[7] = getBigZone2(2, BigZoneSize)  ---------------- синяя зона
	zones[8] = getBufferZone2(8, BufferZoneSize) ----------- розовая зона
	zones[9] = getStartZone(3, races[2], StartZoneSize) ---- белая зона


	return zones
end

-- Описывает соединение зон
function getConnections()
	return {
		-- Выход с респа 1 в большие зоны
		{ from = 0, to = 1 },
		{ from = 0, to = 1 },
		{ from = 0, to = 7 },

		
        { from = 7, to = 5 },
        { from = 7, to = 5 },
        -- Проходы между 1 большой зоной и центром
		{ from = 1, to = 6 },
        { from = 1, to = 6 },
        -- Проходы между 2 большой зоной и центром
		{ from = 2, to = 6 },
        { from = 2, to = 6 },
        -- Проходы между большими соседними зонами
        -- { from = 1, to = 2 },
        -- { from = 5, to = 4 },

        -- Проходы между 3 большой зоной и центром
        { from = 5, to = 6 },
        { from = 5, to = 6 },
        -- Проходы между 4 большой зоной и центром
        { from = 4, to = 6 },
        { from = 4, to = 6 },
        -- Выход с респа 2 в большие зоны
        { from = 3, to = 4 },
        { from = 3, to = 4 },
        { from = 3, to = 8 },
        
        { from = 8, to = 2 },
        { from = 8, to = 2 }
	}
end

function getTemplateContents(races, scenarioSize)
	return {
		zones = getZones(races),
		connections = getConnections()
	}
end


template = {
	name = 'VerSus',
	description = 'VerSus 0.1 by iSkromny, sMNS 2.0, 72x72, 2 players, two zones to players, 1 zone in the center',
    minSize = 72,
	maxSize = 72,
	maxPlayers = 2,
	roads = 45,
	forest = 40,
	startingGold = 1100,
	
	getContents = getTemplateContents
}
