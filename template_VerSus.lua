-- template: versus
-- author: iSkromny

-- Шаблон представляет собой карту, разделённую на 7 частей:
-- две зоны респа: имеют проходы в большие зоны 
-- четыре больших зоны: имеют проход в центральную зону и по одному проходу в смежную большую зону.
--The template is a map divided into 7 parts:
-- two respawn zones: have passages to large zones
-- four large zones: have a passage to the central zone and one passage to the adjacent large zone.

--  Игрок 1      зона        Игрок 2 
--  
--  красная      респ        белая
--  зелёная     большая      синяя 
--  серая       большая      чёрная
--  жёлтая       центр       жёлтая

-- При генерации жёлтой зоны обязательно должны касаться: зелёная, синяя, чёрная и серая! Зелёная и синяя касаются друг друга, чёрная и серая касаются друг друга.
-- When generating the yellow zone must be touched by green, blue, gray and black. The green and blue zones touch each other, the gray and black zones touch each other.
-----------------------------------------------
--   3 - 4  
-- 2 - 6 - 5
--   1 - 0
-- При несоблюдении расстановки зон может случиться, что из одной из больших зон не будет выхода в центр.
------------------------------------------------------------------------------------------------------------------------------------------------------------------
local Squad1 = { Subrace.Neutral, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, Subrace.NeutralHuman, Subrace.NeutralBarbarian }

local Squad2 = { Subrace.NeutralGreenSkin, Subrace.NeutralBarbarian, Subrace.NeutralMarsh, Subrace.NeutralWolf, Subrace.NeutralElf, Subrace.NeutralHuman, Subrace.Neutral }

local Squad3 = { Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralWolf,
                    Subrace.Neutral, Subrace.NeutralBarbarian, Subrace.NeutralWater }

local Squad4 = { Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, 
                    Subrace.Neutral, Subrace.NeutralBarbarian, Subrace.NeutralWater, Subrace.NeutralHuman, Subrace.NeutralElf }

local SquadGO = { Subrace.NeutralDragon, Subrace.NeutralMarsh, Subrace.Neutral }

function getStartMines(race)
    local resourceCube = math.random(0, 3)
    local mines = {
        gold = 2,
    }
	if race == Race.Human then
		mines.lifeMana = 2
        if resourceCube == 0 then
            mines.groveMana = 1
        elseif resourceCube == 1 then
            mines.runicMana = 1
        elseif resourceCube == 2 then
            mines.infernalMana = 1
        elseif resourceCube == 3 then
            mines.deathMana = 1
        end
	elseif race == Race.Dwarf then
		mines.runicMana = 2
        if resourceCube == 0 then
            mines.groveMana = 1
        elseif resourceCube == 1 then
            mines.lifeMana = 1
        elseif resourceCube == 2 then
            mines.infernalMana = 1
        elseif resourceCube == 3 then
            mines.deathMana = 1
        end
	elseif race == Race.Undead then
		mines.deathMana = 2
        if resourceCube == 0 then
            mines.groveMana = 1
        elseif resourceCube == 1 then
            mines.runicMana = 1
        elseif resourceCube == 2 then
            mines.infernalMana = 1
        elseif resourceCube == 3 then
            mines.lifeMana = 1
        end
	elseif race == Race.Heretic then
		mines.infernalMana = 2
        if resourceCube == 0 then
            mines.groveMana = 1
        elseif resourceCube == 1 then
            mines.runicMana = 1
        elseif resourceCube == 2 then
            mines.lifeMana = 1
        elseif resourceCube == 3 then
            mines.deathMana = 1
        end
	elseif race == Race.Elf then
		mines.groveMana = 2
        if resourceCube == 0 then
            mines.lifeMana = 1
        elseif resourceCube == 1 then
            mines.runicMana = 1
        elseif resourceCube == 2 then
            mines.infernalMana = 1
        elseif resourceCube == 3 then
            mines.deathMana = 1
        end
	end
    return mines
end

function getMinesBigZone14(race)
	local mines = {
		gold = 2,
	}
	if race == Race.Human then
		mines.lifeMana = 1
        mines.deathMana = 1
		mines.groveMana = 1
	elseif race == Race.Dwarf then
		mines.runicMana = 1
        mines.lifeMana = 1
        mines.infernalMana = 1
	elseif race == Race.Undead then
		mines.deathMana = 1
        mines.lifeMana = 1
        mines.infernalMana = 1
	elseif race == Race.Heretic then
		mines.lifeMana = 1
        mines.runicMana = 1
        mines.infernalMana = 1
	elseif race == Race.Elf then
        mines.groveMana = 1
        mines.runicMana = 1
        mines.infernalMana = 1
	end
    return mines
end

function getMinesBigZone25(race)
	local mines = {
		    gold = 2,
	}
    if race == Race.Human then
		mines.lifeMana = 1
        mines.runicMana = 1
        mines.infernalMana = 1
	elseif race == Race.Dwarf then
        mines.runicMana = 1
        mines.deathMana = 1
		mines.groveMana = 1
	elseif race == Race.Undead then
        mines.deathMana = 1
        mines.runicMana = 1
        mines.groveMana = 1
	elseif race == Race.Heretic then
        mines.deathMana = 1
        mines.infernalMana = 1
		mines.groveMana = 1
	elseif race == Race.Elf then
		mines.groveMana = 1
        mines.lifeMana = 1
        mines.deathMana = 1
	end
    return mines
end

function getMinesVS(race, race2)
	local mines = {
		gold = 2,
	}
	if race == Race.Human and race2 == Race.Dwarf then
        mines.deathMana = 1
        mines.infernalMana = 1
        mines.groveMana = 1
    elseif race == Race.Dwarf and race2 == Race.Human then
        mines.deathMana = 1
        mines.infernalMana = 1
        mines.groveMana = 1

    elseif race == Race.Human and race2 == Race.Undead then  
        mines.runicMana = 1
        mines.infernalMana = 1
        mines.groveMana = 1
    elseif race == Race.Undead and race2 == Race.Human then 
        mines.runicMana = 1
        mines.infernalMana = 1
        mines.groveMana = 1

    elseif race == Race.Human and race2 == Race.Heretic then  
        mines.runicMana = 1
        mines.deathMana = 1
        mines.groveMana = 1
    elseif race == Race.Heretic and race2 == Race.Human then
        mines.runicMana = 1
        mines.deathMana = 1
        mines.groveMana = 1

    elseif race == Race.Human and race2 == Race.Elf then
        mines.runicMana = 1
        mines.deathMana = 1
        mines.infernalMana = 1
    elseif race == Race.Elf and race2 == Race.Human then
        mines.runicMana = 1
        mines.deathMana = 1
        mines.infernalMana = 1

    elseif race == Race.Dwarf and race2 == Race.Undead then
        mines.infernalMana = 1
        mines.deathMana = 1
        mines.lifeMana = 1
    elseif race == Race.Undead and race2 == Race.Dwarf then
        mines.infernalMana = 1
        mines.deathMana = 1
        mines.lifeMana = 1

    elseif race == Race.Dwarf and race2 == Race.Heretic then
        mines.deathMana = 1
        mines.lifeMana = 1
        mines.groveMana = 1
    elseif race == Race.Heretic and race2 == Race.Dwarf then
        mines.deathMana = 1
        mines.lifeMana = 1
        mines.groveMana = 1

    elseif race == Race.Dwarf and race2 == Race.Elf then
        mines.lifeMana = 1
        mines.deathMana = 1
        mines.infernalMana = 1
    elseif race == Race.Elf and race2 == Race.Dwarf then
        mines.infernalMana = 1
        mines.lifeMana = 1
        mines.deathMana = 1
   
    elseif race == Race.Undead and race2 == Race.Heretic then
        mines.lifeMana = 1
        mines.groveMana = 1
        mines.runicMana = 1
    elseif race == Race.Heretic and race2 == Race.Undead then
        mines.groveMana = 1
        mines.lifeMana = 1
        mines.runicMana = 1

    elseif race == Race.Undead and race2 == Race.Elf then
        mines.runicMana = 1
        mines.infernalMana = 1
        mines.lifeMana = 1
    elseif race == Race.Elf and race2 == Race.Undead then
        mines.runicMana = 1
        mines.infernalMana = 1
        mines.lifeMana = 1
    
    elseif race == Race.Elf and race2 == Race.Heretic then
        mines.deathMana = 1
        mines.lifeMana = 1
        mines.runicMana = 1
    elseif race == Race.Heretic and race2 == Race.Elf then
        mines.deathMana = 1
        mines.lifeMana = 1
        mines.runicMana = 1
	end
    return mines
end

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

function ili(x, y)
    local random = math.random(0,1)
    if random == 0 then 
        return x
    elseif random == 1 then 
        return y
    end
end

function getReward(Type, Zone, playerRace)

local ElexirdotProtection = {
    'g001ig0331', -- poison protection          
    'g001ig0345', -- oslab protection           
    'g001ig0341', -- strah protection           
    'g001ig0329', -- goren protection           
    'g001ig0343', -- zaml protection            150
    'g001ig0327', -- moroz protection           
    'g001ig0335', -- okamen protection          
    'g001ig0337', -- paral protection           
    'g001ig0347', -- -lvl protection            
    'g001ig0339', -- prevras protection         
    'g001ig0353', -- razrush protection         
    'g001ig0351', -- taumat protection          
    'g001ig0349', -- vamp protection            200
}    
local ElexirProtection = {
    'g000ig0022', -- water protection           
    'g000ig0021', -- air protection             
    'g000ig0023', -- earth protection           
    'g000ig0024', -- fire protection            
    'g001ig0125', -- mind protection            
    'g001ig0036', -- death protection           250
}
local Elexir = {
    'g000ig0014', -- +15%dmg                    
    'g000ig0008', -- +15%acc                    
    'g000ig0011', -- +15%ini                    
    'g000ig0002', -- +10arm                     
}
local Elexirt2 = {
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
}
local ElexirPermanent = {
    'g001ig0532', -- +1review                   200
    'g001ig0313', -- +5%dmg                     400
    'g001ig0311', -- +5%acc                     400
    'g001ig0307', -- +5%arm                     400
    'g001ig0315', -- +5%hp                      400
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
local ElexirPermanentT2 = {
    'g001ig0561', -- +25% udar na sebya         600
    'g001ig0523', -- +10%exp                    600 
    'g000ig0004', -- +10arm                     600
    'g001ig0130', -- +22%regen                  700
    'g001ig0548', -- +10%krit                   700
    'g001ig0018', -- +5%regen                   750
    'g001ig0376', -- +30% regen                 1000
    'g001ig0518', -- -15%exp                    1000
    'g001ig0521', -- +20 resist voram           1000
    'g001ig0308', -- +15arm                      1200
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
    'g001ig0025', -- aura +5%hp -10%hp          850
    'g001ig0019', -- aura vampirizm +10%        900
    'g001ig0032', -- aura +5%hp                 1000 
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
    'g001ig0528', -- pohod snaryajenie          600
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
}
local Talismant1 = {
    'g001ig0260', -- трибог 
    'g001ig0269', -- разбойник 
    'g001ig0261',  -- энт малый 
    'g001ig0271',  -- гоблин жгун 
    'g001ig0268',  -- псина
    'g001ig0272' -- эльф-следопыт 
    }
local Talismant2 = {
    'g001ig0267', -- одержимый 
    'g000ig9107', -- зомби 
    'g001ig0265', -- гном 
    'g001ig0264',  -- воин 
    'g001ig0262', -- skelet 
    'g001ig0266', -- kentavr-kopeyschik 
    'g000ig9114', -- ork 
    'g000ig9101' -- сквайр
    }
local scrollT1 = {
    'g001ig0407', -- призыв толстого беса на 2 дня                                      100=
    'g000ig5022', -- обычно ходит по лесу                                               200=
    'g000ig5064', -- -5%ini -5%dmg                                                      200=
    'g000ig5044', -- -5%dmg -5%acc                                                      200=
    'g000ig5021', -- +7arm                                                              200=
    'g001ig0250', -- +7arm                                                              200=
    'g001ig0247', -- -10%acc                                                            200=
    'g001ig0073', -- -10%acc основной атаки                                             200=
    'g000ig5002', -- +10%ini                                                            200=
    'g000ig5106', -- -10%ini                                                            200=
    'g001ig0248', -- -10%ini                                                            200=
    'g000ig5023', -- +10%dmg                                                            200=
    'g000ig5003', -- +10%dmg                                                            200=
    'g000ig5101', -- -10%dmg                                                            200=
    'g000ig5045', -- -10arm                                                             200=
    'g000ig5065', -- -10arm                                                             200=
    'g001ig0252', -- -15arm                                                             200=
    'g000ig5102', -- +15hp                                                              200=
    'g000ig5024', -- 10 magic damage                                                    200=
    'g000ig5043', -- 10 magic damage                                                    200=
    'g000ig5097', -- 10 magic damage                                                    200=
    'g000ig5004', -- 10 magic damage                                                    200=
    'g000ig5062', -- 10 magic damage                                                    200=
    'g000ig5063', -- 15 magic damage                                                    200=
    'g000ig5042', -- призыв фантома адской гончьей                                      200=
    'g000ig5041', -- призыв адской гончьей                                              200=
    'g000ig5025', -- призыв Рух                                                         200=
    'g000ig5061', -- призыв скелета                                                     200=
    'g000ig5098', -- призыв Энта малого                                                 200=
    'g000ig5084', -- устанавливать жезлы                                                200=
    'g001ig0492', -- возможность применять сферы                                        200=
    'g000ig5009', -- открывает участок карты 5x5                                        200=
    'g000ig5007', -- восстанавливает 30 ОЗ                                              200=
    'g000ig5118', -- -3 обзор клетки в области 5х5                                      200=
    'g000ig5119', -- уничтожает жезл                                                    200=
    'g001ig0072', -- лишает резиста к окаменению и полиформу, иммун меняет на рзист     200=
    'g001ig0574', -- лишает резиста к разуму, иммун меняет на резист                    250=
    'g001ig0084', -- создаёт небольшой участок с водой                                  250=
    'g001ig0194', -- +15% к скидке у торговца                                           250=
    'g001ig0573', -- лишает резиста к оружию, иммун меняет на резист                    275=
    'g001ig0255', -- +10%ini +5%dmg                                                     400=
    'g001ig0254', -- +10%acc +10%dmg                                                    400=
    'g000ig5050', -- -15%ini                                                            400=
    'g000ig5049', -- -15%dmg                                                            400=
    'g001ig0253', -- -15%dmg                                                            400=
    'g000ig5069', -- -15%dmg                                                            400=
    'g001ig0256', -- +15%dmg                                                            400=
    'g000ig5020', -- +10%acc +10%dmg +5%ini                                             400=
    'g001ig0568', -- +25% шанса принять атаку на себя вместо поина позади себя          400=
    'g001ig0569', -- +20% опыта за убийство                                             400=
    'g001ig0193', -- +15exp отряду                                                      400=
    'g000ig5030', -- открывает участок карты 7x7                                        400=
    'g000ig5029', -- восстанавливает 40 ОЗ                                              400=
    'g000ig5068', -- окутывает туманом часть карты, защищает от заклов                  400=
    'g000ig5048', -- 25 magic damage                                                    400=
    'g000ig5070', -- 15 magic damage в области                                          400=
    'g000ig5028', -- 25 magic damage                                                    400=
    'g000ig5067', -- 25 magic damage                                                    400=
    'g000ig5104', -- 25 magic damage                                                    400=
    'g000ig5034', -- защищает от понижения урона +10%dmg                                400=
    'g000ig5088', -- увеличивает количество опыта в бою +15%exp                         400=
    'g000ig5107', -- создаёт участок леса 4х4                                           400=
    'g000ig5047', -- призыв фантома Белиарха                                            400=
    'g000ig5046', -- призыв Белиарха                                                    400=
    'g000ig5066', -- призыв Хуорна                                                      400=
    'g000ig5008', -- призыв живого доспеха                                              400=
    'g000ig5103', -- призыв Энта                                                        400=
    'g001ig0249', -- защита от воды                                                     400=
    'g000ig5005', -- защита от воды                                                     400=
    'g000ig5001', -- защита от вохдуха                                                  400=
    'g000ig5010', -- защита от земли                                                    400=
    'g000ig5016', -- защита от огня                                                     400=
    'g001ig0251', -- защита от огня                                                     400=
    'g001ig0123', -- окутывает участок карты                                            400=
    'g001ig0092', -- уничтожает большой участок леса                                    400=
    'g001ig0085', -- создаёт большой участок воды                                       450=
}
local scrollT2 = {
    'g001ig0165', -- лишает возможности использрования свитки посохи и талики           550=
    'g001ig0580', -- лишает резиста к воздуху и РБ, иммун меняет на резист              550=
    'g001ig0577', -- лишает отряд резиста к огню и ожогу, иммум меняет на резист        550=
    'g001ig0576', -- лишает резиста к смерти, вамп и таум, иммун меняет на резист       550=
    'g001ig0578', -- лишает резиста к воде и морозу, иммун меняет на резист             550=
    'g001ig0579', -- лишает резиста к земле и яду, иммун меняет на резист               550=
    'g000ig5012', -- +15arm                                                             550=
    'g000ig5026', -- +15%ini                                                            550=
    'g001ig0572', -- +15%krita                                                          550=
    'g000ig5111', -- -15%acc -10%dmg                                                    550=
    'g000ig5089', -- -15%acc -15%dmg                                                    550=
    'g000ig5013', -- +15%acc +15%dmg                                                    550=
    'g000ig5054', -- 40 magic damage                                                    550=
    'g000ig5109', -- 40 magic damage                                                    550=
    'g000ig5033', -- 40 magic damage                                                    550=
    'g000ig5014', -- 40 magic damage                                                    550=
    'g000ig5072', -- 40 magic damage                                                    550=
    'g000ig5110', -- восстанавливает 60 ОЗ в области                                    550=
    'g000ig5073', -- увеличивает макс HP на 20%                                         550=
    'g000ig5074', -- окутывает пылью часть карты, защищает от заклов                    550=
    'g000ig5052', -- окутывает туманом участок карты                                    550=
    'g001ig0570', -- -25% опыта в области 7х7                                           550=
    'g000ig5040', -- излечивает на 100                                                  550=
    'g000ig5085', -- скидка 20%                                                         550=
    'g000ig5011', -- защита от разума                                                   550=
    'g000ig5018', -- защита от смерти                                                   550=
    'g000ig5079', -- защита от оружия                                                   550=
    'g000ig5059', -- призыв фантома адского мстителя                                    550=
    'g000ig5031', -- призыв Валькирию                                                   550=
    'g000ig5071', -- призыв Кошмара                                                     550=
    'g000ig5108', -- вызов Энта большого                                                550=
}
local scrollT3 = {
    'g000ig5093', -- 40 dms в области                                                   700=
    'g000ig5090', -- 40 dmg в области                                                   700=
    'g000ig5081', -- 40 dms в области                                                   700=
    'g000ig5086', -- 40 dmg в области                                                   700=
    'g000ig5112', -- 40 dmg в области                                                   700=
    -- 'g000ig5077', -- 55 magic damage                                                    700=
    -- 'g000ig5105', -- 55 magic damage                                                    700=
    -- 'g000ig5056', -- 55 magic damage                                                    700=
    -- 'g000ig5037', -- 55 magic damage                                                    700=
    'g000ig5114', -- -30arm                                                             700=
    'g000ig5035', -- +23%arm                                                            700=
    'g000ig5055', -- -33%acc                                                            700=
    'g000ig5076', -- -33%dmg                                                            700=
    'g000ig5115', -- -33%dmg                                                            700=
    'g000ig5017', -- +33%dmg                                                            700=
    'g000ig5036', -- +33%dmg                                                            700=
    'g000ig5082', -- +20%hp +7arm                                                       700=
    'g000ig5116', -- +50hp                                                              700=
    'g000ig5075', -- -33%ini отряду                                                     700=
    'g000ig5113', -- +20% очков пердвижения в области 3x3                               700=
    -- 'g000ig5060', -- 70 magic dmg                                                       700=
    -- 'g000ig5080', -- 70 magic dmg                                                       700=
    -- 'g000ig5019', -- 70 magic dmg                                                       700=
    'g000ig5091', -- -33%ini в области                                                  700=
    'g001ig0586', -- лишается неподкупности и теряет 20% сопротивления ворам            700=
    'g000ig5039', -- неподкупность                                                      700=
    'g000ig5057', -- защита от полиформа                                                700=
    -- 'g000ig5120', -- мгновенное отступление                                             700=
    -- 'g001ig0094', -- мгновенное отступление                                             700=
    -- 'g000ig5015', -- вызов Голема                                                       700=
    -- 'g000ig5038', -- вызов каменного предка                                             700=
    -- 'g000ig5058', -- вызов адского Мстителя                                             700=
    -- 'g000ig5117', -- вызов Верданта                                                     700=
    -- 'g000ig5078', -- вызов Танатоса                                                     700=
    -- 'g001ig0080', -- вызов Вестника немощи                                              700=
    -- 'g001ig0081', -- вызов Вестника Перемен                                             700=
    -- 'g001ig0079', -- вызов Вестника поглощения                                          700=
}
-- local scrollT4 = {
    -- 'g001ig0171', -- все отряды получают 25% от нанесённого урона в виде здоровья       1000=
    -- 'g001ig0160', -- защита от воды для всех отрядов                                    1000=
    -- 'g001ig0159', -- защита от воздуха для всех отрядов                                 1000=
    -- 'g001ig0161', -- защите от земли для всех отрядов                                   1000=
    -- 'g001ig0163', -- защита от огня для всех отрядов                                    1000=
    -- 'g001ig0162', -- защита от разума для всех отрядов                                  1000=
    -- 'g001ig0166', -- +20ini всем отрядам                                                1000=
    -- 'g001ig0169', -- +20%acc всем отрядам                                               1000=
    -- 'g001ig0168', -- на 20% меньше повреждений всем отрядам                             1000=
    -- 'g001ig0167', -- на 20% больше повреждение всем отрядам                             1000=
    -- 'g001ig0170', -- +50hp всем отрядам                                                 1500=
-- }

local weakOrbs = { 
    'g000ig9019', -- voskres
    'g001ig0189', -- 50dmg
    'g000ig9017', -- 30hp heal
    'g000ig9033', -- 20 dlit urona poison
    'g001ig0299', -- 25 dmg fire
    'g001ig0453', -- 50hp heal ryadu
    'g001ig0301', -- 25dmg 
    'g001ig0304', -- 25dmg
    'g001ig0303', -- 25 dmg
    'g001ig0479', -- 40dot gorenie dvun unit d ryadu
    'g000ig9041', -- 35 dot gorenie
    'g000ig9038', -- 35 dot moroz
    'g001ig0300', -- 25 dmg
    'g001ig0302', -- 25dmg
    'g000ig9034', -- 35dmg unit
    'g000ig9024', -- 35hp vamp iz otryada
    'g001ig0471', -- 40dmg dvum kolonnam
    'g001ig0470', -- 40dmg unit+2
    'g001ig0456', -- 40dmg moroz 2x2
    'g001ig0458', -- 35dmg poison krrestom
    'g001ig0466', -- 40dmg water v shahmatnom poryadke
    'g001ig0457', -- 40dmg goren neprikrit i s shansom 50% prikrit
    'g001ig0192', -- 50dmg
    'g001ig0191', -- 50
    'g001ig0478', -- 40dot moroz dvun unit d ryadu
    'g001ig0489', -- 30dmg
    'g001ig0187', -- 50dmg
    'g001ig0469', -- 40dmg lubomu ryadu
    'g001ig0468', -- 40dmg v vide kresta
    'g001ig0480', -- 40dot poison dvun unit d ryadu
    'g001ig0188', -- 50dmg
    'g001ig0190', -- 50
    'g000ig9036', -- 35dmg
    'g001ig0467' -- 40dmg unit+2
}
local mediumOrbs = { 
    'g001ig0475', -- 60dmg neprikrit
    'g001ig0476', -- 60dmg dvun unit d ryadu 
    'g001ig0455', -- 100 heal krestom
    'g001ig0472', -- 60dmg 2 kilon
    'g001ig0454', -- 75heal 2x2
    'g001ig0473', -- 60dmg 2x2
    'g001ig0474', -- 60dmg shahmat
    'g000ig9029', -- 75dmg
    'g000ig9016', -- 150heal
    'g001ig0444', -- +30 arm 2x2
    'g001ig0459', -- -50%ini dvuh unit v 1 ryadu 
    'g001ig0450', -- +30% dmg 2x2
    'g000ig9042', -- -33% dmg na nesk hodov
    'g001ig0461', -- -33% dmg dvuh unit v 1 ryadu
    'g001ig0183', -- 20 razr arm otryadu
    'g001ig0477', -- 60dmg ryadu
    'g000ig9020', -- dlit uvelich uron yf 25%
    'g001ig0056', -- ward water all
    'g001ig0054', -- air
    'g001ig0055', -- earth
    'g001ig0053', -- fire
    'g001ig0058', -- razum
    'g001ig0057' -- death
}
local strongOrbs = {  
    'g000ig9014', -- zamedl 50%
    'g001ig0447', -- 60% vamp
    'g001ig0462', -- oslab 50% na 2 unit
    'g000ig9043' --
}


local smallValuable = { 'g000ig7001', 'g001ig0431', 'g000ig7002' }
local mediumValuable = { 'g001ig0433', 'g001ig0432', 'g000ig7004', 'g000ig7003' }
local bigValuable = { 'g000ig7007', 'g000ig7008', 'g000ig7005', 'g000ig7006' }

local smallballmana = { 'g001ig0481', 'g001ig0485', 'g001ig0482', 'g001ig0483', 'g001ig0484', 'g001ig0486' }
local mediumballmana = { 'g001ig0146', 'g001ig0150', 'g001ig0147', 'g001ig0148', 'g001ig0149', 'g001ig0151' }
local bigballmana = { 'g001ig0277', 'g001ig0281', 'g001ig0278', 'g001ig0279', 'g001ig0280', 'g001ig0282' }

local ArtT1 = {'g001ig0611', 'g001ig0418', 'g000ig2001', 'g000ig2002', 'g000ig3001', 'g001ig0100', 'g001ig0182' }
local ArtT2 = { 'g001ig0582',  'g001ig0558', 'g001ig0557', 'g001ig0559', 'g001ig0594','g000ig3017', 'g001ig0487', 'g001ig0589' }
local ArtT3 = { 'g001ig0048', 'g000ig3002',  'g001ig0155', 'g001ig0042', 'g001ig0045', 'g000ig2003', 'g001ig0040', 'g001ig0047', 'g001ig0416', 'g001ig0591', 'g000ig3003',
                    'g001ig0173', 'g001ig0417', 'g001ig0196',  'g000ig9137', 'g001ig0197', 'g001ig0604' }
local ArtT4 = { 'g001ig0124', 'g001ig0612', 'g001ig0585', 'g001ig0046', 'g001ig0592', 'g000ig2004', 'g001ig0060', 'g001ig0041', 'g001ig0590', 'g001ig0039',
                    'g001ig0071', 'g001ig0174', 'g001ig0411', 'g000ig3019', 'g000ig3006', 'g001ig0488', 'g001ig0413', 'g001ig0415', 'g000ig3004','g000ig9035'}
local ArtT5 = { 'g001ig0179', 'g001ig0410', 'g000ig3018', 'g001ig0102', 'g001ig0412', 'g001ig0414', 'g000ig2005', 'g001ig0043' }

local JewelT1 = { 'g001ig0101', 'g000ig4008', 'g000ig3008', 'g001ig0428', 'g000ig4006', 'g001ig0494', 'g000ig4004', 'g001ig0495', 'g001ig0497', 'g000ig4003', 'g000ig4005',
                    'g000ig4001', 'g000ig4002', 'g001ig0493' }
local JewelT2 = { 'g001ig0421', 'g001ig0420', 'g001ig0422', 'g001ig0423', 'g000ig4007', 'g001ig0427', 'g001ig0099', 'g001ig0430', 'g001ig0539', 'g000ig3020' }
local JewelT3 = { 'g001ig0037', 'g001ig0424', 'g001ig0425', 'g001ig0597', 'g000ig3022', 'g001ig0610', 'g001ig0156' }
local JewelT4 = { 'g001ig0104', 'g001ig0605', 'g000ig7010', 'g000ig3005', 'g001ig0596', 'g001ig0429', 'g001ig0116', 'g001ig0038','g001ig0419' }

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
}
local BannerT4 = { 
    'g001ig0153', -- 25%vamp                           1500
    'g001ig0144', -- weapon protection                 1500
    'g001ig0052', -- +50hp                             1500
    'g001ig0366', -- taumaturgiya protection +25%vamp  1700
    'g001ig0360' -- +15%vamp +10%dmg                   1300
}
local TravelT1 = { 
    'g001ig0108', -- water protection + 15hp 300
    'g001ig0107', -- air protection + 15hp 300
    'g001ig0105', -- fire protection + 15hp 300
    'g001ig0109', -- death protection + 15hp 300
    'g001ig0106', -- earth protection + 15hp 300
    'g001ig0113', -- +7arm +10hp 300
}
local TravelT2 = {
    'g001ig0111', -- +11%ini +15%dmg 500
    'g000ig1010', -- +2moov, walk in the forest, +10%dmg +10%acc if in forest   700
    'g000ig8003', -- +4moov                                                     700
    'g001ig0606', -- +2moov +10%regen +4moov if on homeland                     1000
}
local TravelT3 = {
    'g000ig8004',
    'g001ig0114', -- +11arm +15hp 500
    'g001ig0115', -- +15arm +20hp 1100
    'g001ig0112', -- +15%ini +20%dmg 800
    
}
local wand = {'g000ig6007', 'g000ig6006', 'g001ig0392', 'g001ig0391', 'g000ig6003', 'g001ig0399', 'g000ig6012', 'g000ig6001', 'g001ig0401', 'g001ig0394', 'g001ig0397', 'g001ig0402', 'g000ig6020', 'g000ig6015'}

local rewardItems = { }

if Type == 'town' and Zone == 'StartZonet1' then
    table.insert(rewardItems, { id = 'g001ig0180', min = 2, max = 3}) -- heal 25
    table.insert(rewardItems, { id = 'g000ig0005', min = 2, max = 2}) -- heal 50
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, { id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, { id = Talismant2[math.random(#Talismant2)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'townt1' then
    table.insert(rewardItems, { id = 'g000ig0005', min = 2, max = 2 })
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 }) 
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 }) 
    table.insert(rewardItems, { id = Talismant1[math.random(#Talismant1)], min = 1, max = 1})


elseif Type == 'town' and Zone == 'StartZonet2' then
    table.insert(rewardItems, { id = 'g001ig0180', min = 1, max = 2 } ) -- heal 25
    table.insert(rewardItems, { id = 'g000ig0001', min = 1, max = 2 } ) -- res
    table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 2 } ) -- heal 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = 'g001ig0151', min = 1, max = 1 } ) -- 100 any mana
    table.insert(rewardItems, { id = 'g001ig0095', min = 1, max = 1 } ) -- возможность устанавливать жезлы
    table.insert(rewardItems, { id = ArtT1[math.random(#ArtT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } ) 
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1 } )
elseif Type == 'guard' and Zone == 'townt2' then
    table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 2 } ) -- heal 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } ) 

elseif Type == 'ruinst1' and Zone == 'StartZone' then
    table.insert(rewardItems, ili({id = JewelT1[math.random(#JewelT1)], min = 1, max = 1 }, { id = BannerT1[math.random(#BannerT1)], min = 1, max = 1 }))

elseif Type == 'ruinst2' and Zone == 'StartZone' then
    table.insert(rewardItems, ili({id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1 }, { id = TravelT1[math.random(#TravelT1)], min = 1, max = 1 }))

elseif Type == 'guard' and Zone == 'BigZone25' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res 
    table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 2 } ) -- heal 75 
    table.insert(rewardItems, { id = 'g000ig0018', min = 1, max = 1 } ) -- heal 200
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, ili({ id = TravelT2[math.random(#TravelT2)], min = 1, max = 1 }, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1 }))
    table.insert(rewardItems, ili({ id = 'g001ig0560', min = 1, max = 1 }, { id = 'g001ig0547', min = 1, max = 1 }))
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 })
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 })
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 })
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 })
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1 })
    table.insert(rewardItems, { id = Talismant2[math.random(#Talismant2)], min = 1, max = 1 })


elseif Type == 'townt3' and Zone == 'BigZone25' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res
    table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 2 } ) -- heal 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 1, max = 1 } ) -- heal 200
    table.insert(rewardItems, { id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1}) 
    table.insert(rewardItems, ili({ id = JewelT2[math.random(#JewelT2)], min = 1, max = 1 }, { id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 }))
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1})
    table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'BZ25townt3' then
    table.insert(rewardItems, { id = 'g000ig0005', min = 2, max = 2}) -- heal 50
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2}) -- heal 100
    table.insert(rewardItems, { id = wand[math.random(#wand)], min = 1, max = 1}) --
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})


elseif Type == 'townt4' and Zone == 'BigZone25' then
    if playerRace == Race.Human then
        table.insert(rewardItems, {id = 'g001ig0146', min = 1, max = 1}) 
    elseif playerRace == Race.Elf then
        table.insert(rewardItems, {id = 'g001ig0150', min = 1, max = 1})
    elseif playerRace == Race.Heretic then
        table.insert(rewardItems, {id = 'g001ig0147', min = 1, max = 1})
    elseif playerRace == Race.Dwarf then
        table.insert(rewardItems, {id = 'g001ig0148', min = 1, max = 1})
    elseif playerRace == Race.Undead then
        table.insert(rewardItems, {id = 'g001ig0149', min = 1, max = 1})
    end
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 }) -- res
    table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 2 }) -- heal 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 }) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 1, max = 1 }) -- heal 200
    table.insert(rewardItems, ili({ id = JewelT2[math.random(#JewelT2)], min = 1, max = 1 }, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1 }))
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1})
    table.insert(rewardItems, { id = bigValuable[math.random(#bigValuable)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'BZ25townt4' then
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 1, max = 1 } ) -- heal 200
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})

elseif Type == 'ruinst3' and Zone == 'BigZone25' then
    table.insert(rewardItems, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1 } )
elseif Type == 'ruinst4' and Zone == 'BigZone25' then
    table.insert(rewardItems, { id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 } )

elseif Type == 'guard' and Zone == 'BigZone14' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2}) -- res  
    table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 2}) -- heal 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2}) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 1, max = 1}) -- heal 200
    table.insert(rewardItems, ili( { id = TravelT3[math.random(#TravelT3)], min = 1, max = 1 }, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1}))
    table.insert(rewardItems, ili({ id = 'g001ig0560', min = 1, max = 1 }, { id = 'g001ig0547', min = 1, max = 1 }))
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})    
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1}) 
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1}) 
    table.insert(rewardItems, { id = Talismant2[math.random(#Talismant2)], min = 1, max = 1})
 



elseif Type == 'townt3' and Zone == 'BigZone14' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 2}) -- res
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2}) -- heal 100
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1}) -- heal 200
    table.insert(rewardItems, {id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1}) 
    table.insert(rewardItems, ili({ id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 }, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1}))
    table.insert(rewardItems, {id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'BZ14townt3' then
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2}) -- heal 50
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2}) -- heal 100
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
 

elseif Type == 'townt4' and Zone == 'BigZone14' then
    if playerRace == Race.Human then
        table.insert(rewardItems, {id = 'g001ig0146', min = 1, max = 1})
    elseif playerRace == Race.Elf then
        table.insert(rewardItems, {id = 'g001ig0150', min = 1, max = 1})
    elseif playerRace == Race.Heretic then
        table.insert(rewardItems, {id = 'g001ig0147', min = 1, max = 1})
    elseif playerRace == Race.Dwarf then
        table.insert(rewardItems, {id = 'g001ig0148', min = 1, max = 1})
    elseif playerRace == Race.Undead then
        table.insert(rewardItems, {id = 'g001ig0149', min = 1, max = 1})
    end
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 2}) -- res
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2}) -- heal 100
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1}) -- heal 200
    table.insert(rewardItems, {id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1}) 
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 2})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})        
    table.insert(rewardItems, ili({id = JewelT2[math.random(#JewelT2)], min = 1, max = 1}, {id = ArtT2[math.random(#ArtT2)], min = 1, max = 1}))
elseif Type == 'guard' and Zone == 'BZ14townt4' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2}) -- heal 100
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1}) -- heal 200
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})

elseif Type == 'ruinst3' and Zone == 'BigZone14' then
    table.insert(rewardItems, { id = ArtT3[math.random(#ArtT3)], min = 1, max = 1 } )
elseif Type == 'ruinst4' and Zone == 'BigZone14' then
    table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1 } )


elseif Type == 'townt4' and Zone == 'VSZone' then
    table.insert(rewardItems, { id = 'g000ig0006', min = 3, max = 3 } ) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
    table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT3[math.random(#scrollT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ProtectPermanent[math.random(#ProtectPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1 } ) 
elseif Type == 'guard' and Zone == 'vstownt4' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res
    table.insert(rewardItems, { id = 'g001ig0152', min = 2, max = 2 } ) -- heal 300
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1 } )


elseif Type == 'townt5' and Zone == 'VSZone' then
    table.insert(rewardItems, { id = 'g001ig0152', min = 2, max = 3 } ) -- heal 300
    table.insert(rewardItems, { id = 'g000ig0006', min = 3, max = 3 } ) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
    table.insert(rewardItems, { id = ArtT4[math.random(#ArtT4)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } ) 
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT3[math.random(#scrollT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ProtectPermanent[math.random(#ProtectPermanent)], min = 1, max = 1 } )
elseif Type == 'guard' and Zone == 'vstownt5' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res
    table.insert(rewardItems, { id = 'g001ig0152', min = 2, max = 2 } ) -- heal 300
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 2, max = 2 } ) -- heal 200
    table.insert(rewardItems, { id = scrollT3[math.random(#scrollT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1 } )








elseif Type == 'ruins' and Zone == 'VSZonet4' then
    table.insert(rewardItems, { id = JewelT4[math.random(#JewelT4)], min = 1, max = 1 } )
elseif Type == 'ruins' and Zone == 'VSZonet5' then
    table.insert(rewardItems, { id = BannerT4[math.random(#BannerT4)], min = 1, max = 1 } )





elseif Type == 'guard' and Zone == 'GO' then
    table.insert(rewardItems, ili ( { id = ArtT4[math.random(#ArtT4)], min = 1, max = 1 }, { id = ArtT5[math.random(#ArtT5)], min = 1, max = 1 } ) )
    table.insert(rewardItems, ili ( { id = BannerT4[math.random(#BannerT4)], min = 1, max = 1 }, { id = JewelT4[math.random(#JewelT4)], min = 1, max = 1 } ) )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT3[math.random(#scrollT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res
    table.insert(rewardItems, { id = 'g001ig0152', min = 2, max = 2 } ) -- heal 300
    table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT3[math.random(#scrollT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1 } )



elseif Type == 'stack1' and Zone == 'startZone' then
    table.insert(rewardItems, { id = 'g001ig0180', min = 3, max = 3 } ) -- heal 25
    table.insert(rewardItems, { id = 'g000ig0005', min = 4, max = 5 } ) -- heal 50
    table.insert(rewardItems, { id = smallValuable[math.random(#smallValuable)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = smallballmana[math.random(#smallballmana)], min = 1, max = 1 } )
elseif Type == 'stack2' and Zone == 'startZone' then
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 3 } ) -- heal 75
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
elseif Type == 'stack3' and Zone == 'startZone' then
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
elseif Type == 'stack4' and Zone == 'startZone' then
    table.insert(rewardItems, { id = 'g000ig0005', min = 2, max = 2 } ) -- heal 50
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )


elseif Type == 'stack1' and Zone == 'BigZone' then
    table.insert(rewardItems, { id = 'g000ig0005', min = 1, max = 1 } ) -- heal 50
	table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 2 } ) -- heal 75
	table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = smallValuable[math.random(#smallValuable)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = smallballmana[math.random(#smallballmana)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )

elseif Type == 'stack2' and Zone == 'BigZone' then
	table.insert(rewardItems, { id = 'g000ig0005', min = 3, max = 3 } ) -- heal 50
    table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 2 } ) -- heal 75
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
	table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )

elseif Type == 'stack3' and Zone == 'BigZone' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 1, max = 2 } ) -- res
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )

elseif Type == 'stack4' and Zone == 'BigZone' then
    table.insert(rewardItems, { id = 'g000ig0005', min = 2, max = 2 } ) -- heal 50
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 1, max = 1 } ) -- heal 200
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
	table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )

elseif Type == 'stack5' and Zone == 'BigZone' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res
    table.insert(rewardItems, { id = 'g000ig0005', min = 1, max = 1 } ) -- heal 50
    table.insert(rewardItems, { id = 'g000ig0018', min = 1, max = 1 } ) -- heal 200
    table.insert(rewardItems, { id = Talismant2[math.random(#Talismant2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
	table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT1[math.random(#ArtT1)], min = 1, max = 1 } )


elseif Type == 'stackt4' and Zone == 'VSZone' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2}) -- res
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2}) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 1, max = 1}) -- heal 200
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT3[math.random(#ArtT3)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})

elseif Type == 'stackt5' and Zone == 'VSZone' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2}) -- res
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2}) -- heal 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 1, max = 1}) -- heal 200
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1})




elseif Type == 'bags' and Zone == 'startZone' then 
    table.insert(rewardItems, { id = 'g001ig0180', min = 4, max = 6 } ) -- heal 25
    table.insert(rewardItems, { id = 'g000ig0005', min = 2, max = 3 } ) -- heal 50
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 3 } ) -- хил 100
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Talismant1[math.random(#Talismant1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = 'g001ig0486', min = 1, max = 1 } ) -- mana all 50

elseif Type == 'bags' and Zone == 'BigZone' then
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = 'g000ig0001', min = 4, max = 4 } ) -- res
    table.insert(rewardItems, { id = 'g001ig0378', min = 3, max = 4 } ) -- хил 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 4, max = 4 } ) -- хил 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 4, max = 4 } ) -- хил 200
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1 } )


elseif Type == 'bags' and Zone == 'VSZone' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 4, max = 5 } ) -- res
    table.insert(rewardItems, { id = 'g001ig0378', min = 4, max = 4 } ) -- хил 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 4, max = 4 } ) -- хил 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 4, max = 4 } ) -- хил 200        
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = bigballmana[math.random(#bigballmana)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT3[math.random(#scrollT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT3[math.random(#scrollT3)], min = 1, max = 1 } )


elseif Type == 'merchants' and Zone == 'startZone' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 2, max = 2 } ) -- res
    table.insert(rewardItems, { id = 'g000ig0005', min = 3, max = 3 } ) -- heal 50
    table.insert(rewardItems, { id = 'g001ig0378', min = 2, max = 2 } ) -- хил 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 2, max = 2 } ) -- хил 100
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Talismant1[math.random(#Talismant1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Talismant1[math.random(#Talismant1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Talismant2[math.random(#Talismant2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Talismant2[math.random(#Talismant2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Permanentskill[math.random(#Permanentskill)], min = 1, max = 1 } )

elseif Type == 'merchants' and Zone == 'BigZone14' then
    table.insert(rewardItems, ili( { id = 'g001ig0375', min = 1, max = 1 }, { id = 'g001ig0500', min = 1, max = 1 })) -- znamya naslediya ili znamya padshego hranitelya
    table.insert(rewardItems, { id = 'g000ig0001', min = 4, max = 4}) -- res
    table.insert(rewardItems, { id = 'g000ig0005', min = 4, max = 4}) -- heal 50
    table.insert(rewardItems, { id = 'g001ig0378', min = 4, max = 4}) -- хил 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 4, max = 4}) -- хил 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 4, max = 4}) -- хил 200
    table.insert(rewardItems, { id = 'g001ig0522', min = 1, max = 1}) -- nepodkupnost
    table.insert(rewardItems, { id = ArtT3[math.random(#ArtT3)], min = 1, max = 1})
    table.insert(rewardItems, { id = ArtT3[math.random(#ArtT3)], min = 1, max = 1})
    table.insert(rewardItems, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ArtT1[math.random(#ArtT1)], min = 1, max = 1})
    table.insert(rewardItems, { id = BannerT3[math.random(#BannerT3)], min = 1, max = 1 })
    table.insert(rewardItems, { id = BannerT3[math.random(#BannerT3)], min = 1, max = 1 })
    table.insert(rewardItems, { id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 })
    table.insert(rewardItems, { id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 })
    table.insert(rewardItems, { id = BannerT1[math.random(#BannerT1)], min = 1, max = 1 })
    table.insert(rewardItems, { id = TravelT3[math.random(#TravelT3)], min = 1, max = 1 })
    table.insert(rewardItems, { id = TravelT2[math.random(#TravelT2)], min = 1, max = 1 })
    table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1})
    table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1})
    table.insert(rewardItems, { id = JewelT2[math.random(#JewelT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = JewelT2[math.random(#JewelT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = JewelT1[math.random(#JewelT1)], min = 1, max = 1})
    table.insert(rewardItems, { id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ProtectPermanent[math.random(#ProtectPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ProtectPermanent[math.random(#ProtectPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = Permanentskill[math.random(#Permanentskill)], min = 1, max = 1})

elseif Type == "merchants" and Zone == "BigZone25" then
    table.insert(rewardItems, { id = 'g000ig0001', min = 4, max = 4 } ) -- res
    table.insert(rewardItems, { id = 'g000ig0005', min = 4, max = 4 } ) -- heal 50
    table.insert(rewardItems, { id = 'g001ig0378', min = 4, max = 4 } ) -- хил 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 4, max = 4 } ) -- хил 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 4, max = 4 } ) -- хил 200
    table.insert(rewardItems, { id = ArtT3[math.random(#ArtT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT3[math.random(#ArtT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT1[math.random(#ArtT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = BannerT3[math.random(#BannerT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = BannerT3[math.random(#BannerT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = BannerT1[math.random(#BannerT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = TravelT3[math.random(#TravelT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = TravelT2[math.random(#TravelT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT2[math.random(#JewelT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT2[math.random(#JewelT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT1[math.random(#JewelT1)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ProtectPermanent[math.random(#ProtectPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ProtectPermanent[math.random(#ProtectPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = Permanentskill[math.random(#Permanentskill)], min = 1, max = 1})


elseif Type == 'merchants' and Zone == 'VSZone' then
    table.insert(rewardItems, { id = 'g000ig0001', min = 4, max = 4 } ) -- res
    table.insert(rewardItems, { id = 'g000ig0005', min = 4, max = 4 } ) -- heal 50
    table.insert(rewardItems, { id = 'g001ig0378', min = 4, max = 4 } ) -- хил 75
    table.insert(rewardItems, { id = 'g000ig0006', min = 4, max = 4 } ) -- хил 100
    table.insert(rewardItems, { id = 'g000ig0018', min = 4, max = 4 } ) -- хил 200
    table.insert(rewardItems, { id = ArtT5[math.random(#ArtT5)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT5[math.random(#ArtT5)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT4[math.random(#ArtT4)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT4[math.random(#ArtT4)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT3[math.random(#ArtT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ArtT2[math.random(#ArtT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = BannerT4[math.random(#BannerT4)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = BannerT4[math.random(#BannerT4)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = BannerT3[math.random(#BannerT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = BannerT3[math.random(#BannerT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = TravelT3[math.random(#TravelT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = TravelT3[math.random(#TravelT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = TravelT2[math.random(#TravelT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT4[math.random(#JewelT4)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT4[math.random(#JewelT4)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT3[math.random(#JewelT3)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = JewelT2[math.random(#JewelT2)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ProtectPermanent[math.random(#ProtectPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = ProtectPermanent[math.random(#ProtectPermanent)], min = 1, max = 1 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = Elexir[math.random(#Elexir)], min = 1, max = 2 } )
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirdotProtection[math.random(#ElexirdotProtection)], min = 1, max = 1})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = Elexirt2[math.random(#Elexirt2)], min = 1, max = 2})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanent[math.random(#ElexirPermanent)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = ElexirPermanentT2[math.random(#ElexirPermanentT2)], min = 1, max = 1})
    table.insert(rewardItems, { id = Permanentskill[math.random(#Permanentskill)], min = 1, max = 1})
    table.insert(rewardItems, ili( { id = 'g001ig0368', min = 1, max = 1 }, { id = 'g001ig0356', min = 1, max = 1 } ) ) -- znamya ot obichnogo urona ili zelie ot obichnogo urona
    table.insert(rewardItems, { id = 'g001ig0565', min = 1, max = 1 } ) -- aura +5% krit vsem
    end

    return rewardItems
end


function getStack(tier, stackCount, itemsTable)
    local squad = { }
    if (tier == 1) then squad = Squad1
    elseif (tier == 2 or tier == 3) then squad = Squad2
    elseif (tier == 4) then squad = Squad3
    elseif (tier == 5) then squad = Squad4
    end
    local expValueStack = { }
    if (tier == 1) then
        expValueStack.min = 210 * stackCount
        expValueStack.max = 270 * stackCount
    elseif (tier == 2) then
        expValueStack.min = 270 * stackCount
        expValueStack.max = 350 * stackCount
    elseif (tier == 3) then
        expValueStack.min = 350 * stackCount
        expValueStack.max = 480 * stackCount
    elseif (tier == 4) then
        expValueStack.min = 500 * stackCount
        expValueStack.max = 860 * stackCount
    elseif (tier == 5) then
        expValueStack.min = 880 * stackCount
        expValueStack.max = 1640 * stackCount
    end
    return {
        count = stackCount,
        subraceTypes = squad,
        value = expValueStack,
        loot = {
            items = itemsTable
        }
    }
end

function getGuard(tier, itemsTable)
    local squad = { }
    if (tier == 1) then squad = Squad1
    elseif (tier == 2 or tier == 3) then squad = Squad2
    elseif (tier == 4) then squad = Squad3
    elseif (tier == 5) then squad = Squad4
    elseif (tier == 6) then squad = SquadGO
    end

    local expValueGuard = { }
    if (tier == 1) then
        expValueGuard.min = 220
        expValueGuard.max = 330
    elseif (tier == 2) then
        expValueGuard.min = 340
        expValueGuard.max = 460
    elseif (tier == 3) then
        expValueGuard.min = 460
        expValueGuard.max = 690
    elseif (tier == 4) then
        expValueGuard.min = 710
        expValueGuard.max = 940
    elseif (tier == 5) then
        expValueGuard.min = 940
        expValueGuard.max = 1180
    elseif (tier == 6) then
        expValueGuard.min = 1100
        expValueGuard.max = 1850
    end
    return {
        subraceTypes = squad,
        value = expValueGuard,
        loot = {
            items = itemsTable
        }
    }
end

function getTown(townTier, getGuard, itemsTable)
    local expValue = { }
    if ( townTier == 1 ) then
        expValue.min = 240 * 1.1
        expValue.max = 340 * 1.1
    elseif ( townTier == 2) then
        expValue.min = 340 * 1.1
        expValue.max = 460 * 1.1
    elseif ( townTier == 3) then
        expValue.min = 460 * 1.1
        expValue.max = 690 * 1.1
    elseif ( townTier == 4) then
        expValue.min = 700 * 1.1
        expValue.max = 980 * 1.1
    elseif ( townTier == 5) then
        expValue.min = 920 * 1.1
        expValue.max = 1360 * 1.1
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
            loot = {items = itemsTable}},
        stack = getGuard
    }
end

function getRuins(ruinsGold, GuardRuins, ruinsItem)
    return {
        gold = ruinsGold,
        guard = GuardRuins,
        loot = {
            items = ruinsItem,
        }
    }
end

function getGuardRuins(tier)
    local squadStack = { }
    if (tier == 1) then squadStack = Squad1
    elseif (tier == 2 or tier == 3) then squadStack = Squad2
    elseif (tier == 4) then squadStack = Squad3
    elseif (tier == 5) then squadStack = Squad4
    elseif (tier == 6) then squadStack = SquadGO
    end
    local expValueGuard = { }
    if (tier == 1) then
        expValueGuard.min = 200
        expValueGuard.max = 260
    elseif (tier == 2) then
        expValueGuard.min = 240
        expValueGuard.max = 320
    elseif (tier == 3) then
        expValueGuard.min = 320
        expValueGuard.max = 490
    elseif (tier == 4) then
        expValueGuard.min = 510
        expValueGuard.max = 780
    elseif (tier == 5) then
        expValueGuard.min = 800
        expValueGuard.max = 1190
    elseif (tier == 6) then
        expValueGuard.min = 1100
        expValueGuard.max = 1750
    end
    return {
        subraceTypes = squadStack,
        value = expValueGuard,
    }
end

function getBags(countBags, itemsBags)
    return {
            count = countBags,
            loot = {
                items = itemsBags,
            },
        }
end

function getMagicTower(tier, GuardTower)

    local spellt1dmg = {'g000ss0043', 'g000ss0024', 'g000ss0097', 'g000ss0004', 'g000ss0062'}
    local spellt2dmg = {'g000ss0048', 'g000ss0028', 'g000ss0104', 'g000ss0067', 'g000ss0070'}
    local spellt3dmg = {'g000ss0054', 'g000ss0109', 'g000ss0014', 'g000ss0033', 'g000ss0072'}
    local spellt1 = {'g000ss0007', 'g000ss0009', 'g000ss0126', 'g000ss0025', 'g000ss0022', 'g000ss0041', 'g000ss0042', 'g000ss0061', 'g000ss0098', 'g000ss0102'}
    local spellt2 = {'g000ss0001', 'g000ss0005', 'g000ss0008', 'g000ss0016', 'g000ss0010', 'g000ss0197', 'g000ss0034', 'g000ss0029', 'g000ss0184', 'g000ss0198', 'g000ss0046', 'g000ss0047', 'g000ss0176',
                        'g000ss0187', 'g000ss0066', 'g000ss0103', 'g000ss0069', 'g000ss0183', 'g000ss0186', 'g000ss0182', 'g000ss0068'}
    local spellt3 = {'g000ss0052', 'g000ss0127', 'g000ss0089', 'g000ss0199', 'g000ss0175', 'g000ss0026', 'g000ss0166', 'g000ss0011', 'g000ss0018', 'g000ss0085', 'g000ss0209',
                        'g000ss0201', 'g000ss0111', 'g000ss0205', 'g000ss0073', 'g000ss0012', 'g000ss0013', 'g000ss0074', 'g000ss0208'}
    local spellt4 = {'g000ss0206', 'g000ss0091', 'g000ss0055', 'g000ss0036', 'g000ss0082', 'g000ss0116', 'g000ss0076', 'g000ss0114', 'g000ss0017', 'g000ss0207', 'g000ss0115',
                        'g000ss0158', 'g000ss0202', 'g000ss0203', 'g000ss0035', 'g000ss0075'}
    local SpellList = { }

    if tier == 1 then
        table.insert(SpellList, 'g000ss0002')
        table.insert(SpellList, ili(ili('g000ss0003', 'g000ss0023'), 'g000ss0101')) -- +10%dmg
        table.insert(SpellList, ili(ili('g000ss0021', 'g000ss0181'), ili('g000ss0045', 'g000ss0065'))) -- +7%arm -10%arm
        table.insert(SpellList, ili('g000ss0044', 'g000ss0064')) -- -5%dmg -5%acc ili -5%dmg -5%ini
        table.insert(SpellList, ili(ili('g000ss0178', 'g000ss0134'), ili('g000ss0106', 'g000ss0179'))) -- -10%acс ili -10%ini
        table.insert(SpellList, ili('g000ss0191', 'g000ss0192')) -- сферы в бою
        table.insert(SpellList, spellt1dmg[math.random(#spellt1dmg)])
        table.insert(SpellList, spellt1dmg[math.random(#spellt1dmg)])
        table.insert(SpellList, spellt1[math.random(#spellt1)])
        table.insert(SpellList, spellt2[math.random(#spellt2)])
        table.insert(SpellList, spellt2[math.random(#spellt2)])
        table.insert(SpellList, spellt3[math.random(#spellt3)])
    elseif tier == 2 then
        table.insert(SpellList, spellt1dmg[math.random(#spellt1dmg)])
        table.insert(SpellList, spellt1[math.random(#spellt1)])
        table.insert(SpellList, spellt1[math.random(#spellt1)])
        table.insert(SpellList, spellt2dmg[math.random(#spellt2dmg)])
        table.insert(SpellList, spellt2[math.random(#spellt2)])
        table.insert(SpellList, spellt2[math.random(#spellt2)])
        table.insert(SpellList, spellt2[math.random(#spellt2)])
        table.insert(SpellList, spellt3dmg[math.random(#spellt3dmg)])
        table.insert(SpellList, spellt3[math.random(#spellt3)])
        table.insert(SpellList, spellt3[math.random(#spellt3)])
        table.insert(SpellList, spellt3[math.random(#spellt3)])
    elseif tier == 3 then
        table.insert(SpellList, spellt1[math.random(#spellt1)])
        table.insert(SpellList, spellt2dmg[math.random(#spellt2dmg)])
        table.insert(SpellList, spellt2[math.random(#spellt2)])
        table.insert(SpellList, spellt2[math.random(#spellt2)])
        table.insert(SpellList, spellt2[math.random(#spellt2)])
        table.insert(SpellList, spellt3dmg[math.random(#spellt3dmg)])
        table.insert(SpellList, spellt3[math.random(#spellt3)])
        table.insert(SpellList, spellt3[math.random(#spellt3)])
        table.insert(SpellList, spellt3[math.random(#spellt3)])
        table.insert(SpellList, spellt4[math.random(#spellt4)])
        table.insert(SpellList, spellt4[math.random(#spellt4)])
        table.insert(SpellList, spellt4[math.random(#spellt4)])
    end
    return
        {
        spells = SpellList,
        guard = GuardTower,
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
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g000uu2030', level = 3, unique = true } i = i + 1 end -- детектив
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g001uu7571', level = 2, unique = true } i = i + 1 end -- белый волк
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g001uu7564', level = 2, unique = true } i = i + 1 end -- хорт
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g003uu5012', level = 3, unique = true } i = i + 1 end -- орк палач
    if math.random(0,1) == 1 then unitsMercenaries[i] = { id = 'g001uu8267', level = 3, unique = true } i = i + 1 end -- эльф-призрак
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


function getStartZone(zoneId, playerRace, zoneSize)

    local StartItem = {
        -- хилл
        { id = 'g000ig0001', min = 4, max = 4},
        { id = 'g000ig0006', min = 4, max = 4},
        { id = 'g000ig0005', min = 4, max = 4},
        { id = 'g001ig0180', min = 2, max = 2},
        -- бафы
        { id = 'g000ig0011', min = 1, max = 2},
        { id = 'g000ig0002', min = 1, max = 1},
        { id = 'g000ig0008', min = 1, max = 1},
        { id = 'g000ig0014', min = 1, max = 2},
        -- вард
        { id = 'g000ig0022', min = 1, max = 1},
        { id = 'g000ig0021', min = 1, max = 1},
        { id = 'g000ig0023', min = 1, max = 1},
        { id = 'g000ig0024', min = 1, max = 1},
        { id = 'g001ig0125', min = 1, max = 1},
        { id = 'g001ig0036', min = 1, max = 1},
        -- драгоценность
        { id = 'g000ig7002', min = 1, max = 1},
        -- сферы
        { id = 'g001ig0453', min = 1, max = 1},
        { id = 'g001ig0469', min = 1, max = 1},
        ili(ili({id = 'g001ig0187', min = 1, max = 1}, {id = 'g001ig0188', min = 1, max = 1}), ili({id = 'g001ig0190', min = 1, max = 1}, {id = 'g001ig0191', min = 1, max = 1}))
    }
    if playerRace == Race.Human then
        table.insert(StartItem, {id = 'g001ig0146', min = 1, max = 1}) 
        table.insert(StartItem, ili({id = 'g000ig5098', min = 1, max = 1}, {id = 'g000ig5061', min = 1, max = 1}))
    elseif playerRace == Race.Elf then
        table.insert(StartItem, {id = 'g001ig0150', min = 1, max = 1})
    elseif playerRace == Race.Heretic then
        table.insert(StartItem, {id = 'g001ig0147', min = 1, max = 1})
    elseif playerRace == Race.Dwarf then
        table.insert(StartItem, {id = 'g001ig0148', min = 1, max = 1})
    elseif playerRace == Race.Undead then
        table.insert(StartItem, {id = 'g001ig0149', min = 1, max = 1})
    end
	return {
		id = zoneId,
		type = Zone.PlayerStart,
		race = playerRace,
		size = zoneSize,
        capital = {garrison =
                        {value = { min = 50, max = 50 },
                        subraceTypes = getNativeSubraces(playerRace),
                        loot = {items = StartItem}}},
        mines = getStartMines(playerRace),
        stacks = {getStack(1, 3, getReward('stack1', 'startZone')),
                  getStack(1, 3, getReward('stack2', 'startZone')),
                  getStack(2, 3, getReward('stack3', 'startZone')),
                  getStack(2, 4, getReward('stack4', 'startZone'))},
        ruins = {getRuins({ min = 229, max = 279 }, getGuardRuins(1), getReward('ruinst1', 'StartZone')),
                 getRuins({ min = 279, max = 359 }, getGuardRuins(2), getReward('ruinst2', 'StartZone'))},
        merchants = {{goods = {items = getReward('merchants', 'startZone')},
                      guard = getGuard(3)}},
        mages = {getMagicTower(1, getGuard(1))},
        towns = {getTown(1, getGuard(1, getReward('guard', 'townt1') ), getReward('town', 'StartZonet1')),
                 getTown(2, getGuard(1, getReward('guard', 'townt2') ), getReward('town', 'StartZonet2'))},
        bags = getBags(5, getReward('bags', 'startZone'))
        }
end

function getBigZone1(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone14(playerRace),
        stacks = {
            getStack(3, 4, getReward('stack1', 'BigZone') ),
			getStack(3, 4, getReward('stack2', 'BigZone') ),
            getStack(4, 4, getReward('stack3', 'BigZone') ),
            getStack(4, 4, getReward('stack4', 'BigZone') ),
            getStack(5, 6, getReward('stack5', 'BigZone') )},
        ruins = {getRuins({ min = 420, max = 530 }, getGuardRuins(3), getReward('ruinst3', 'BigZone14')),
                 getRuins({ min = 420, max = 530 }, getGuardRuins(4), getReward('ruinst4', 'BigZone14'))},
        mercenaries = {getMercenaries(getGuard(3), getReward('mercen', 'bigZone') ) },
        merchants = {{goods = {items = getReward('merchants', 'BigZone14')},
                      guard = getGuard(3)}},
        mages = {getMagicTower(2, getGuard(3))},
		towns = {getTown(3, getGuard(4, getReward('guard', 'BZ14townt3')), getReward('townt3', 'BigZone14')),
                 getTown(4, getGuard(4, getReward('guard', 'BZ14townt4')), getReward('townt4', 'BigZone14', playerRace))},
        bags = getBags(9, getReward('bags', 'BigZone')),
	}
end

function getBigZone2(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone25(playerRace),
        stacks = {
            getStack(3, 2, getReward('stack1', 'BigZone') ),
			getStack(3, 3, getReward('stack2', 'BigZone') ),
            getStack(4, 4, getReward('stack3', 'BigZone') ),
            getStack(4, 4, getReward('stack4', 'BigZone') ),
            getStack(5, 7, getReward('stack5', 'BigZone') )},
        ruins = {getRuins( { min = 320, max = 380 }, getGuardRuins(3), getReward('ruins', 'BigZonet3')),
                 getRuins( { min = 420, max = 530 }, getGuardRuins(4), getReward('ruins', 'BigZonet4'))},
        merchants = {{goods = {items = getReward('merchants', 'BigZone25')},
                      guard = getGuard(3)}},
        mages = {getMagicTower(2, getGuard(3))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZ25townt3') ), getReward('townt3', 'BigZone25')),
                 getTown(4, getGuard(4, getReward('guard', 'BZ25townt4') ), getReward('townt4', 'BigZone25', playerRace))},
        bags = getBags(9, getReward('bags', 'BigZone'))
	}
end

function getBigZone4(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone14(playerRace),
        stacks = {
            getStack(3, 4, getReward('stack1', 'BigZone') ),
			getStack(3, 4, getReward('stack2', 'BigZone') ),
            getStack(4, 4, getReward('stack3', 'BigZone') ),
            getStack(4, 4, getReward('stack4', 'BigZone') ),
            getStack(5, 6, getReward('stack5', 'BigZone') )},
        ruins = {getRuins({ min = 420, max = 530 }, getGuardRuins(4), getReward('ruinst3', 'BigZone14')),
                 getRuins({ min = 420, max = 530 }, getGuardRuins(4), getReward('ruinst4', 'BigZone14'))},
        mercenaries = {getMercenaries(getGuard(3), getReward('mercen', 'bigZone'))},
        merchants = {{goods = {items = getReward('merchants', 'BigZone14')},
                      guard = getGuard(3)}},
        mages = {getMagicTower(2, getGuard(3))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZ14townt3')), getReward('townt3', 'BigZone14')),
                 getTown(4, getGuard(4, getReward('guard', 'BZ14townt4')), getReward('townt4', 'BigZone14'))},
        bags = getBags(9, getReward('bags', 'BigZone'))
	}
end

function getBigZone5(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone25(playerRace),
        stacks = {
            getStack(3, 2, getReward('stack1', 'BigZone') ),
			getStack(3, 3, getReward('stack2', 'BigZone') ),
            getStack(4, 4, getReward('stack3', 'BigZone') ),
            getStack(4, 4, getReward('stack4', 'BigZone') ),
            getStack(5, 7, getReward('stack5', 'BigZone') )},
        ruins = {getRuins({ min = 320, max = 380 }, getGuardRuins(3), getReward('ruins', 'BigZonet3')),
                 getRuins({ min = 420, max = 530 }, getGuardRuins(4), getReward('ruins', 'BigZonet4'))},
        merchants = {{goods = {items = getReward('merchants', 'BigZone25')},
                      guard = getGuard(3)}},
        mages = {getMagicTower(2, getGuard(3))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZ25townt3') ), getReward('townt3', 'BigZone25')),
                 getTown(4, getGuard(4, getReward('guard', 'BZ25townt4') ), getReward('townt4', 'BigZone25', playerRace))},
        bags = getBags(9, getReward('bags', 'BigZone'))
	}
end

function getVSZone(zoneId, playerRace, playerRace2, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesVS(playerRace, playerRace2),
        stacks = {
            getStack( 4, 12, {} ),
            getStack( 5, 10, {} )
        },
        ruins = {
            getRuins({ min = 600, max = 685 }, getGuardRuins(5), getReward('ruins', 'VSZonet4')),
            getRuins({ min = 420, max = 530 }, getGuardRuins(4), getReward('ruins', 'VSZonet5')),
        },
        merchants = {{goods = {items = getReward('merchants', 'VSZone')},
                      guard = getGuard(4)}},
        mages = {getMagicTower(3, getGuard(4))},
        towns = {getTown( 4, getGuard(4, getReward('guard', 'vstownt4')), getReward('townt4', 'VSZone')),
                 getTown( 5, getGuard(5, getReward('guard', 'vstownt5')), getReward('townt5', 'VSZone'))},
        bags = getBags(8, getReward('bags', 'VSZone'))
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
-- Номер центральной зоны
local VSZoneId = 6


function getZones(races)

	local BigZoneSize = 1600
	local StartZoneSize = 800
	local VSZoneSize = 2000

	local zones = {}


    zones[1] = getStartZone(0, races[1], StartZoneSize)  --- красная зона
	zones[2] = getBigZone5(5, races[1], BigZoneSize) ----------------- серая зона
    zones[3] = getBigZone1(1, races[1], BigZoneSize) ----------------- зелёная зона
	zones[4] = getVSZone(6, races[1], races[2], VSZoneSize) -------------------- жёлтая зона
	zones[5] = getBigZone4(4, races[2], BigZoneSize) ----------------- чёрная зона
    zones[6] = getBigZone2(2, races[2], BigZoneSize)  ---------------- синяя зона
	zones[7] = getStartZone(3, races[2], StartZoneSize) ---- белая зона


	return zones
end

-- Описывает соединение зон
function getConnections()
	return {
		-- Выход с респа 0 в смежные зоны
		{from = 0, to = 1, guard = getGuard( 3, getReward('guard', 'BigZone14'))},
		{from = 0, to = 1, guard = getGuard( 3, getReward('guard', 'BigZone14'))},
		{from = 0, to = 5, guard = getGuard( 3, getReward('guard', 'BigZone25'))},
		{from = 0, to = 5, guard = getGuard( 3, getReward('guard', 'BigZone25'))},
        -- Проход между 1 большой зоной и центром
		{from = 1, to = 6, guard = getGuard( 6, getReward('guard', 'GO'))},
        -- Проход между 2 большой зоной и центром
		{from = 2, to = 6, guard = getGuard( 6, getReward('guard', 'GO'))},
        -- Проходы между большими соседними зонами
        {from = 1, to = 2, guard = getGuard( 5, getReward('guard', 'GO'))},
        {from = 5, to = 4, guard = getGuard( 5, getReward('guard', 'GO'))},
        -- Проход между 5 большой зоной и центром
        {from = 5, to = 6, guard = getGuard (6, getReward('guard', 'GO'))},
        -- Проход между 4 большой зоной и центром
        {from = 4, to = 6, guard = getGuard( 6, getReward('guard', 'GO'))},
        -- Выход с респа 3 в большие зоны
        {from = 3, to = 4, guard = getGuard( 3, getReward('guard', 'BigZone14'))},
        {from = 3, to = 4, guard = getGuard( 3, getReward('guard', 'BigZone14'))},
        {from = 3, to = 2, guard = getGuard( 3, getReward('guard', 'BigZone25'))},       
        {from = 3, to = 2, guard = getGuard( 3, getReward('guard', 'BigZone25'))},       
	}
end

function getTemplateContents(races, scenarioSize)
	return {
		zones = getZones(races),
		connections = getConnections()
	}
end


template = {
	name = 'VerSus 0.5.4',
	description = 'VerSus 0.5.4 by iSkromny, sMNS 2.08b, 72x72, 2 players, the yellow zone must be touched by green, blue, gray and black',
    minSize = 72,
	maxSize = 72,
	maxPlayers = 2,
	roads = 50,
	forest = 40,
	startingGold = 1000,
    startingNativeMana = 200,
	getContents = getTemplateContents,
    forbiddenUnits = {
        'g000uu8210', -- гибельный рой (лидер)
        'g000uu8209' -- гибельный рой
        }
}
