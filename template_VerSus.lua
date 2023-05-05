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
--  чёрная---------->--\\-жёлтая-\\--<---зелёная--/
--  --\белая(респ)----->--розовая----->---синяя
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

local Squad4 = { 'g001uu7593','g001uu7555','g000uu6001','g000uu7503','g000uu8195','g000uu8153','g001uu8259','g006uu1016','g001uu7541','g001uu7601','g001uu8298','g001uu7585'} 

local SquadGO = { Subrace.NeutralDragon, Squad4 }
--------------------
-- Ресурсы на респе
--------------------
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

-----------------------------
    -- ресурсы в большой зоне
-----------------------------
function getMinesBigZone(race)
    local resourceType = math.random(0, 2)
	local mines = {
		    gold = 2,
	}
	if race == Race.Human then
		mines.lifeMana = 1
		mines.groveMana = 1
		if resourceType == 0 then
			mines.runicMana = 1
		elseif resourceType == 1 then
			mines.infernalMana = 1
		elseif resourceType == 2 then
			mines.deathMana = 1
		end

	elseif race == Race.Dwarf then
		mines.runicMana = 1
		mines.lifeMana = 1
		if resourceType == 0 then
			mines.deathMana = 1
		elseif resourceType == 1 then
			mines.infernalMana = 1
		elseif resourceType == 2 then
			mines.groveMana = 1
		end

	elseif race == Race.Undead then
		mines.deathMana = 1
		mines.groveMana = 1
		if resourceType == 0 then
			mines.runicMana = 1
		elseif resourceType == 1 then
			mines.infernalMana = 1
		elseif resourceType == 2 then
			mines.lifeMana = 1
		end

	elseif race == Race.Heretic then
		mines.infernalMana = 1
        mines.runicMana = 1
		if resourceType == 0 then
			mines.groveMana = 1
		elseif resourceType == 1 then
			mines.lifeMana = 1
		elseif resourceType == 2 then
			mines.deathMana = 1
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
		end
	end
    return mines

end
----------------------------------
    -- ресурсы в центральной зоне
----------------------------------
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

-------------------------------
    -- ресурсы в буферной зоне
-------------------------------
function getMinesBufferZone(race)
	local resourceType = math.random(0, 2)
	local mines = {
		    gold = 1,
	}
	if race == Race.Human then
		if resourceType == 0 then
			mines.runicMana = 1
		elseif resourceType == 1 then
			mines.infernalMana = 1
		elseif resourceType == 2 then
			mines.deathMana = 1
		end
	elseif race == Race.Dwarf then
		if resourceType == 0 then
			mines.deathMana = 1
		elseif resourceType == 1 then
			mines.infernalMana = 1
		elseif resourceType == 2 then
			mines.groveMana = 1
		end
	elseif race == Race.Undead then
		if resourceType == 0 then
			mines.runicMana = 1
		elseif resourceType == 1 then
			mines.infernalMana = 1
		elseif resourceType == 2 then
			mines.lifeMana = 1
		end
	elseif race == Race.Heretic then
		if resourceType == 0 then
			mines.groveMana = 1
		elseif resourceType == 1 then
			mines.lifeMana = 1
		elseif resourceType == 2 then
			mines.deathMana = 1
		end
	elseif race == Race.Elf then
		if resourceType == 0 then
			mines.runicMana = 1
		elseif resourceType == 1 then
			mines.infernalMana = 1
		elseif resourceType == 2 then
			mines.deathMana = 1
		end
	end
    return mines
end


-----------------------------------------------------------
    -- Вернет субрасы которые соответствуют указанной расе
-----------------------------------------------------------
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


------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------
    -- Функция или
-------------------    
function ili(x, y)
    local random = math.random(0,1)
    if random == 0 then 
        return x
    elseif random == 1 then 
        return y
    end
end


-------------------
    -- Переменные
-------------------  
-- свитки энта или скелета для империи
local ScrollCapital = { 'g000ig5098','g000ig5061' }

-- зелья защиты в стольне
local ElexirProtection = { 'g001ig0349', 'g001ig0329', 'g001ig0343', 'g000ig0022', 'g000ig0021', 'g000ig0023', 'g000ig0024', 'g001ig0125', 'g001ig0036', 'g001ig0327', 'g001ig0345', 'g001ig0335',
                                    'g001ig0337', 'g001ig0347', 'g001ig0339', 'g001ig0353', 'g001ig0341', 'g001ig0351', 'g001ig0331'} 

local Elexir = { 'g000ig0014', 'g000ig0008', 'g000ig0011', 'g000ig0002', 'g001ig0127', 'g001ig0490', 'g001ig0560', 'g001ig0547' }
local Elexirt2 = { 'g000ig0009', 'g000ig0012', 'g000ig0015', 'g001ig0491', 'g001ig0562', 'g000ig0003' }

local ElexirPermanent = { 'g000ig0010', 'g000ig0007', 'g001ig0309', 'g000ig0016', 'g000ig0013', 'g001ig0313', 'g000ig0004', 'g001ig0311', 'g001ig0307', 'g001ig0532', 'g001ig0315',
                            'g001ig0034' }
local ElexirPermanentT2 = { 'g001ig0308', 'g001ig0516', 'g001ig0533', 'g001ig0316', 'g000ig0007', 'g001ig0314', 'g001ig0310', 'g001ig0312', 'g001ig0130', 'g001ig0534', 'g001ig0561', 'g001ig0523' }

-- талисманы в стольне
local Talismant1 = {
    'g001ig0260', -- трибог 150
    'g001ig0269', -- разбойник 150
    'g001ig0261',  -- энт малый 150
    'g001ig0271',  -- гоблин жгун 150
    'g001ig0268',  -- псина
    'g001ig0272' -- эльф-следопыт 150 
    }
local Talismant2 = {
    'g001ig0267', -- одержимый 
    'g000ig9107', -- зомби 350
    'g001ig0265', -- гном 200
    'g001ig0264',  -- воин 200
    'g001ig0082', -- гоблины на всё поле 275
    'g001ig0262', -- skelet 250
    'g001ig0266', -- kentavr-kopeyschik 200
    'g000ig9114', -- ork 350
    'g000ig9101' -- skwayr
    }

-- сферы защиты отряда -- проверил
-- local OrbsWardCapital = { 'g001ig0056', 'g001ig0054', 'g001ig0055', 'g001ig0053', 'g001ig0058', 'g001ig0057' }

-- сферы урона/исцеления слабые -- проверил
local OrbsCapital = { 'g000ig9019', 'g001ig0189', 'g000ig9017', 'g000ig9033', 'g001ig0299', 'g001ig0453', 'g000ig9013', 'g001ig0301', 'g001ig0304', 'g001ig0303',
                        'g001ig0300', 'g001ig0302', 'g000ig9034' }

-- сферы в сундуках -- проверил все
local weakOrbs = { 'g001ig0476', 'g000ig9024', 'g001ig0471', 'g000ig9031', 'g001ig0470', 'g001ig0464', 'g001ig0456', 'g001ig0458', 'g001ig0466', 'g001ig0457', 'g001ig0192', 
                        'g001ig0191', 'g001ig0478', 'g001ig0489', 'g001ig0446', 'g001ig0475', 'g001ig0187', 'g001ig0469', 'g000ig9022', 'g001ig0468', 'g001ig0480', 'g001ig0188', 
                        'g001ig0190', 'g001ig0448', 'g000ig9036', 'g001ig0467' }
local mediumOrbs = { 'g000ig9005', 'g000ig9002', 'g000ig9015', 'g000ig9003', 'g000ig9010', 'g001ig0455', 'g001ig0472', 'g001ig0454', 'g001ig0473', 'g001ig0474', 'g001ig0479', 'g000ig9029',
                            'g000ig9016', 'g001ig0444', 'g001ig0459', 'g001ig0450', 'g000ig9042', 'g000ig9041', 'g001ig0461', 'g001ig0183', 'g001ig0477', 'g000ig9038', 'g000ig9020' }
local strongOrbs = { 'g001ig0445', 'g001ig0451', 'g001ig0449', 'g000ig9014', 'g001ig0447', 'g001ig0462', 'g001ig0441', 'g000ig9043' }


-- драгоценность  50/75/100
local smallValuable = { 'g000ig7001', 'g001ig0431', 'g000ig7002' }
-- драгоценность 125/150/175/200
local mediumValuable = { 'g001ig0433', 'g001ig0432', 'g000ig7004', 'g000ig7003' }
-- драгоценность 350/400/250
local bigValuable = { 'g000ig7007', 'g000ig7008', 'g000ig7005', 'g000ig7006' }

--  шары маны 50
local smallballmana = { 'g001ig0481', 'g001ig0485', 'g001ig0482', 'g001ig0483', 'g001ig0484', 'g001ig0486' }
-- шары маны 100
local mediumballmana = { 'g001ig0146', 'g001ig0150', 'g001ig0147', 'g001ig0148', 'g001ig0149', 'g001ig0151' }
-- шары маны 200
local bigballmana = { 'g001ig0277', 'g001ig0281', 'g001ig0278', 'g001ig0279', 'g001ig0280', 'g001ig0282' }

-- артефакты -- проверил все
local ArtT1 = { 'g001ig0071', 'g001ig0611', 'g001ig0418', 'g000ig2001', 'g000ig2002', 'g000ig3001', 'g001ig0100', 'g001ig0182' }
local ArtT2 = { 'g001ig0582', 'g001ig0558', 'g001ig0557', 'g001ig0559', 'g001ig0594', 'g000ig3002', 'g000ig3017', 'g001ig0487' }
local ArtT3 = { 'g001ig0048', 'g001ig0155', 'g001ig0042', 'g001ig0045', 'g000ig2003', 'g001ig0040', 'g001ig0047', 'g001ig0416', 'g001ig0589', 'g001ig0591', 'g000ig3003',
                    'g001ig0173', 'g001ig0417', 'g001ig0196' }
local ArtT4 = { 'g001ig0124', 'g001ig0612', 'g001ig0585', 'g001ig0046', 'g001ig0592', 'g001ig0040', 'g000ig2004', 'g001ig0044', 'g001ig0060', 'g001ig0041', 'g001ig0590',
                    'g001ig0071', 'g001ig0174', 'g001ig0411', 'g000ig3019', 'g000ig3006', 'g001ig0488', 'g001ig0413', 'g001ig0415', 'g000ig3004', 'g000ig9137', 'g000ig9035', 'g001ig0197' }
local ArtT5 = { 'g001ig0179', 'g001ig0410', 'g000ig3018', 'g000ig3007', 'g001ig0102', 'g001ig0412', 'g001ig0414', 'g000ig2005', 'g001ig0604', 'g001ig0039', 'g001ig0043' }

-- реликвии -- проверил все
local JewelT1 = { 'g001ig0101', 'g000ig4008', 'g000ig3008', 'g001ig0428', 'g000ig4006', 'g001ig0494', 'g000ig4004', 'g001ig0495', 'g001ig0497', 'g000ig4003', 'g000ig4005',
                    'g000ig4001', 'g000ig4002', 'g001ig0493' }
local JewelT2 = { 'g001ig0421', 'g001ig0420', 'g001ig0422', 'g001ig0423', 'g000ig4007', 'g001ig0427', 'g001ig0099', 'g001ig0430', 'g001ig0539', 'g000ig3020' }
local JewelT3 = { 'g001ig0037', 'g001ig0424', 'g001ig0425', 'g001ig0597', 'g000ig3022', 'g001ig0610', 'g001ig0156' }
local JewelT4 = { 'g001ig0104', 'g001ig0605', 'g000ig7010', 'g000ig3005', 'g001ig0596', 'g001ig0429', 'g001ig0116', 'g001ig0038','g001ig0419' }

-- знамёна -- проверил все
local BannerT1 = { 'g000ig1005', 'g001ig0051', 'g000ig1001', 'g001ig0587', 'g000ig1007', 'g000ig1003' }
local BannerT2 = { 'g001ig0293', 'g000ig1004', 'g001ig0362', 'g001ig0361', 'g001ig0289', 'g001ig0142', 'g001ig0140', 'g001ig0141', 'g001ig0139', 'g001ig0145', 'g001ig0143', 'g001ig0370',
                    'g001ig0357', 'g000ig1002', 'g001ig0358', 'g000ig1006', 'g001ig0588', 'g000ig1008', 'g001ig0292' }
local BannerT3 = { 'g001ig0364', 'g000ig1016', 'g000ig1017', 'g001ig0373', 'g001ig0375', 'g001ig0359', 'g001ig0363', 'g001ig0500', 'g001ig0372', 'g001ig0369', 'g001ig0374', 'g000ig1015',
                    'g001ig0365', 'g001ig0290', 'g001ig0367', }
local BannerT4 = { 'g001ig0153', 'g001ig0144', 'g001ig0368', 'g001ig0052', 'g001ig0366', 'g001ig0360', 'g001ig0291' }

-- Сапоги -- проверил
local TravelT1 = { 'g001ig0108', 'g001ig0107', 'g001ig0105', 'g001ig0109', 'g001ig0106', 'g001ig0113', 'g000ig1010', 'g000ig8003' }
local TravelT2 = { 'g001ig0114', 'g001ig0606', 'g000ig8004', 'g001ig0050' }
local TravelT3 = { 'g001ig0115', 'g001ig0112', 'g001ig0111', }

-- Посохи -- проверил
local wand = { 'g000ig6007', 'g000ig6006', 'g001ig0392', 'g001ig0391', 'g000ig6003', 'g001ig0399', 'g000ig6012', 'g000ig6001', 'g001ig0401', 'g001ig0394', 'g001ig0397', 'g001ig0402',
                'g000ig6020', 'g000ig6015', }


function getReward(Type, Zone)

    local rewardItems = { }

    if Type == 'town' and Zone == 'StartZonet1' then
        table.insert(rewardItems, { id = 'g000ig0005', min = 3, max = 4 } ) -- heal 50
        table.insert(rewardItems, { id = smallValuable[math.random(#smallValuable)], min = 1, max = 2 } ) -- valuable 50/75/100
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 3 } ) -- 
        table.insert(rewardItems, { id = wand[math.random(#wand)], min = 1, max = 1 } ) --
        table.insert(rewardItems, { id = Talismant1[math.random(#Talismant1)], min = 1, max = 1 } )

    elseif Type == 'town' and Zone == 'StartZonet2' then
        table.insert(rewardItems, { id = 'g000ig0001', min = 1, max = 2 } ) -- res
        table.insert(rewardItems, { id = 'g001ig0378', min = 1, max = 2 } ) -- heal 75
        table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 3 } ) -- heal 100
        table.insert(rewardItems, { id = smallballmana[math.random(#smallballmana)], min = 1, max = 1 } ) -- 50 mana
        table.insert(rewardItems, { id = ArtT1[math.random(#ArtT1)], min = 1, max = 1 } ) -- heal 100
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } ) -- heal 100
        table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1 } ) -- valuable 125/150/175/200

    elseif Type == 'town' and Zone == 'BigZonet3' then
        table.insert(rewardItems, { id = 'g000ig0001', min = 1, max = 2 } ) -- res
        table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 3 } ) -- heal 75
        table.insert(rewardItems, { id = 'g000ig0006', min = 3, max = 3 } ) -- heal 100
        table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
        table.insert(rewardItems, { id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1 } ) -- 100 mana
        table.insert(rewardItems, { id = JewelT2[math.random(#JewelT2)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } ) -- 
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 2, max = 3 } ) -- 
        table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1 } ) -- valuable 125/150/175/200

    elseif Type == 'town' and Zone == 'BigZonet4' then
        table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res
        table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 3 } ) -- heal 75
        table.insert(rewardItems, { id = 'g000ig0006', min = 3, max = 3 } ) -- heal 100
        table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
        table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } ) -- 200 mana
        table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = bigValuable[math.random(#bigValuable)], min = 1, max = 1 } ) -- valuable 250/400
        table.insert(rewardItems, { id = TravelT3[math.random(#TravelT3)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = Talismant2[math.random(#Talismant2)], min = 1, max = 1 } )


    elseif Type == 'town' and Zone == 'VSZonet4' then
        table.insert(rewardItems, { id = 'g000ig0006', min = 3, max = 3 } ) -- heal 100
        table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
        table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } ) -- 200 mana
        table.insert(rewardItems, { id = JewelT4[math.random(#JewelT4)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 2 } ) -- 
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 3 } ) -- 
        table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 3 } ) -- 


    elseif Type == 'town' and Zone == 'VSZonet5' then
        table.insert(rewardItems, { id = 'g001ig0152', min = 2, max = 3 } ) -- heal 300
        table.insert(rewardItems, { id = 'g000ig0006', min = 3, max = 3 } ) -- heal 100
        table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
        table.insert(rewardItems, { id = ArtT5[math.random(#ArtT5)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = BannerT4[math.random(#BannerT4)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 3 } ) -- 
        table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 3 } ) --
        table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 2 } ) -- 


    -- elseif Typeobject == 'merchants' and Zoneobject == 'StartZonet1' then

    elseif Type == 'ruins' and Zone == 'StartZonet1' then
        table.insert(rewardItems, { id = TravelT1[math.random(#TravelT1)], min = 1, max = 1 } )
    elseif Type == 'ruins' and Zone == 'StartZonet2' then
        table.insert(rewardItems, { id = BannerT1[math.random(#BannerT1)], min = 1, max = 1 } )
    elseif Type == 'ruins' and Zone == 'bufferZone' then
        table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
    elseif Type == 'riuns' and Zone == 'BigZonet3' then
        table.insert(rewardItems, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1 } )
    elseif Type == 'riuns' and Zone == 'BigZonet4' then
        table.insert(rewardItems, { id = BannerT3[math.random(#BannerT3)], min = 1, max = 1 } )

    elseif Type == 'riuns' and Zone == 'BigZonet4.1' then
        table.insert(rewardItems, { id = ArtT3[math.random(#ArtT3)], min = 1, max = 1 } )
    elseif Type == 'riuns' and Zone == 'BigZonet4.2' then
        table.insert(rewardItems, { id = ArtT4[math.random(#ArtT4)], min = 1, max = 1 } )

    elseif Type == 'guard' and Zone == 'bufferZone' then
        table.insert(rewardItems, { id = JewelT1[math.random(#JewelT1)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = wand[math.random(#wand)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res  
        table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 3 } ) -- heal 75
        table.insert(rewardItems, { id = 'g001ig0486', min = 1, max = 1 } ) -- mana 50 all
    elseif Type == 'guard' and Zone == 'BigZone14' then
        table.insert(rewardItems, ili( { id = TravelT2[math.random(#TravelT2)], min = 1, max = 1 }, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1 } ) )
        table.insert(rewardItems, { id = 'g000ig0001', min = 1, max = 1 } ) -- res  
        table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 2 } ) -- heal 75
        table.insert(rewardItems, { id = 'g000ig0006', min = 1, max = 1 } ) -- heal 100
    elseif Type == 'guard' and Zone == 'BigZone25' then
        table.insert(rewardItems, ili( { id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 }, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1 } ) )
        table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res  
        table.insert(rewardItems, { id = 'g000ig0018', min = 1, max = 2 } ) -- heal 200
        table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    elseif Type == 'guard' and Zone == 'GO' then
        table.insert(rewardItems, ili ( { id = ArtT4[math.random(#ArtT4)], min = 1, max = 1 }, { id = ArtT5[math.random(#ArtT5)], min = 1, max = 1 } ) )
        table.insert(rewardItems, ili ( { id = BannerT4[math.random(#BannerT4)], min = 1, max = 1 }, { id = JewelT4[math.random(#JewelT4)], min = 1, max = 1 } ) )
        table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res
        table.insert(rewardItems, { id = 'g001ig0152', min = 2, max = 2 } ) -- heal 300
        table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 2 } ) 

    elseif Type == 'bags' and Zone == 'BigZone' then
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 2, max = 3 } )
        table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 2, max = 3 } )
        table.insert(rewardItems, { id = 'g000ig0001', min = 4, max = 4 } ) -- res
        table.insert(rewardItems, { id = 'g001ig0378', min = 3, max = 4 } ) -- хил 75
        table.insert(rewardItems, { id = 'g000ig0006', min = 4, max = 5 } ) -- хил 100
        table.insert(rewardItems, { id = 'g000ig0018', min = 3, max = 4 } ) -- хил 200
        table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 2, max = 3 } )
        table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 2 } )
        table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 3, max = 3 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 3, max = 4 } ) -- 









    end

    return rewardItems
end

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
    end

    local expValueStack = { }
    if (tier == 1) then
        expValueStack.min = 150 * stackCount
        expValueStack.max = 220 * stackCount
    elseif (tier == 2) then
        expValueStack.min = 220 * stackCount
        expValueStack.max = 290 * stackCount
    elseif (tier == 3) then
        expValueStack.min = 420 * stackCount
        expValueStack.max = 510 * stackCount
    elseif (tier == 4) then
        expValueStack.min = 600 * stackCount
        expValueStack.max = 780 * stackCount
    elseif (tier == 5) then
        expValueStack.min = 800 * stackCount
        expValueStack.max = 1140 * stackCount
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

------------------------------------------------
    -- Отхрана объектов (города, руины, проходы)
------------------------------------------------
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
        expValueGuard.min = 210
        expValueGuard.max = 290
    elseif (tier == 2) then
        expValueGuard.min = 320
        expValueGuard.max = 420
    elseif (tier == 3) then
        expValueGuard.min = 540
        expValueGuard.max = 690
    elseif (tier == 4) then
        expValueGuard.min = 650
        expValueGuard.max = 780
    elseif (tier == 5) then
        expValueGuard.min = 800
        expValueGuard.max = 1090
    elseif (tier == 6) then
        expValueGuard.min = 1100
        expValueGuard.max = 1750
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
function getTown(townTier, getGuard, itemsTable)

    local expValue = { }
    if ( townTier == 1 ) then
        expValue.min = 190
        expValue.max = 240
    elseif ( townTier == 2) then
        expValue.min = 320
        expValue.max = 390
    elseif ( townTier == 3) then
        expValue.min = 540
        expValue.max = 670
    elseif ( townTier == 4) then
        expValue.min = 610
        expValue.max = 720
    elseif ( townTier == 5) then
        expValue.min = 710
        expValue.max = 920
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
            loot = {
                items = itemsTable
            }
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
function getBags(countBags, itemsBags)
    return {
            count = countBags,
            loot = {
                items = itemsBags,
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
        table.insert(StartItem, {id = ScrollCapital[math.random(#ScrollCapital)], min = 1, max = 1}) -- свиток энт малый или скелет
        table.insert(StartItem, {id = OrbsCapital[math.random(#OrbsCapital)], min = 1, max = 2})
        table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1}) 
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    elseif playerRace == Race.Elf then
        table.insert(StartItem, {id = 'g001ig0281', min = 1, max = 1}) -- шар маны лесного элексира 200
        table.insert(StartItem, {id = OrbsCapital[math.random(#OrbsCapital)], min = 1, max = 2})
        table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    elseif playerRace == Race.Heretic then
        table.insert(StartItem, {id = 'g001ig0278', min = 1, max = 1}) -- шар маны преисподней 200
        table.insert(StartItem, {id = OrbsCapital[math.random(#OrbsCapital)], min = 1, max = 2})
        table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    elseif playerRace == Race.Dwarf then
        table.insert(StartItem, {id = 'g001ig0279', min = 1, max = 1}) -- шар маны рун 200
        table.insert(StartItem, {id = OrbsCapital[math.random(#OrbsCapital)], min = 1, max = 2})
        table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    elseif playerRace == Race.Undead then
        table.insert(StartItem, {id = 'g001ig0280', min = 1, max = 1}) -- шар маны смерти 200
        table.insert(StartItem, {id = OrbsCapital[math.random(#OrbsCapital)], min = 1, max = 2})
        table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    end

	return {
		id = zoneId,
		type = Zone.PlayerStart,
		race = playerRace,
		size = zoneSize,

        -- Столица
        capital = {
            garrison = {
                value = { min = 50, max = 50 },
                subraceTypes = getNativeSubraces(playerRace),
                loot = {
                    items = StartItem
                }
            },
        },
        -- ресурсы респа
        mines = getStartMines(playerRace),

        -- отряды на респе        
        stacks = {
            getStack( 1, 7, {} ),
            getStack( 2, 8, {} ),
            -- getStack(3, 5, {}),
            },
        
        -- Руины в стартовой зоне
        ruins = {
            getRuins({ min = 210, max = 249}, getGuard(1), getReward('ruins', 'StartZonet1') ),
            getRuins({ min = 239, max = 280}, getGuard(2), getReward('ruins', 'StartZonet2'))
            },

        -- Города в стартовой зоне
        towns = { 
                getTown(1, getGuard(1), getReward('town', 'StartZonet1')),
                getTown(2, getGuard(2), getReward('town', 'StartZonet2'))
            },

        bags = getBags( 3, {} )

        }
end

----------------------------------------------------
-- Описывает смежнуюю большую зону игрока 1 с респом
----------------------------------------------------
function getBigZone1(zoneId, playerRace, zoneSize) --
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone(playerRace),

        -- отряды
        stacks = {
            getStack( 3, 8, {} ),
            getStack( 4, 8, {} ),
            getStack( 5, 6, {} )
        },

        -- Руины
        ruins = {
            getRuins( { min = 365, max = 415 }, getGuard(4), getReward('ruins', 'BigZonet4.1') ),
            getRuins( { min = 365, max = 415 }, getGuard(4), getReward('ruins', 'BigZonet4.2') )
        },

        -- Лагерь наёмников
        mercenaries = {
            {
            subraceTypes = { Subrace.Neutral, Subrace.NeutralMarsh, Subrace.NeutralWolf, Subrace.NeutralBarbarian },
            value = { min = 300, max = 900 },
            -- units = {
            --         -- {id = 'g000uu5007', level = 1, unique = true} -- кентавр 140/90/300 хп опыт найм
            --         -- {id = 'g000uu5005', level = 1, unique = true} -- лесной эльф 100/55/240
            --         -- {id = 'g000uu5013', level = 2, unique = true} --  орк 200/70/300
            --         -- {id = 'g000uu5003', level = 2, unique = true} -- копейшик 140/55/300
            --         -- {id = 'g000uu5002', level = 2, unique = true} -- ополченец 95/20/50
            --         -- {id = 'g000uu5030', level = 2, unique = true} -- разбойник 65/30/40
            --         -- {id = 'g000uu5028', level = 2, unique = true} -- тритон 140/80/300
            --         -- {id = 'g000uu5039', level = 2, unique = true} -- волк 180/90/300
            --         -- {id = 'g006uu1030', level = 2, unique = true} --  псина 90/25/150
            --         -- {id = 'g001uu8279', level = 2, unique = true} --  чумной волк 185/94/315
            --         -- {id = 'g000uu5030', level = 2, unique = true} --  

            --     },
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

        bags = getBags( 3, 7, getReward('bags', 'BigZone') ),

        -- Города
		towns = { 
            getTown( 4, getGuard(4), getReward('town', 'BigZonet4') ),
            getTown( 4, getGuard(4), getReward('town', 'BigZonet4') )
        }
	}
end

----------------------------------
-- Описывает большую зону игрока 2
----------------------------------
function getBigZone2(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone(playerRace),

        -- Oтряды
        stacks = {
            getStack( 3, 5, {} ),
            getStack( 4, 8, {} ),
            getStack( 5, 8, {} )
        },

        -- Руины
        ruins = {
            getRuins( { min = 320, max = 370}, getGuard(3), getReward('ruins', 'BigZonet3') ),
            getRuins( { min = 365, max = 415}, getGuard(4), getReward('ruins', 'BigZonet4') )
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
            {
            guard = getGuard(3)
            }
        },

        -- Башня мага 
        mages = {
            { spellLevel = { min = 2, max = 4 },
               value = { min = 5000, max = 6000 }
            }
        },

        bags = getBags( 3, 7, getReward('bags', 'BigZone') ),

        -- Города
		towns = { 
            getTown( 3, getGuard(3), getReward('town', 'BigZonet3') ),
            getTown( 4, getGuard(4), getReward('town', 'BigZonet4') )
            }
	}
end

----------------------------------------------------
-- Описывает смежнуюю большую зону игрока 2 с респом
----------------------------------------------------
function getBigZone4(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone(playerRace),

        -- отряды
        stacks = {
            getStack( 3, 8, {} ),
            getStack( 4, 8, {} ),
            getStack( 5, 6, {} )
        },

        -- Руины
        ruins = {
            getRuins( { min = 365, max = 415}, getGuard(4), getReward('ruins', 'BigZonet4.1') ),
            getRuins( { min = 365, max = 415}, getGuard(4), getReward('ruins', 'BigZonet4.2') )
        },

        -- Лагерь наёмников
        mercenaries = {
            {
            subraceTypes = { Subrace.Neutral, Subrace.NeutralMarsh, Subrace.NeutralWolf, Subrace.NeutralBarbarian },
            value = { min = 300, max = 900 },
            -- units = {
            --         -- {id = 'g006uu1026', level = 2, unique = true}
            --     },
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

        bags = getBags( 3, 7, getReward('bags', 'BigZone') ),

        -- Города
		towns = { 
            getTown( 4, getGuard(4), getReward('town', 'BigZonet4') ), 
            getTown( 4, getGuard(4), getReward('town', 'BigZonet4') )
            }
	}
end

----------------------------------
-- Описывает большую зону игрока 1
----------------------------------
function getBigZone5(zoneId, playerRace, zoneSize) -- серая
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone(playerRace),

        -- отряды
        stacks = {
            getStack( 3, 5, {} ),
            getStack( 4, 8, {} ),
            getStack( 5, 8, {} )
        },

        -- Руины
        ruins = {
            getRuins( { min = 320, max = 370}, getGuard(3), getReward('ruins', 'BigZonet3') ),
            getRuins( { min = 365, max = 415}, getGuard(4), getReward('ruins', 'BigZonet4') )
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
            {
            guard = getGuard(3)
            }

        },

        -- Башня мага 
        mages = {
            { spellLevel = { min = 2, max = 4 },
               value = { min = 5000, max = 6000 }
            }
        },

        bags = getBags( 3, 7, getReward('bags', 'BigZone') ),

        -- Города
		towns = { 
            getTown( 3, getGuard(3), getReward('town', 'BigZonet3') ),
            getTown( 4, getGuard(4), getReward('town', 'BigZonet4') )
        }
	}
end

--------------------------------------------------
  -- Описывает буферную зону игрока 1
--------------------------------------------------
function getBufferZone1(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Junction,
		size = zoneSize,
        mines = getMinesBufferZone(playerRace),
        stacks = {
            getStack( 2, 5, {} ),
            getStack( 3, 5, {} )
        },

        -- Торговец 
        merchants = {
            {   goods = {
                    itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
                    value = { min = 8000, max = 9500 }
                }
            },
                guard = getGuard( 3 )
        },

         -- Башня мага 
        mages = {
            { spellLevel = { min = 2, max = 4 },
               value = { min = 5000, max = 6000 }
            },
            guard = getGuard( 3 )
        },

        ruins = {
            getRuins ( { min = 320, max = 350}, getGuard(3), getReward('ruins', 'bufferZone') ),
        },

        bags = getBags( 3, {} )
	}
end

--------------------------------------------------
  -- Описывает буферную зону игрока 2
--------------------------------------------------
function getBufferZone2(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Junction,
		size = zoneSize,
        mines = getMinesBufferZone(playerRace),
 
        -- Отряды
        stacks = {
            getStack( 2, 5, {} ),
            getStack( 3, 5, {} )
        },

        -- Торговец 
        merchants = {
            {   goods = {
                    itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
                    value = { min = 8000, max = 9500 }
                    }
            },
                guard = getGuard( 3 )
        },

         -- Башня мага 
        mages = {
            { spellLevel = { min = 2, max = 4 },
               value = { min = 5000, max = 6000 }
            },
            guard = getGuard( 3 )
        },

        -- Руины
        ruins = {
            getRuins({ min = 320, max = 350}, getGuard(3), getReward('ruins', 'bufferZone') ),
        },

        bags = getBags( 3, {} )
	}
end



-----------------------------
-- Описывает центральную зону
-----------------------------
function getVSZone(zoneId, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesVS(),
        
        -- Stack
        stacks = {
            getStack( 3, 7, {} ),
            getStack( 4, 9, {} ),
            getStack( 5, 6, {} )
        },

        -- Ruins
        ruins = {
            getRuins( { min = 920, max = 1100}, getGuard(5), getReward('ruins', 'BigZonet4') ),
            getRuins( { min = 590, max = 680}, getGuard(4), getReward('ruins', 'BigZonet4') ),
            getRuins( { min = 590, max = 680}, getGuard(4), getReward('ruins', 'BigZonet4') )
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
        towns = { 
            getTown( 4, getGuard(4), getReward('town', 'VSZonet4') ), 
            getTown( 5, getGuard(5), getReward('town', 'VSZonet5') )
            }
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

	local BigZoneSize = 1000
	local StartZoneSize = 800
	local BufferZoneSize = 600
	local VSZoneSize = 1200

	local zones = {}

	zones[1] = getStartZone(0, races[1], StartZoneSize)  --- красная зона
	zones[2] = getBufferZone1(7, races[1], BufferZoneSize)  ---------- бирюзовая зона
	zones[3] = getBigZone5(5, races[1], BigZoneSize) ----------------- серая зона
    zones[4] = getBigZone1(1, races[1], BigZoneSize) ----------------- зелёная зона
	zones[5] = getVSZone(6, VSZoneSize) -------------------- жёлтая зона
	zones[6] = getBigZone4(4, races[2], BigZoneSize) ----------------- чёрная зона
    zones[7] = getBigZone2(2, races[2], BigZoneSize)  ---------------- синяя зона
	zones[8] = getBufferZone2(8, races[2], BufferZoneSize) ----------- розовая зона
	zones[9] = getStartZone(3, races[2], StartZoneSize) ---- белая зона


	return zones
end

-- Описывает соединение зон
function getConnections()
	return {
		-- Выход с респа 1 в большие зоны
		{ from = 0, to = 1, guard = getGuard( 2, getReward('guard', 'BigZone14') ) },
		{ from = 0, to = 7, guard = getGuard( 2, getReward('guard', 'bufferZone') ) },
		-- Выход из буфера в большую зону
        { from = 7, to = 5, guard = getGuard( 3, getReward('guard', 'BigZone25') ) },
        -- Проходы между 1 большой зоной и центром
		{ from = 1, to = 6, guard = getGuard( 6, {} ) },
        { from = 1, to = 6, guard = getGuard( 6, {} ) },
        -- Проходы между 2 большой зоной и центром
		{ from = 2, to = 6, guard = getGuard( 6, {} ) },
        { from = 2, to = 6, guard = getGuard( 6, {} ) },
        -- Проходы между большими соседними зонами
        -- { from = 1, to = 2 },
        -- { from = 5, to = 4 },

        -- Проходы между 3 большой зоной и центром
        { from = 5, to = 6, guard = getGuard( 6, {} ) },
        { from = 5, to = 6, guard = getGuard (6, {} ) },
        -- Проходы между 4 большой зоной и центром
        { from = 4, to = 6, guard = getGuard( 6, {} ) },
        { from = 4, to = 6, guard = getGuard( 6, {} ) },
         -- Выход из буфера в большую зону
        { from = 8, to = 2, guard = getReward( 3, getReward('guard', 'BigZone25') ) },
        -- Выход с респа 2 в большие зоны
        { from = 3, to = 4, guard = getGuard( 2, getReward('guard', 'BigZone14') ) },
        { from = 3, to = 8, guard = getGuard( 2, getReward('guard', 'bufferZone') ) }
       
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
	startingGold = 1000,
	
	getContents = getTemplateContents
}
