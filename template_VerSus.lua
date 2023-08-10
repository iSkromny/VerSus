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

-- При генерации желательно добиться расстановки, где жёлтая зона будет располагаться по центру и соединена (визуально) со всеми большими зонами:
-- Наилучшее расположение зон при генерации:
-----------------------------------------------
--  серая--<------------бирюзовая--<-----красная(респ)
--  чёрная---------->--\\-жёлтая-\\--<---зелёная--/
--  --\белая(респ)----->--розовая----->---синяя
-----------------------------------------------
-- !!!Жёлтой зоны должны касаться зелёная, синяя, серая и чёрная зоны!!!
-- -- -- -- 
-- При несоблюдении расстановки зон может случиться, что из одной из больших зон не будет выхода в центр, тем самым игрок упрётся в тупик.
------------------------------------------------------------------------------------------------------------------------------------------------------------------
local kf = 1 -- коэффициент усиления отрядов

-- 
local Squad1 = { Subrace.Neutral, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, Subrace.NeutralHuman, Subrace.NeutralBarbarian }

local Squad2 = { Subrace.NeutralGreenSkin, Subrace.NeutralBarbarian, Subrace.NeutralMarsh, Subrace.NeutralWolf, Subrace.NeutralElf, Subrace.NeutralHuman, Subrace.Neutral }

local Squad3 = { Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralWolf,
                    Subrace.Neutral, Subrace.NeutralBarbarian, Subrace.NeutralWater }

local Squad4 = { Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, 
                    Subrace.Neutral, Subrace.NeutralBarbarian, Subrace.NeutralWater, Subrace.NeutralHuman, Subrace.NeutralElf }

local SquadGO = { Subrace.NeutralDragon, Subrace.NeutralMarsh, Subrace.Neutral, Subrace.NeutralHuman }
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
        mines.infernalMana = 1
		if resourceType == 0 then
			mines.runicMana = 1
		elseif resourceType == 1 then
            mines.groveMana = 1
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
        mines.deathMana = 1
		if resourceType == 0 then
			mines.runicMana = 1
		elseif resourceType == 1 then
			mines.infernalMana = 1
		elseif resourceType == 2 then
            mines.lifeMana = 1
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
local ElexirProtection = { 
    'g001ig0331', -- poison protection          150
    'g001ig0345', -- oslab protection           150
    'g001ig0341', -- strah protection           150
    'g001ig0329', -- goren protection           150
    'g001ig0343', -- zaml protection            150
    'g001ig0327', -- moroz protection           200
    'g001ig0335', -- okamen protection          200
    'g001ig0337', -- paral protection           200
    'g001ig0347', -- -lvl protection            200
    'g001ig0339', -- prevras protection         200
    'g001ig0353', -- razrush protection         200
    'g001ig0351', -- taumat protection          200
    'g001ig0349', -- vamp protection            200
    'g000ig0022', -- water protection           250
    'g000ig0021', -- air protection             250
    'g000ig0023', -- earth protection           250
    'g000ig0024', -- fire protection            250
    'g001ig0125', -- mind protection            250
    'g001ig0036', -- death protection           250

} 

local Elexir = { -- 1100-1900 value 150-300
    'g000ig0014', -- +15%dmg                    150
    'g000ig0008', -- +15%acc                    150
    'g000ig0011', -- +15%ini                    150
    'g000ig0002', -- +10arm                     150
    'g001ig0560', -- +25% prinyat udar          200
    'g001ig0547' -- +15%krit                    300
}      
local Elexirt2 = { -- 4275-6475 value 350-700
    'g000ig0009', -- +30%acc                    350
    'g001ig0490', -- +25% hp for day            350
    'g000ig0012', -- +30%ini                    425
    'g000ig0015', -- +30%dmg                    425
    'g001ig0491', -- +25% vamp                  500
    'g001ig0127', -- +50hp                      500
    'g001ig0562', -- +30%krit                   500
    'g000ig0003', -- +20arm                     525
    'g001ig0355', -- damage protection          600
    'g000ig0017', -- +30arm                     700
    'g001ig0129' -- 50% vamp                    700

}

local ElexirPermanent = { -- 6050value 200-550
    'g001ig0532', -- +1review                   200
    'g001ig0313', -- +5%dmg                     400
    'g001ig0311', -- +5%acc                     400
    'g001ig0307', -- +5%arm                     400
    'g001ig0315', -- +5%hp                      400
    'g001ig0534', -- -75% voskres i lecheniya   400
    'g001ig0533', -- +2 rewiev                  400
    'g001ig0309', -- +5%ini                     400
    'g001ig0317', -- +15%vamp                   400
    'g001ig0519', -- +10 resist voram           500
    'g000ig0010', -- +10%acc                    500
    'g001ig0516', -- -10%exp                    500
    'g001ig0316', -- +15%hp                     500
    'g000ig0007', -- +15%hp                     500
    'g000ig0013', -- +10%ini                    500
    'g000ig0016', -- +10%dmg                    550
    
}

    local ElexirPermanentT2 = { -- 6700value 600-1200
    'g001ig0561', -- +25% udar na sebya         600
    'g001ig0523', -- +10%exp                    600 
    
    'g000ig0004', -- +10arm                     600
    'g001ig0130', -- 22%regen                   700
    'g001ig0548', -- +10%krit                   700
    'g001ig0018', -- +5%regen                   750
    'g001ig0536', -- ataka zdorovyem            850
    'g001ig0376', -- +30% regen                 1000
    'g001ig0518', -- -15%exp                    1000
    'g001ig0521', -- +20 resist voram           1000
    'g001ig0318', -- +25%vamp                   1200
    'g001ig0308', -- 15arm                      1200
    'g001ig0314', -- +15%dmg                    1200
    'g001ig0310', -- +15ini                     1200
    'g001ig0312', -- +15acc                     1200
    
}

local AuraPermanent = {
    --all
    'g001ig0026', -- aura +5%regen -15%hp       300
    'g001ig0027', -- aura +5arm -15%(7.5)hp     700
    'g001ig0563', -- aura +5%krit -15%(7.5%)    600
    'g001ig0028', -- aura +5%hp -15%            600
    'g001ig0034', -- 10hp otryad                600
    'g001ig0031', -- aura +5%acc -15%hp         400
    'g001ig0029', -- aura +5%dmg -15%hp         600
    'g001ig0030', -- aura +5%ini -15%hp         600
    'g001ig0033', -- aura +5hp                  400
    'g001ig0564', -- aura +5%krit -10%hp        600
    'g001ig0017', -- aura +5%regen -10%hp       600
    'g001ig0024', -- aura +5%arm -10%hp         800
    'g001ig0021', -- aura +5%dmg -10%hp         800
    'g001ig0023', -- aura +5%ini -10%hp         800
    'g001ig0022', -- aura +5acc -10%hp          550

    'g001ig0025', -- aura +5%hp all -10%hp      850
    'g001ig0019', -- aura vampirizm +10%        900
    'g001ig0032', -- aura +5%hp                 1000
    --'g001ig0016', -- aura ward weapon -25%hp    1800  -- magazin
    --'g001ig0565', -- aura +5% krit              1800  -- magazin
}

local Permanentskill = {
    'g001ig0530', -- talisman                   600
    'g001ig0527', -- taynoe znanie              600
    'g001ig0531', -- chtenie pergamentov        600
    'g001ig0525', -- znanie art                 600
    'g001ig0524', -- wand                       600
    'g001ig0529', -- znanie sfer                600
    'g001ig0526', -- znamenosec                 600
    'g001ig0501', -- hod po lesu                600
    -- 'g001ig0522', -- nepodkupnost               1500 -- magazin
}

local ProtectPermanent = {
    'g001ig0330', -- ward ot goreniya           500
    'g001ig0346', -- ward ot oslab              500
    'g001ig0348', -- ward ponijenie urovnya     500
    'g001ig0344', -- ward ot zamedl             500
    'g001ig0342', -- ward ot straha             500
    'g001ig0328', -- ward moroz                 500
    'g001ig0332', -- ward poison                500
    'g001ig0352', -- ward taumaturgiya          600
    'g001ig0323', -- ward ot fire               600
    'g001ig0322', -- ward earth                 600
    'g001ig0321', -- ward air                   600
    'g001ig0325', -- ward mind                  600
    'g001ig0326', -- ward death                 600
    'g001ig0320', -- ward water                 600
    'g001ig0350', -- ward ot vamp               600
    'g001ig0354', -- ward ot razrusheniya       600
    'g001ig0338', -- ward ot paralicha          700
    'g001ig0340', -- ward ot prevrascheniya     700
    'g001ig0336', -- ward ot okamen             700
    'g001ig0324', -- ward weapon                800
    -- 'g001ig0356', -- ward uron                  1000  -- magazin

}

local AuraPermanentProtect = {
    'g001ig0009', -- aura ward mind -15%hp      950
    'g001ig0011', -- aura ward death -15%hp     950
    'g001ig0012', -- aura ward fire -15%hp      950
    'g001ig0013', -- aura ward water -15%hp     950
    'g001ig0014', -- aura ward earth -15%hp     950
    'g001ig0015', -- aura ward air -15%hp       950
    
    
    
}

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
    'g000ig9101' -- сквайр
    }


	local scroll = {
        'g001ig0407', -- призыв толстого беса на 2 дня                                      100
        'g000ig5022', -- обычно ходит по лесу                                               100
        'g000ig5002', -- +10%ini                                                            150
        'g000ig5106', -- -10%ini                                                            150
        'g001ig0248', -- -10%ini                                                            150
        'g000ig5023', -- +10%dmg                                                            150
        'g000ig5003', -- +10%dmg                                                            150
        'g000ig5101', -- -10%dmg                                                            150
        'g000ig5064', -- -5%ini -5%dmg                                                      150
        'g000ig5045', -- -10arm                                                             150
        'g000ig5065', -- -10arm                                                             150
        'g001ig0252', -- -15arm                                                             150
        'g000ig5024', -- 15 magic damage                                                    150
        'g000ig5043', -- 15 magic damage                                                    150
        'g000ig5044', -- 15 magic damage                                                    150
        'g000ig5063', -- 15 magic damage                                                    150
        'g000ig5042', -- fantom gonchey                                                     150
        'g000ig5041', -- gonchaya                                                           150
        'g000ig5097', -- 15 magic damage                                                    150
        'g000ig5004', -- 15 magic damage                                                    150
        'g000ig5062', -- 15 magic damage                                                    150
        'g001ig0247', -- -10%acc                                                            150
        'g001ig0073', -- -3 клетки обзора в области 7х7                                     150
        'g001ig0072', -- +3 клетки обзора                                                   150
        'g001ig0195', -- навык мудрость                                                     150
        'g000ig5021', -- 7arm                                                               150
        'g001ig0250', -- 7arm                                                               150
        'g000ig5102', -- +15hp                                                              150
        'g000ig5025', -- призыв Рух                                                         200
        'g000ig5061', -- призыв скелета                                                     200
        'g000ig5098', -- призыв Энта малого                                                 200
        'g000ig5084', -- устанавливать жезлы                                                200
        'g001ig0492', -- возможность применять сферы                                        200
        'g001ig0440', -- уменьшает лидерство на 2 в области 5x5                             225
        'g000ig5118', -- -3 клетки в области 5х5                                            250
        'g001ig0095', -- устанавливать жезлы                                                250
        'g001ig0103', -- устанавливать жезлы                                                250
        'g000ig5047', -- fantom beliarha                                                    250
        'g000ig5046', -- beliarha                                                           250
        'g001ig0254', -- +10%acc +10%dmg                                                    250
        'g000ig5050', -- -15%ini                                                            250
        'g001ig0255', -- +15%ini                                                            250
        'g000ig5049', -- уменьшает на 15% урон                                              250
        'g001ig0253', -- уменьшает на 15% урон                                              250
        'g000ig5069', -- уменьшает на 15% урон                                              250
        'g000ig5048', -- 30 magic damage                                                    250
        'g001ig0117', -- 30 magic damage                                                    250
        'g000ig5070', -- 30 magic damage                                                    250
        'g000ig5028', -- 30 magic damage                                                    250
        'g000ig5105', -- 30dmg водой                                                        250
        'g000ig5067', -- 30 magic damage                                                    250
        'g000ig5030', -- открывает участок карты 7x7                                        250 
        'g000ig5119', -- уничтожает жезл                                                    250
        'g001ig0091', -- уничтожает небольшой участок леса                                  250
        'g000ig5026', -- +15%ini                                                            250
        'g001ig0571', -- +25% вампиризма                                                    250
        'g001ig0084', -- создаёт небольшой участок с водой                                  250
        'g000ig5009', -- открывает участок карты 5x5                                        250
        'g000ig5007', -- восстанавливает 30 ОЗ                                              250
        'g000ig5029', -- восстанавливает 40 ОЗ                                              250
        'g000ig5068', -- окутывает туманом часть карты, защищает от заклов                  250
        'g001ig0194', -- +15% к скидке у торговца                                           250
        'g001ig0256', -- +15%dmg                                                            250
        'g000ig5104', -- 30 magic damage                                                    250
        'g001ig0580', -- лишает резиста к воздуху, иммун меняет на резист                   250
        'g001ig0577', -- лишает отряд резиста к огню, иммум меняет на резист                250
        'g001ig0576', -- лишает резиста к смерти, иммун меняет на резист                    250
        'g001ig0578', -- лишает резиста к воде, иммун меняет на резист                      250
        'g001ig0574', -- лишает резиста к разуму, иммун меняет на резист                    250
        'g001ig0579', -- лишает резиста к земле, иммун меняет на резист                     250
        'g001ig0575', -- лишает резиста к жизни, иммун меняет на резист                     275
        'g001ig0573', -- лишает резаста к оружию, иммун меняет на резист                    275   
        'g001ig0568', -- +25% шанса принять атаку на себя вместо поина позади себя          275
        'g001ig0569', -- +15% опыта за убийство                                             275
        'g000ig5114', -- -30arm                                                             300
        'g000ig5111', -- -15%acc -10%dmg                                                    300
        'g001ig0439', -- уменьшает лидерство на 1 в области 5x5                             300
        'g000ig5054', -- 50 magic damage                                                    300
        'g000ig5109', -- 50 magic damage                                                    300
        'g000ig5033', -- 50 magic damage                                                    300
        'g001ig0193', -- +15 опыта отряду                                                   300
        'g001ig0093', -- +25% vamp                                                          300
        'g000ig5014', -- 50 magic damage                                                    300
        'g000ig5072', -- 50 magic damage                                                    300
        'g000ig5093', -- 40 урона в области                                                 300
        'g000ig5081', -- 40 урона в области                                                 300
        'g000ig5034', -- защищает от понижения урона                                        300
        'g000ig5110', -- восстанавливает 60 ОЗ в области                                    300
        'g000ig5057', -- защита от полиформа                                                300
        'g000ig5099', -- -30% moov                                                          300
        'g000ig5088', -- увеличивает количество опыта в бою                                 300
        'g000ig5073', -- увеличивает макс HP на 20%                                         300
        'g000ig5013', -- +15%acc +15%dmg                                                    300
        'g000ig5107', -- создаёт участок леса 4х4                                           300
        'g000ig5066', -- призыв Хуорна                                                      300
        'g000ig5008', -- призыв живого доспеха                                              300
        'g000ig5103', -- призыв Энта                                                        300
        'g000ig5074', -- окутывает пыльючасть карты, защищает от заклов                     300
        'g000ig5052', -- окутывает туманов участок карты                                    350
        'g000ig5089', -- -15%acc -15%dmg                                                    350
        'g001ig0570', -- -25% опыта в области 7х7                                           350
        'g000ig5020', -- +10%acc +5%dmg +5%ini                                              350
        'g001ig0076', -- вызов Каменной сущности                                            400
        'g001ig0075', -- вызов Ледяной сущности                                             400
        'g001ig0074', -- вызов Сущности Бури                                                400
        'g001ig0077', -- вызов Сущности пламени                                             400
        'g001ig0078', -- вызов стихийного голема                                            400
        'g000ig5040', -- излечивает на 100                                                  400
        'g000ig5055', -- -33%acc                                                            400
        'g000ig5090', -- 60dmg в области                                                    400
        'g000ig5086', -- 60dmg в области                                                    400
        'g000ig5112', -- 60dmg в области                                                    400
        'g001ig0249', -- защита отряда от воды                                              400
        'g000ig5005', -- защита от воды                                                     400
        'g000ig5001', -- защита от вохдуха                                                  400
        'g000ig5010', -- защита от земли                                                    400
        'g000ig5016', -- защита от огня                                                     400
        'g001ig0251', -- защита от огня                                                     400
        'g000ig5011', -- защита от разума                                                   400
        'g000ig5077', -- 75 magic damage                                                    400
        'g000ig5017', -- +-33%dmg                                                           400
        'g000ig5056', -- 75 magic dmg                                                       400
        'g000ig5036', -- +33% dmg                                                           400
        'g000ig5012', -- -15%dmg (15arm?)                                                   400
        'g000ig5082', -- +20%hp +5arm                                                       400  
        'g000ig5037', -- 75 magic damage                                                    400
        'g001ig0092', -- уничтожает большой участок леса                                    400
        'g000ig5085', -- скадка 20%                                                         400
        'g001ig0123', -- окутывает участок карты                                            400
        'g001ig0586', -- лишается неподкупности и теряет 20% сопротивления ворам            425
        'g000ig5018', -- защита от смерти                                                   450
        'g001ig0085', -- создаёт большой участок воды                                       450
        'g000ig5031', -- призыв Валькирию                                                   500
        'g000ig5015', -- призыв Голем                                                       500
        'g000ig5071', -- призыв Кошмара                                                     500
        'g000ig5108', -- вызов Энта большого                                                500
        'g000ig5115', -- уменьшает на 33% урон заколдованных юнитов                         500
        'g000ig5120', -- мгновенное отступление                                             500
        'g000ig5096', -- 35% вампиризма                                                     500
        'g001ig0094', -- многовенное отступление                                            500
        'g000ig5060', -- 125 повреждений магией                                             500
        'g000ig5080', -- 125 повреждений магией                                             500
        'g000ig5059', -- summon fantom adskiy mstitel                                       500
        'g000ig5087', -- без штрафа по воде                                                 500
        'g000ig5019', -- 125magic dmg                                                       500
        'g000ig5076', -- -33%dmg                                                            500
        'g000ig5079', -- защита от оружия                                                   500
        'g001ig0572', -- +20%krita                                                          500
        'g000ig5039', -- неподкупность                                                      500
        'g000ig5038', -- вызов каменного предка                                             600
        'g000ig5116', -- +50hp                                                              600
        'g000ig5075', -- -33%ini отряду                                                     600
        'g000ig5058', -- fantom adskiy mstitel                                              700
        'g000ig5091', -- -33%ini в области                                                  700
        'g000ig5117', -- вызов Верданта                                                     700
        'g000ig5078', -- вызов Танатоса                                                     700
        'g001ig0080', -- вызов Вестника немощи                                              700
        'g001ig0081', -- вызов Вестника Перемен                                             700
        'g001ig0079', -- вызов Вестника поглощения                                          700
        'g000ig5035', -- +23%arm                                                            1000
        'g001ig0171', -- все отряды получают 25% от нанесённого урона в виде здоровья       1000
        'g001ig0160', -- защита от воды для всех отрядов                                    1000
        'g001ig0159', -- защита от воздуха для всех отрядов                                 1000
        'g001ig0161', -- защите от земли для всех отрядов                                   1000
        'g001ig0163', -- защита от огня для всех отрядов                                    1000
        'g001ig0162', -- защита от разума для всех отрядов                                  1000
        'g001ig0166', -- +20ini всем отрядам                                                1000
        'g001ig0169', -- +20%acc всем отрядам                                               1000
        'g001ig0168', -- на 20% меньше повреждений всем отрядам                             1000
        'g001ig0167', -- на 20% больше повреждение всем отрядам                             1000
        'g001ig0170', -- +50hp всем отрядам                                                 1500
        'g001ig0164', -- защита от смерти для всех отрядов                                  2000
        'g001ig0165', -- защита от оружия для всех отрядов                                  2000
    }







-- сферы в сундуках -- проверил все
local weakOrbs = { 'g000ig9019', 'g001ig0189', 'g000ig9017', 'g000ig9033', 'g001ig0299', 'g001ig0453', 'g000ig9013', 'g001ig0301', 'g001ig0304', 'g001ig0303', 'g001ig0479', 'g000ig9041', 'g000ig9038',
                    'g001ig0300', 'g001ig0302', 'g000ig9034', 'g000ig9024', 'g001ig0471', 'g000ig9031', 'g001ig0470', 'g001ig0464', 'g001ig0456', 'g001ig0458', 'g001ig0466', 'g001ig0457', 'g001ig0192', 
                    'g001ig0191', 'g001ig0478', 'g001ig0489', 'g001ig0446', 'g001ig0187', 'g001ig0469', 'g000ig9022', 'g001ig0468', 'g001ig0480', 'g001ig0188', 'g001ig0190', 'g001ig0448', 'g000ig9036', 'g001ig0467' }
local mediumOrbs = { 'g001ig0475', 'g001ig0476', 'g000ig9005', 'g000ig9002', 'g000ig9015', 'g000ig9003', 'g000ig9010', 'g001ig0455', 'g001ig0472', 'g001ig0454', 'g001ig0473', 'g001ig0474', 
                    'g000ig9029', 'g000ig9016', 'g001ig0444', 'g001ig0459', 'g001ig0450', 'g000ig9042', 'g001ig0461', 'g001ig0183', 'g001ig0477', 'g000ig9020', 'g001ig0056', 'g001ig0054', 
                    'g001ig0055', 'g001ig0053', 'g001ig0058', 'g001ig0057' }
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

----------------------------
-- знамёна -- проверил все
----------------------------
local BannerT1 = { 
    'g000ig1005', -- +10%ini    400
    'g001ig0051', -- +25hp      400 
    'g000ig1001', -- +10arm     400
    'g000ig1007', -- +10%dmg    400
    'g000ig1003', -- +10%acc    400
    'g001ig0587' -- +10%exp     500
} 

local BannerT2 = { 
    'g001ig0369', -- moroz protection +5acc mili +5%dop za big          600
    'g001ig0370', -- transform protection +15%hp                        600
    'g001ig0142', -- water protection                                   700
    'g001ig0140', -- air protection                                     700
    'g001ig0141', -- earth protection                                   700
    'g001ig0139', -- fire protection                                    700
    'g001ig0145', -- mind protection                                    700
    'g001ig0143', -- death protection                                   700
    'g001ig0293', -- 10%dmg +5%ini                                      700
    'g000ig1004', -- +15%acc                                            700
    'g001ig0365', -- immun Strah +5% +5%                                700
    'g001ig0361', -- gorenie protection +15%hp                          700
    'g001ig0289', -- 10arm +5%hp                                        700
    'g000ig1008', -- +15%dmg                                            700
    'g001ig0292', -- +10%dmg +5%acc                                     700
    'g001ig0357', -- +10%ini +5%acc                                     700
    'g000ig1002', -- +15arm                                             700
    'g000ig1006', -- +15%ini                                            700
    'g001ig0588', -- +15%exp                                            750
    'g001ig0363', -- paral protection +5%dmg za 1 ryd + 5% za big       750
    'g001ig0364', -- slowdown protection, +5%ini za 1 rad +5% big voina 800
    'g001ig0372', -- ponij lvl protection +5%dmg za mili +5%dmg za big  800
    'g001ig0374', -- razrush protection +5arm za mili + 5arm za big     800
    'g001ig0358', -- +10%ini +10%acc                                    800
    'g001ig0362' -- pertification protected +15arm                      800
    

}

local BannerT3 = { 
    'g001ig0373', -- vamp protection +25%regen                                        1000
    'g001ig0359', -- +20%acc                                                          1000
    'g001ig0367', -- poison protection +25% regen                                     1000
    'g001ig0360', -- +15%vamp +10%dmg                                                 1300
    'g000ig1016', -- +20%dmg                                                          1500
    'g000ig1017', -- 13%regen 20%hp                                                   1500
    'g000ig1015', -- 20arm                                                            1500
    'g001ig0290', -- +10arm +25%hp                                                    1500
    'g001ig0291' -- +10arm +10%hp                                                     1500
    -- 'g001ig0375', -- immun k imitacii +2lvl prizvannym ili prevrativshimsya           1000      в магаз/убрать???
    -- 'g001ig0500', -- immun ataka-proklyatie +20%acc atak-prokl +5%regen baf and prokl 1100      в магаз/убрать???
}

local BannerT4 = { 
    'g001ig0153', -- 25%vamp                           1500
    'g001ig0144', -- weapon protection                 1500
    'g001ig0052', -- +50hp                             1500
    'g001ig0366', -- taumaturgiya protection +25%vamp  1700
    'g001ig0360' -- +15%vamp +10%dmg                   1300
    -- 'g001ig0368', -- uron protection                   2000  в магаз/убрать???
    
}

----------------------
-- Сапоги -- проверил
----------------------
local TravelT1 = { 
    'g001ig0108', -- water protection + 15hp 300
    'g001ig0107', -- air protection + 15hp 300
    'g001ig0105', -- fire protection + 15hp 300
    'g001ig0109', -- death protection + 15hp 300
    'g001ig0106', -- earth protection + 15hp 300
    'g001ig0113', -- +7arm +10hp 300
    'g000ig1010', -- +2moov, walk in the forest, +10%dmg +10%acc if in forest 700
    'g000ig8003' --  + 4moov 700
}

local TravelT2 = { 
    'g001ig0606', -- +2moov +10%regen +4moov if on homeland 1000
    'g000ig8004', -- +7moov 1200
    'g001ig0050' -- +7moov 1600
}

local TravelT3 = { 
    'g001ig0114', -- +11arm +15hp 500
    'g001ig0115', -- +15arm +20hp 1100
    'g001ig0112', -- +15%ini +20%dmg 800
    'g001ig0111', -- +11%ini +15%dmg 500
}

-- Посохи -- проверил
local wand = { 'g000ig6007', 'g000ig6006', 'g001ig0392', 'g001ig0391', 'g000ig6003', 'g001ig0399', 'g000ig6012', 'g000ig6001', 'g001ig0401', 'g001ig0394', 'g001ig0397', 'g001ig0402',
                'g000ig6020', 'g000ig6015', }


function getReward(Type, Zone)

    local rewardItems = { }

    if Type == 'town' and Zone == 'StartZonet1' then
        table.insert(rewardItems, { id = 'g000ig0005', min = 3, max = 4 } ) -- heal 50
        table.insert(rewardItems, { id = smallValuable[math.random(#smallValuable)], min = 1, max = 1 } ) -- valuable 50/75/100
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = wand[math.random(#wand)], min = 1, max = 1 } ) --
        table.insert(rewardItems, { id = Talismant1[math.random(#Talismant1)], min = 1, max = 1 } )

    elseif Type == 'guard' and Zone == 'townt1' then
        table.insert(rewardItems, { id = 'g000ig0005', min = 2, max = 2 } ) -- heal 50
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = Talismant1[math.random(#Talismant1)], min = 1, max = 1 } )

    elseif Type == 'town' and Zone == 'StartZonet2' then
        table.insert(rewardItems, { id = 'g000ig0001', min = 1, max = 2 } ) -- res
        table.insert(rewardItems, { id = 'g001ig0378', min = 1, max = 2 } ) -- heal 75
        table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 3 } ) -- heal 100
        table.insert(rewardItems, { id = smallballmana[math.random(#smallballmana)], min = 1, max = 1 } ) -- 50 mana
        table.insert(rewardItems, { id = ArtT1[math.random(#ArtT1)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = Talismant2[math.random(#Talismant2)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1 } ) -- valuable 125/150/175/200

    elseif Type == 'guard' and Zone == 'townt2' then
        table.insert(rewardItems, { id = 'g001ig0180', min = 2, max = 3 } ) -- heal 25
        table.insert(rewardItems, { id = 'g001ig0378', min = 1, max = 1 } ) -- heal 75
        table.insert(rewardItems, { id = 'g000ig0006', min = 1, max = 1 } ) -- heal 100

    elseif Type == 'town' and Zone == 'BigZonet3' then
        table.insert(rewardItems, { id = 'g000ig0001', min = 1, max = 2 } ) -- res
        table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 3 } ) -- heal 75
        table.insert(rewardItems, { id = 'g000ig0006', min = 3, max = 3 } ) -- heal 100
        table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
        table.insert(rewardItems, { id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1 } ) -- 100 mana
        table.insert(rewardItems, { id = JewelT2[math.random(#JewelT2)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1 } ) -- valuable 125/150/175/200

    elseif Type == 'guard' and Zone == 'townt3' then
        table.insert(rewardItems, { id = wand[math.random(#wand)], min = 1, max = 1 } ) --
        table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )

    elseif Type == 'town' and Zone == 'BigZonet4' then
        table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res
        table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 3 } ) -- heal 75
        table.insert(rewardItems, { id = 'g000ig0006', min = 3, max = 3 } ) -- heal 100
        table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
        table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } ) -- 200 mana
        table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = bigValuable[math.random(#bigValuable)], min = 1, max = 1 } ) -- valuable 250/400
        table.insert(rewardItems, { id = TravelT3[math.random(#TravelT3)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = Talismant2[math.random(#Talismant2)], min = 1, max = 1 } )

    elseif Type == 'guard' and Zone == 'townt4' then
        table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )


    elseif Type == 'town' and Zone == 'VSZonet4' then
        table.insert(rewardItems, { id = 'g000ig0006', min = 3, max = 3 } ) -- heal 100
        table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
        table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } ) -- 200 mana
        table.insert(rewardItems, { id = JewelT4[math.random(#JewelT4)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 2 } )
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1 } ) 


    elseif Type == 'town' and Zone == 'VSZonet5' then
        table.insert(rewardItems, { id = 'g001ig0152', min = 2, max = 3 } ) -- heal 300
        table.insert(rewardItems, { id = 'g000ig0006', min = 3, max = 3 } ) -- heal 100
        table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
        table.insert(rewardItems, { id = ArtT5[math.random(#ArtT5)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } ) 
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1 } ) 


    -- elseif Typeobject == 'merchants' and Zoneobject == 'StartZonet1' then

    elseif Type == 'ruins' and Zone == 'StartZonet1' then
        table.insert(rewardItems, ili( { id = TravelT1[math.random(#TravelT1)], min = 1, max = 1 }, { id = ArtT1[math.random(#ArtT1)], min = 1, max = 1 } ) )


    elseif Type == 'ruins' and Zone == 'StartZonet2' then
        table.insert(rewardItems, ili( { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1 }, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } ) )



    elseif Type == 'ruins' and Zone == 'bufferZone' then
        table.insert(rewardItems, { id = BannerT1[math.random(#BannerT1)], min = 1, max = 1 } )



    elseif Type == 'riuns' and Zone == 'BigZonet3' then
        table.insert(rewardItems, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1 } )
    elseif Type == 'riuns' and Zone == 'BigZonet4' then
        table.insert(rewardItems, { id = BannerT3[math.random(#BannerT3)], min = 1, max = 1 } )



    elseif Type == 'riuns' and Zone == 'BigZonet4.1' then
        table.insert(rewardItems, { id = ArtT3[math.random(#ArtT3)], min = 1, max = 1 } )
    elseif Type == 'riuns' and Zone == 'BigZonet4.2' then
        table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1 } )



        
    elseif Type == 'riuns' and Zone == 'VSZonet4' then
        table.insert(rewardItems, { id = JewelT4[math.random(#JewelT4)], min = 1, max = 1 } )
    elseif Type == 'riuns' and Zone == 'VSZonet5' then
        table.insert(rewardItems, { id = BannerT4[math.random(#BannerT4)], min = 1, max = 1 } )

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
        table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } ) -- 
        table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res
        table.insert(rewardItems, { id = 'g001ig0152', min = 2, max = 2 } ) -- heal 300
        table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1 } )

    
        --scroll--
    
        --scroll--
   


    

    elseif Type == 'guard' and Zone == 'townt4.1' then

    elseif Type == 'guard' and Zone == 'townt4.2' then




    elseif Type == 'stackt1' and Zone == 'startZone' then
        table.insert(rewardItems, { id = AuraPermanentProtect[math.random(#AuraPermanentProtect)], min = 1, max = 1 } )


    elseif Type == 'bags' and Zone == 'startZone' then 
        table.insert(rewardItems, { id = 'g001ig0180', min = 4, max = 6 } ) -- heal 25
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = 'g000ig0005', min = 4, max = 6 } ) -- heal 50
        table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = smallballmana[math.random(#smallballmana)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )


        
    elseif Type == 'bags' and Zone == 'BigZone' then
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = 'g000ig0001', min = 4, max = 4 } ) -- res
        table.insert(rewardItems, { id = 'g001ig0378', min = 3, max = 4 } ) -- хил 75
        table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = 'g000ig0006', min = 4, max = 5 } ) -- хил 100
        table.insert(rewardItems, { id = 'g000ig0018', min = 3, max = 4 } ) -- хил 200
        table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
        table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )








    end

    return rewardItems
end

----------------------
    -- Отряды в зонах
----------------------
function getStack(tier, stackCount, itemsTable)

    local squadStack = { }
    if (tier == 1) then squadStack = Squad1
    elseif (tier == 2 or tier == 3) then squadStack = Squad2
    elseif (tier == 4) then squadStack = Squad3
    elseif (tier == 5) then squadStack = Squad4
    end

    local expValueStack = { }
    if (tier == 1) then
        expValueStack.min = 220 * stackCount * kf
        expValueStack.max = 270 * stackCount * kf
    elseif (tier == 2) then
        expValueStack.min = 250 * stackCount * kf
        expValueStack.max = 320 * stackCount * kf
    elseif (tier == 3) then
        expValueStack.min = 350 * stackCount * kf
        expValueStack.max = 420 * stackCount * kf
    elseif (tier == 4) then
        expValueStack.min = 500 * stackCount * kf
        expValueStack.max = 780 * stackCount * kf
    elseif (tier == 5) then
        expValueStack.min = 800 * stackCount * kf
        expValueStack.max = 1140 * stackCount * kf
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
    if (tier == 1) then squadStack = Squad1
    elseif (tier == 2 or tier == 3) then squadStack = Squad2
    elseif (tier == 4) then squadStack = Squad3
    elseif (tier == 5) then squadStack = Squad4
    elseif (tier == 6) then squad = SquadGO
    end

    local expValueGuard = { }
    if (tier == 1) then
        expValueGuard.min = 250 * kf
        expValueGuard.max = 310 * kf
    elseif (tier == 2) then
        expValueGuard.min = 320 * kf
        expValueGuard.max = 420 * kf
    elseif (tier == 3) then
        expValueGuard.min = 540 * kf
        expValueGuard.max = 690 * kf
    elseif (tier == 4) then
        expValueGuard.min = 650 * kf
        expValueGuard.max = 780 * kf
    elseif (tier == 5) then
        expValueGuard.min = 800 * kf
        expValueGuard.max = 1090 * kf
    elseif (tier == 6) then
        expValueGuard.min = 1100 * kf
        expValueGuard.max = 1750 * kf
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
        expValue.min = 240 * kf * 1.1
        expValue.max = 300 * kf * 1.1
    elseif ( townTier == 2) then
        expValue.min = 320 * kf * 1.1
        expValue.max = 420 * kf * 1.1
    elseif ( townTier == 3) then
        expValue.min = 540 * kf * 1.1
        expValue.max = 690 * kf * 1.1
    elseif ( townTier == 4) then
        expValue.min = 680 * kf * 1.1
        expValue.max = 800 * kf * 1.1
    elseif ( townTier == 5) then
        expValue.min = 820 * kf * 1.1
        expValue.max = 990 * kf * 1.1
    end

    local townGuard = { }
    if ( townTier == 1 ) then
        townGuard = Squad1
    elseif ( townTier == 2) then
        townGuard = Squad2
    elseif ( townTier == 3) then
        townGuard = Squad3
    elseif ( townTier == 4 or townTier > 4) then
        townGuard = Squad4
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

-----------------------------------------------
    -- Наёмники
-----------------------------------------------
function getMercenaries(getGuard, getReward)

    local unitsMercenaries = {}
    local i = 1


    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu0028', level = 1, unique = true } i = i + 1 end -- разжигатель
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g001uu8279', level = 1, unique = true } i = i + 1 end -- чумной волк
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu5013', level = 1, unique = true } i = i + 1 end -- орк
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu5005', level = 1, unique = true } i = i + 1 end -- лесной эльф
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu8218', level = 1, unique = true } i = i + 1 end -- волхв
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu8199', level = 1, unique = true } i = i + 1 end -- дитя резни
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g001uu8260', level = 1, unique = true } i = i + 1 end -- искуситель
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu7609', level = 1, unique = true } i = i + 1 end -- квартирмейстер
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g001uu7560', level = 1, unique = true } i = i + 1 end -- каратель
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu7610', level = 1, unique = true } i = i + 1 end -- ледяной ходок
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu8041', level = 1, unique = true } i = i + 1 end -- темный эльф мясник
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu7604', level = 1, unique = true } i = i + 1 end -- незрячий страж
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu2031', level = 4, unique = true } i = i + 1 end -- эмиссар
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu2030', level = 3, unique = true } i = i + 1 end -- детектив
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu0014', level = 4, unique = true } i = i + 1 end -- ангел
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g001uu7571', level = 2, unique = true } i = i + 1 end -- белый волк
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu0152', level = 4, unique = true } i = i + 1 end -- белый маг
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g001uu7564', level = 2, unique = true } i = i + 1 end -- хорт
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g003uu5012', level = 3, unique = true } i = i + 1 end -- орк палач
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu0177', level = 4, unique = true } i = i + 1 end -- смерть
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g001uu8267', level = 3, unique = true } i = i + 1 end -- эльф-призрак
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu0166', level = 4, unique = true } i = i + 1 end -- возвышенный
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu7583', level = 2, unique = true } i = i + 1 end -- йамму
    -- if math.random(0,1) == 1 then unitsMercenaries[i] = { id = '', level = 1, unique = true } i = i + 1 end --
    -- if math.random(0,1) == 1 then unitsMercenaries[i] = { id = '', level = 1, unique = true } i = i + 1 end --
    -- if math.random(0,1) == 1 then unitsMercenaries[i] = { id = '', level = 1, unique = true } i = i + 1 end --
    -- if math.random(0,1) == 1 then unitsMercenaries[i] = { id = '', level = 1, unique = true } i = i + 1 end -- 
    -- if math.random(0,1) == 1 then unitsMercenaries[i] = { id = '', level = 1, unique = true } i = i + 1 end --


    return {
        units = unitsMercenaries,
        guard = getGuard

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
        { id = 'g000ig5084', min = 1, max = 1}, -- свиток жезла
        { id = 'g000ig0008', min = 1, max = 2}, -- +15%acc
        { id = 'g000ig0011', min = 1, max = 2}, -- +15%ini

    }
    if playerRace == Race.Human then
        table.insert(StartItem, {id = 'g001ig0277', min = 1, max = 1}) -- шар маны жизни 200
        table.insert(StartItem, {id = ScrollCapital[math.random(#ScrollCapital)], min = 1, max = 1}) -- свиток энт малый или скелет
        table.insert(StartItem, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
        table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1}) 
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
        table.insert(StartItem, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
        table.insert(StartItem, {id = Talismant1[math.random(#Talismant1)], min = 1, max = 1})
    elseif playerRace == Race.Elf then
        table.insert(StartItem, {id = 'g001ig0281', min = 1, max = 1}) -- шар маны лесного элексира 200
        table.insert(StartItem, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
        table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
        table.insert(StartItem, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
        table.insert(StartItem, {id = Talismant1[math.random(#Talismant1)], min = 1, max = 1})
    elseif playerRace == Race.Heretic then
        table.insert(StartItem, {id = 'g001ig0278', min = 1, max = 1}) -- шар маны преисподней 200
        table.insert(StartItem, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})        
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
        table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
        table.insert(StartItem, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
        table.insert(StartItem, {id = Talismant1[math.random(#Talismant1)], min = 1, max = 1})
    elseif playerRace == Race.Dwarf then
        table.insert(StartItem, {id = 'g001ig0279', min = 1, max = 1}) -- шар маны рун 200
        table.insert(StartItem, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
        table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
        table.insert(StartItem, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
        table.insert(StartItem, {id = Talismant1[math.random(#Talismant1)], min = 1, max = 1})
    elseif playerRace == Race.Undead then
        table.insert(StartItem, {id = 'g001ig0280', min = 1, max = 1}) -- шар маны смерти 200
        table.insert(StartItem, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
        table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
        table.insert(StartItem, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
        table.insert(StartItem, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
        table.insert(StartItem, {id = Talismant1[math.random(#Talismant1)], min = 1, max = 1})
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
            getRuins( { min = 210, max = 249 }, getGuard(1), getReward('ruins', 'StartZonet1') ),
            getRuins( { min = 239, max = 280 }, getGuard(2), getReward('ruins', 'StartZonet2') )
            },

        -- Города в стартовой зоне
        towns = { 
                getTown( 1, getGuard(1), getReward('town', 'StartZonet1') ),
                getTown( 2, getGuard(2), getReward('town', 'StartZonet2') )
            },

        bags = getBags( 5, getReward('bags', 'startZone') )

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
            getRuins( { min = 420, max = 530 }, getGuard(4), getReward('ruins', 'BigZonet4.1') ),
            getRuins( { min = 420, max = 530 }, getGuard(4), getReward('ruins', 'BigZonet4.2') )
        },

        -- Лагерь наёмников
        mercenaries = { getMercenaries(getGuard(3), getReward('mercen', 'bigZone') )
    
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

        bags = getBags( 7, getReward('bags', 'BigZone') ),

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
            getRuins( { min = 320, max = 380 }, getGuard(3), getReward('ruins', 'BigZonet3') ),
            getRuins( { min = 420, max = 530 }, getGuard(4), getReward('ruins', 'BigZonet4') )
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

        bags = getBags( 7, getReward('bags', 'BigZone') ),

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
            getRuins( { min = 420, max = 530 }, getGuard(4), getReward('ruins', 'BigZonet4.1') ),
            getRuins( { min = 420, max = 530 }, getGuard(4), getReward('ruins', 'BigZonet4.2') )
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

        bags = getBags( 7, getReward('bags', 'BigZone') ),

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
            getRuins( { min = 320, max = 380 }, getGuard(3), getReward('ruins', 'BigZonet3') ),
            getRuins( { min = 420, max = 530 }, getGuard(4), getReward('ruins', 'BigZonet4') )
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

        bags = getBags( 7, getReward('bags', 'BigZone') ),

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
            getStack( 3, 10, {} )
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
            getRuins ( { min = 320, max = 380}, getGuard(3), getReward('ruins', 'bufferZone') ),
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
            getStack( 3, 10, {} )
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
            getRuins({ min = 320, max = 380}, getGuard(3), getReward('ruins', 'bufferZone') ),
        },

        bags = getBags( 3, {} )
	}
end

--------------------------------------------------
  -- Описывает буферную зону игрока 3
--------------------------------------------------

-- function getBufferZone3(zoneId, playerRace, zoneSize)
-- 	return {
-- 		id = zoneId,
-- 		type = Zone.Junction,
-- 		size = zoneSize,
--         mines = getMinesBufferZone(playerRace),
--         stacks = {
--             getStack( 3, 10, {} )
--         },

--         -- Торговец 
--         merchants = {
--             {   goods = {
--                     itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
--                     value = { min = 8000, max = 9500 }
--                 }
--             },
--                 guard = getGuard( 3 )
--         },

--          -- Башня мага 
--         mages = {
--             { spellLevel = { min = 2, max = 4 },
--                value = { min = 5000, max = 6000 }
--             },
--             guard = getGuard( 3 )
--         },

--         ruins = {
--             getRuins ( { min = 320, max = 380}, getGuard(3), getReward('ruins', 'bufferZone') ),
--         },

--         bags = getBags( 3, {} )
-- 	}
-- end

--------------------------------------------------
  -- Описывает буферную зону игрока 2
--------------------------------------------------

-- function getBufferZone4(zoneId, playerRace, zoneSize)
-- 	return {
-- 		id = zoneId,
-- 		type = Zone.Junction,
-- 		size = zoneSize,
--         mines = getMinesBufferZone(playerRace),
--         stacks = {
--             getStack( 3, 10, {} )
--         },

--         -- Торговец 
--         merchants = {
--             {   goods = {
--                     itemTypes = { Item.Orb, Item.Talisman, Item.PotionBoost, Item.PotionHeal, Item.PotionRevive },
--                     value = { min = 8000, max = 9500 }
--                 }
--             },
--                 guard = getGuard( 3 )
--         },

--          -- Башня мага 
--         mages = {
--             { spellLevel = { min = 2, max = 4 },
--                value = { min = 5000, max = 6000 }
--             },
--             guard = getGuard( 3 )
--         },

--         ruins = {
--             getRuins ( { min = 320, max = 380}, getGuard(3), getReward('ruins', 'bufferZone') ),
--         },

--         bags = getBags( 3, {} )
-- 	}
-- end


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
            getStack( 4, 12, {} ),
            getStack( 5, 10, {} )
        },

        -- Ruins
        ruins = {
            getRuins( { min = 600, max = 685 }, getGuard(5), getReward('ruins', 'BigZonet4') ),
            getRuins( { min = 420, max = 530 }, getGuard(4), getReward('ruins', 'BigZonet4') ),
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
-- local bufferZone3Id = 9
-- local bufferZone4Id = 10
-- Номер центральной зоны
local VSZoneId = 6


function getZones(races)

	local BigZoneSize = 1000
	local StartZoneSize = 900
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
		{ from = 1, to = 6, guard = getGuard( 6, getReward('guard', 'GO') ) },
        -- { from = 1, to = 6, guard = getGuard( 6, {} ) },
        -- Проходы между 2 большой зоной и центром
		{ from = 2, to = 6, guard = getGuard( 6, getReward('guard', 'GO') ) },
        -- { from = 2, to = 6, guard = getGuard( 6, {} ) },
        -- Проходы между большими соседними зонами
        -- { from = 1, to = 2 },
        -- { from = 5, to = 4 },

        -- Проходы между 3 большой зоной и центром
        -- { from = 5, to = 6, guard = getGuard( 6, {} ) },
        { from = 5, to = 6, guard = getGuard (6, getReward('guard', 'GO') ) },
        -- Проходы между 4 большой зоной и центром
        -- { from = 4, to = 6, guard = getGuard( 6, {} ) },
        { from = 4, to = 6, guard = getGuard( 6, getReward('guard', 'GO') ) },
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
	name = 'VerSus 0.5.1',
	description = 'VerSus 0.5.1 by iSkromny, sMNS 2.08b, 72x72, 2 players, two zones to players, 1 zone in the center',
    minSize = 72,
	maxSize = 72,
	maxPlayers = 2,
	roads = 45,
	forest = 40,
	startingGold = 1000,
    startingNativeMana = 200,	
	getContents = getTemplateContents
}
