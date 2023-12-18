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
local Squad1 = {Subrace.Neutral, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, Subrace.NeutralHuman, Subrace.NeutralBarbarian}
local Squad2 = {Subrace.NeutralGreenSkin, Subrace.NeutralBarbarian, Subrace.NeutralMarsh, Subrace.NeutralWolf, Subrace.NeutralElf, Subrace.NeutralHuman, Subrace.Neutral}
local Squad3 = {Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralWolf,
                    Subrace.Neutral, Subrace.NeutralBarbarian, Subrace.NeutralWater}
local Squad4 = {Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, 
                    Subrace.Neutral, Subrace.NeutralBarbarian, Subrace.NeutralWater, Subrace.NeutralHuman, Subrace.NeutralElf}
local SquadGO = {Subrace.NeutralDragon, Subrace.NeutralMarsh, Subrace.Neutral}

function SubraceSquad(x)
    local subrace = {}
    if x == GO then
        subrace = {Subrace.NeutralDragon, Subrace.Human, Subrace.Dwarf, Subrace.Heretic, Subrace.Undead, Subrace.Elf}
    elseif x == 1 then
        subrace = {Subrace.Neutral, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, Subrace.NeutralHuman, Subrace.NeutralBarbarian}
    elseif x == 2 then
        subrace = {Subrace.NeutralGreenSkin, Subrace.NeutralBarbarian, Subrace.NeutralMarsh, Subrace.NeutralWolf, Subrace.NeutralElf, Subrace.NeutralHuman, Subrace.Neutral}
    elseif x == 3 then
        subrace = {Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralWolf,
                    Subrace.Neutral, Subrace.NeutralBarbarian, Subrace.NeutralWater}
    elseif x == 4 then
        subrace = {Subrace.Elf, Subrace.Dwarf, Subrace.Undead, Subrace.Heretic, Subrace.Human, Subrace.NeutralMarsh, Subrace.NeutralGreenSkin, Subrace.NeutralWolf, 
                    Subrace.Neutral, Subrace.NeutralBarbarian, Subrace.NeutralWater, Subrace.NeutralHuman, Subrace.NeutralElf}
    end
    return subrace
end

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

local ElexirDotProtection = {'g001ig0329', 'g001ig0351', 'g001ig0343', 'g001ig0341'}
local ElexirProtection = {'g000ig0022', 'g000ig0021', 'g000ig0023', 'g000ig0024', 'g001ig0125', 'g001ig0036'}
local LowElexir = {'g000ig0014','g000ig0008', 'g000ig0011', 'g000ig0002', 'g001ig0560', 'g001ig0547', 'g001ig0490'}
local MediumElexir = {'g000ig0009', 'g000ig0012', 'g000ig0015', 'g001ig0491', 'g001ig0127', 'g001ig0562', 'g000ig0003'}
local HighElexir = {'g000ig0020', 'g000ig0019', 'g000ig0017', 'g001ig0126'}
local LowPermanent = {'g001ig0533', 'g001ig0315', 'g001ig0309', 'g001ig0313', 'g001ig0006', 'g001ig0130', 'g001ig0311', 'g001ig0307', 'g001ig0083'}
local MediumPermanent = {'g001ig0317', 'g001ig0516', 'g001ig0519', 'g000ig0010', 'g000ig0016', 'g000ig0013', 'g000ig0004', 'g001ig0548', 'g001ig0534'}
local HighPermanent = {'g001ig0376', 'g001ig0518', 'g001ig0521', 'g001ig0312', 'g001ig0308', 'g001ig0316', 'g001ig0310', 'g001ig0513', 'g001ig0318', 'g001ig0506'}
local AuraPermanent = {'g001ig0026', 'g001ig0027', 'g001ig0563', 'g001ig0028', 'g001ig0034', 'g001ig0031', 'g001ig0029', 'g001ig0030', 'g001ig0564', 'g001ig0024', 'g001ig0021', 'g001ig0023',  'g001ig0022',
    'g001ig0025', 'g001ig0019'}
local ElexirPermanentDot = {'g001ig0332', 'g001ig0342', 'g001ig0346', 'g001ig0330', 'g001ig0328', 'g001ig0352', 'g001ig0338', 'g001ig0340', 'g001ig0336', 'g001ig0344', 'g001ig0354', 'g001ig0348'}
local ElexirPermanentProtected = {'001ig0320', 'g001ig0323', 'g001ig0321', 'g001ig0322', 'g001ig0325', 'g001ig0326'}
local Permanentskill = {'g001ig0530', 'g001ig0527', 'g001ig0531', 'g001ig0525', 'g001ig0524', 'g001ig0529', 'g001ig0526', 'g001ig0501', 'g001ig0528'}
local TalismanSummont1 = {'g001ig0267', 'g001ig0265', 'g001ig0266', 'g001ig0264', 'g000ig9101'}
local TalismanAll = {'g001ig0184', 'g000ig9105', 'g000ig9131'}
local scrollT1 = {'g001ig0407', 'g000ig5022', 'g000ig5064', 'g000ig5044', 'g000ig5021', 'g001ig0250', 'g001ig0247', 'g001ig0073', 'g000ig5002', 'g000ig5106', 'g001ig0248', 'g000ig5023', 'g000ig5003', 'g000ig5101', 
    'g000ig5045', 'g000ig5065', 'g001ig0252', 'g000ig5102', 'g000ig5042', 'g000ig5041', 'g000ig5025', 'g000ig5061', 'g000ig5098', 'g000ig5084', 'g001ig0492', 'g000ig5009', 'g000ig5007', 'g000ig5118', 'g000ig5119', 
    'g001ig0072', 'g001ig0574', 'g001ig0084', 'g001ig0194', 'g001ig0573', 'g001ig0255', 'g001ig0254', 'g000ig5050', 'g000ig5049', 'g001ig0253', 'g000ig5069', 'g001ig0256', 'g000ig5020', 'g001ig0568', 'g001ig0569',
    'g001ig0193', 'g000ig5030', 'g000ig5029', 'g000ig5068', 'g000ig5034', 'g000ig5088', 'g000ig5107', 'g000ig5047', 'g000ig5046', 'g000ig5066',
    'g000ig5008', 'g000ig5103', 'g001ig0249', 'g000ig5005', 'g000ig5001', 'g000ig5010', 'g000ig5016', 'g001ig0251', 'g001ig0123', 'g001ig0092', 'g001ig0085'}

local scrollT2 = {'g001ig0165', 'g001ig0580', 'g001ig0577', 'g001ig0576', 'g001ig0578', 'g001ig0579', 'g000ig5012', 'g000ig5026', 'g001ig0572', 'g000ig5111', 'g000ig5089', 'g000ig5013', 'g000ig5110', 'g000ig5073', 
    'g000ig5074', 'g000ig5052', 'g001ig0570', 'g000ig5040', 'g000ig5085', 'g000ig5011', 'g000ig5018', 'g000ig5079', 'g000ig5059', 'g000ig5031', 'g000ig5071', 'g000ig5108'}

local scrollT3 = {'g000ig5114', 'g000ig5035', 'g000ig5055', 'g000ig5076', 'g000ig5115', 'g000ig5017', 'g000ig5036', 'g000ig5082', 'g000ig5116',
    'g000ig5075', 'g000ig5113', 'g000ig5091', 'g001ig0586', 'g000ig5039', 'g000ig5057'}

local scrollDmgT1 = {'g000ig5024', 'g000ig5043', 'g000ig5097', 'g000ig5004', 'g000ig5062', 'g000ig5063'}
local scrollDmgT2 = {'g000ig5048', 'g000ig5028', 'g000ig5067', 'g000ig5104'}
local scrollDmgT3 = {'g000ig5054', 'g000ig5109', 'g000ig5033', 'g000ig5014', 'g000ig5072'}
-- local scrollDmgT4 = {'g000ig5093', 'g000ig5090', 'g000ig5081', 'g000ig5086', 'g000ig5112'}

local weakOrbs = {'g001ig0189', 'g001ig0178', 'g001ig0472', 'g001ig0192', 'g001ig0473', 'g001ig0470', 'g001ig0458', 'g000ig9033', 'g001ig0302', 'g000ig9022', 'g000ig9031', 'g001ig0471', 'g000ig9017', 'g001ig0446'}
local mediumOrbs = {'g001ig0450', 'g001ig0464', 'g001ig0176', 'g001ig0133', 'g001ig0191', 'g001ig0304', 'g001ig0467', 'g001ig0468', 'g001ig0469', 'g000ig9018', 'g001ig0453', 'g001ig0454', 'g001ig0300', 'g001ig0496',
                    'g001ig0187', 'g001ig0456', 'g001ig0474', 'g001ig0475', 'g000ig9042', 'g001ig0478', 'g001ig0443', 'g000ig9024', 'g001ig0461',}
local strongOrbs = {'g000ig9025', 'g001ig0303', 'g001ig0477', 'g000ig9027', 'g001ig0459', 'g000ig9023', 'g001ig0136', 'g000ig9021', 'g000ig9016', 'g001ig0455', 'g000ig9032', 'g001ig0479', 'g001ig0134'}
local strongOrbs2 = {'g000ig9043', 'g000ig9020', 'g001ig0131', 'g001ig0183', 'g001ig0462', 'g001ig0203', 'g000ig9014', 'g001ig0480', 'g000ig9028', 'g001ig0457', 'g001ig0466', 'g001ig0489'}
local CurseOrbs = {'g001ig0295', 'g000ig9006', 'g000ig9039', 'g000ig9007', 'g001ig0181', 'g000ig9040'}
local RezistOrbs = {'g001ig0056', 'g001ig0054', 'g001ig0055', 'g001ig0053', 'g001ig0058', 'g001ig0057'}

local smallValuable = {'g000ig7001', 'g001ig0431', 'g000ig7002'}
local mediumValuable = {'g001ig0433', 'g001ig0432', 'g000ig7004', 'g000ig7003'}
local bigValuable = {'g000ig7007', 'g000ig7008', 'g000ig7005', 'g000ig7006'}
local smallballmana = {'g001ig0481', 'g001ig0485', 'g001ig0482', 'g001ig0483', 'g001ig0484', 'g001ig0486'}
local mediumballmana = {'g001ig0146', 'g001ig0150', 'g001ig0147', 'g001ig0148', 'g001ig0149', 'g001ig0151'}
local bigballmana = {'g001ig0277', 'g001ig0281', 'g001ig0278', 'g001ig0279', 'g001ig0280', 'g001ig0282'}

local ArtT1 = {'g001ig0611', 'g001ig0418', 'g000ig2001', 'g000ig2002', 'g000ig3001', 'g001ig0100', 'g001ig0182'}
local ArtT2 = {'g001ig0582',  'g001ig0558', 'g001ig0557', 'g001ig0047', 'g001ig0594','g000ig3017', 'g001ig0487', 'g001ig0589'}
local ArtT3 = {'g001ig0048', 'g000ig3002',  'g001ig0155', 'g001ig0042', 'g001ig0045', 'g000ig2003', 'g001ig0040', 'g001ig0559', 'g001ig0416', 'g001ig0591',
     'g001ig0173', 'g001ig0196',  'g000ig9137', 'g001ig0197', 'g001ig0604', 'g001ig0158'}
local ArtT4 = {'g001ig0124', 'g001ig0612', 'g001ig0585', 'g001ig0046', 'g001ig0592', 'g000ig2004', 'g001ig0060', 'g001ig0041', 'g001ig0590', 'g001ig0039',
    'g001ig0071', 'g001ig0411', 'g000ig3019', 'g000ig3006', 'g001ig0488', 'g001ig0413', 'g001ig0415', 'g000ig3004','g000ig9035'}
local ArtT5 = {'g001ig0179', 'g001ig0410', 'g000ig3018', 'g001ig0102', 'g001ig0412', 'g000ig2005', 'g001ig0043', 'g001ig0174'}
local JewelT1 = {'g001ig0101', 'g000ig4008', 'g000ig3008', 'g001ig0428', 'g000ig4006', 'g001ig0494', 'g000ig4004', 'g001ig0495', 'g001ig0497', 'g000ig4003', 'g000ig4005',
     'g000ig4001', 'g000ig4002', 'g001ig0493'}
local JewelT2 = { 'g001ig0421', 'g001ig0420', 'g001ig0422', 'g001ig0423', 'g000ig4007', 'g001ig0427', 'g001ig0099', 'g001ig0430', 'g001ig0539', 'g000ig3020', 'g001ig0605'}
local JewelT3 = { 'g001ig0037', 'g001ig0424', 'g001ig0425', 'g001ig0597', 'g000ig3022', 'g001ig0610', 'g001ig0156', 'g000ig2006'}
local JewelT4 = { 'g001ig0104', 'g000ig7010', 'g000ig3005', 'g001ig0429', 'g001ig0116', 'g001ig0038','g001ig0419'}
local BannerT1 = {'g000ig1005', 'g001ig0051', 'g000ig1001', 'g000ig1007', 'g000ig1003', 'g001ig0587'}

local BannerT2 = {'g001ig0369', 'g001ig0370', 'g001ig0142', 'g001ig0140', 'g001ig0141', 'g001ig0139', 'g001ig0145', 'g001ig0143', 'g001ig0293', 'g000ig1004', 'g001ig0365', 'g001ig0361',
    'g001ig0289', 'g000ig1008', 'g001ig0292', 'g001ig0357', 'g000ig1002', 'g000ig1006', 'g001ig0588', 'g001ig0363', 'g001ig0364', 'g001ig0374', 'g001ig0358', 'g001ig0362'}

local BannerT3 = {'g001ig0373', 'g001ig0367', 'g001ig0360', 'g000ig1016', 'g000ig1017', 'g000ig1015', 'g001ig0290', 'g001ig0291', 'g001ig0359'}

local BannerT4 = {'g001ig0153', 'g001ig0144', 'g001ig0052', 'g001ig0366'}

local TravelT1 = {'g001ig0108', 'g001ig0107', 'g001ig0105', 'g001ig0109', 'g001ig0106', 'g001ig0113'}
local TravelT2 = {'g001ig0111', 'g000ig1010', 'g000ig8003', 'g001ig0606'}
local TravelT3 = {'g000ig8004', 'g001ig0114', 'g001ig0115', 'g001ig0112'}

local Wand = {'g000ig6020', 'g000ig6001','g000ig6014','g001ig0392','g001ig0397','g001ig0395','g001ig0403','g001ig0404','g001ig0405','g001ig0402','g000ig6011','g001ig0401','g001ig0396','g001ig0399','g000ig6003','g001ig0394','g001ig0398','g000ig6012'}

local rewardItems = { }

if Type == 'town' and Zone == 'StartZonet1' then
    if playerRace == Race.Human then table.insert(rewardItems, ili({id = 'g000ig5098', min = 1, max = 1}, {id = 'g000ig5061', min = 1, max = 1}))
    end
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig5100', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT1[math.random(#scrollDmgT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = TalismanSummont1[math.random(#TalismanSummont1)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'townt1' then
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = Wand[math.random(#Wand)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0530', min = 1, max = 1})

elseif Type == 'town' and Zone == 'StartZonet2' then
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0001', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig5009', min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT1[math.random(#ArtT1)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'townt2' then
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0486', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})

elseif Type == 'ruinst1' and Zone == 'StartZone' then
    table.insert(rewardItems, {id = BannerT1[math.random(#BannerT1)], min = 1, max = 1})
elseif Type == 'ruinst2' and Zone == 'StartZone' then
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})

elseif Type == 'stack1' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = smallballmana[math.random(#smallballmana)], min = 1, max = 1})
elseif Type == 'stack2' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = smallballmana[math.random(#mediumballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
elseif Type == 'stack3' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0486', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
elseif Type == 'stack4' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1 })
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT1[math.random(#scrollDmgT1)], min = 1, max = 1})
elseif Type == 'stack5' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = TalismanAll[math.random(#TalismanAll)], min = 1, max = 1})
elseif Type == 'stackArt' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT1[math.random(#JewelT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
elseif Type == 'stackArt2' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT1[math.random(#ArtT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0532', min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})

elseif Type == 'guard' and Zone == 'maget1' then
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 2})
    table.insert(rewardItems, {id = smallballmana[math.random(#smallballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})

elseif Type == 'guard' and Zone == 'merchantst1' then
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})

elseif Type == 'merchants' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 3, max = 3})
    table.insert(rewardItems, {id = 'g000ig0005', min = 4, max = 4})
    table.insert(rewardItems, {id = 'g001ig0378', min = 4, max = 4})
    table.insert(rewardItems, {id = 'g000ig0006', min = 4, max = 4})
    table.insert(rewardItems, {id = ArtT1[math.random(#ArtT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT1[math.random(#BannerT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT1[math.random(#JewelT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = TravelT1[math.random(#TravelT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = TravelT1[math.random(#TravelT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = TalismanSummont1[math.random(#TalismanSummont1)], min = 1, max = 1})

elseif Type == 'bags' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g001ig0180', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0180', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0180', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = scrollDmgT1[math.random(#scrollDmgT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0180', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0486', min = 1, max = 1})


elseif Type == 'guard' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0084', min = 1, max = 1})
    table.insert(rewardItems, {id = TravelT2[math.random(#TravelT2)], min = 1, max = 1})
    table.insert(rewardItems, ili({id = 'g001ig0560', min = 1, max = 1}, {id = 'g001ig0547', min = 1, max = 1}))
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1 })
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1 })
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1 })
    table.insert(rewardItems, {id = scrollDmgT2[math.random(#scrollDmgT2)], min = 1, max = 1})

elseif Type == 'townt3' and Zone == 'BigZone25' then
    if playerRace == Race.Human then table.insert(rewardItems, {id='g001ig0146', min = 1, max = 1})
    elseif playerRace == Race.Elf then table.insert(rewardItems, {id='g001ig0150', min = 1, max = 1})
    elseif playerRace == Race.Heretic then table.insert(rewardItems, {id='g001ig0147', min = 1, max = 1})
    elseif playerRace == Race.Dwarf then table.insert(rewardItems, {id='g001ig0148', min = 1, max = 1})
    elseif playerRace == Race.Undead then table.insert(rewardItems, {id='g001ig0149', min = 1, max = 1})
    end
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig5009', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0317', min = 1, max = 1})
    table.insert(rewardItems, {id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT2[math.random(#JewelT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
elseif Type == 'townt3' and Zone == 'BigZone14' then
    if playerRace == Race.Human then table.insert(rewardItems, {id='g001ig0146', min = 1, max = 1})
    elseif playerRace == Race.Elf then table.insert(rewardItems, {id='g001ig0150', min = 1, max = 1})
    elseif playerRace == Race.Heretic then table.insert(rewardItems, {id='g001ig0147', min = 1, max = 1})
    elseif playerRace == Race.Dwarf then table.insert(rewardItems, {id='g001ig0148', min = 1, max = 1})
    elseif playerRace == Race.Undead then table.insert(rewardItems, {id='g001ig0149', min = 1, max = 1})
    end
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig5009', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0317', min = 1, max = 1})
    table.insert(rewardItems, {id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT2[math.random(#BannerT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'BZtownt3' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0151', min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT2[math.random(#ArtT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})

elseif Type == 'ruinst3.1' and Zone == 'BigZone25' then
    table.insert(rewardItems, {id = BannerT2[math.random(#BannerT2)], min = 1, max = 1})
elseif Type == 'ruinst3.2' and Zone == 'BigZone25' then
    table.insert(rewardItems, {id = 'g000ig3003', min = 1, max = 1})
elseif Type == 'ruinst4.1' and Zone == 'BigZone25' then
    table.insert(rewardItems, {id = JewelT3[math.random(#JewelT3)], min = 1, max = 1})
elseif Type == 'ruinst4.2' and Zone == 'BigZone25' then
    table.insert(rewardItems, ili({id = 'g000ig3015', min = 1, max = 1}, {id = 'g000ig3016', min = 1, max = 1}))

elseif Type == 'ruinst3.1' and Zone == 'BigZone14' then
    table.insert(rewardItems, {id = JewelT2[math.random(#JewelT2)], min = 1, max = 1})
elseif Type == 'ruinst3.2' and Zone == 'BigZone14' then
    table.insert(rewardItems, {id = 'g001ig0417', min = 1, max = 1})
elseif Type == 'ruinst4' and Zone == 'BigZone14' then
    table.insert(rewardItems, {id = BannerT3[math.random(#BannerT3)], min = 1, max = 1})

elseif Type == 'guard' and Zone == 'maget2' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})

elseif Type == 'guard' and Zone == 'merchantst2' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})

elseif Type == 'stack1' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = smallballmana[math.random(#smallballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 1})
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
elseif Type == 'stack2' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
	table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 1})
    table.insert(rewardItems, {id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
	table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
elseif Type == 'stack3' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig9109', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
elseif Type == 'stack4_wand' and Zone == 'BigZone' then
    table.insert(rewardItems, ili({id = 'g000ig6019', min = 1, max = 1}, {id = 'g001ig0097', min = 1, max = 1}))
elseif Type == 'stack4' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
	table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
elseif Type == 'stack5' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = RezistOrbs[math.random(#RezistOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = bigballmana[math.random(#bigballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig5100', min = 1, max = 1})
    table.insert(rewardItems, {id = TalismanAll[math.random(#TalismanAll)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT2[math.random(#ArtT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
elseif Type == 'stackArt' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = ArtT3[math.random(#ArtT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0028', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = CurseOrbs[math.random(#CurseOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig5068', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT3[math.random(#scrollDmgT3)], min = 1, max = 1})

elseif Type == 'bags' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = bigballmana[math.random(#bigballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 3, max = 3})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})


elseif Type == 'guard' and Zone == 'BZ' then
    table.insert(rewardItems, {id = ArtT3[math.random(#ArtT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g001ig0151', min = 1, max = 1})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})    

elseif Type == 'townt4' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirPermanentDot[math.random(#ElexirPermanentDot)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT3[math.random(#scrollDmgT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT3[math.random(#BannerT3)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'vstownt4' then
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})

elseif Type == 'townt5' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig5074', min = 1, max = 1})
    table.insert(rewardItems, {id = bigballmana[math.random(#bigballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirPermanentProtected[math.random(#ElexirPermanentProtected)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT3[math.random(#ArtT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = HighElexir[math.random(#HighElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = strongOrbs2[math.random(#strongOrbs2)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'vstownt5' then
    table.insert(rewardItems, {id = 'g001ig0152', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1 } )

elseif Type == 'ruins' and Zone == 'VSZonet4' then
    table.insert(rewardItems, {id = JewelT4[math.random(#JewelT4)], min = 1, max = 1})
elseif Type == 'ruins' and Zone == 'VSZonet5' then
    table.insert(rewardItems, {id = BannerT4[math.random(#BannerT4)], min = 1, max = 1})

elseif Type == 'guard' and Zone == 'maget3' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})

elseif Type == 'guard' and Zone == 'merchantst3' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})


elseif Type == 'guard' and Zone == 'GO14' then
    table.insert(rewardItems, {id = ArtT4[math.random(#ArtT4)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g001ig0152', min = 1, max = 1})
    table.insert(rewardItems, {id = MediumPermanent[math.random(#MediumPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT2[math.random(#scrollDmgT2)], min = 1, max = 1})

elseif Type == 'guard' and Zone == 'GO25' then
    table.insert(rewardItems, {id = JewelT4[math.random(#JewelT4)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g001ig0152', min = 1, max = 1})
    table.insert(rewardItems, {id = MediumPermanent[math.random(#MediumPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT2[math.random(#scrollDmgT2)], min = 1, max = 1})


elseif Type == 'stackt4' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = 'g001ig0180', min = 3, max = 3})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT2[math.random(#ArtT1)], min = 1, max = 1})

elseif Type == 'stackt5' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirPermanentDot[math.random(#ElexirPermanentDot)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT2[math.random(#JewelT1)], min = 1, max = 1})

elseif Type == 'stackt6' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0018', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g001ig0152', min = 2, max = 2})
    table.insert(rewardItems, {id = ElexirPermanentDot[math.random(#ElexirPermanentDot)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = HighElexir[math.random(#HighElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumPermanent[math.random(#MediumPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT3[math.random(#scrollDmgT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = HighPermanent[math.random(#HighPermanent)], min = 1, max = 1})


elseif Type == 'bags' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 2, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = bigballmana[math.random(#bigballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = bigValuable[math.random(#bigValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumPermanent[math.random(#MediumPermanent)], min = 1, max = 1})



elseif Type == 'merchants' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 3, max = 3})
    table.insert(rewardItems, {id = 'g000ig0005', min = 4, max = 4})
    table.insert(rewardItems, {id = 'g001ig0378', min = 4, max = 4})
    table.insert(rewardItems, {id = 'g000ig0006', min = 4, max = 4})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT2[math.random(#ArtT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT1[math.random(#ArtT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT2[math.random(#BannerT2)], min = 1, max = 1 })
    table.insert(rewardItems, {id = BannerT1[math.random(#BannerT1)], min = 1, max = 1 })
    table.insert(rewardItems, {id = TravelT2[math.random(#TravelT2)], min = 1, max = 1 })
    table.insert(rewardItems, {id = TravelT1[math.random(#TravelT2)], min = 1, max = 1 })
    table.insert(rewardItems, {id = JewelT2[math.random(#JewelT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT1[math.random(#JewelT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = CurseOrbs[math.random(#CurseOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = RezistOrbs[math.random(#RezistOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirPermanentDot[math.random(#ElexirPermanentDot)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = Permanentskill[math.random(#Permanentskill)], min = 1, max = 1})
    table.insert(rewardItems, {id = Permanentskill[math.random(#Permanentskill)], min = 1, max = 1})
    table.insert(rewardItems, {id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1})

elseif Type == 'merchants' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 3, max = 3})
    table.insert(rewardItems, {id = 'g000ig0005', min = 4, max = 4})
    table.insert(rewardItems, {id = 'g001ig0378', min = 4, max = 4})
    table.insert(rewardItems, {id = 'g000ig0006', min = 4, max = 4})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT5[math.random(#ArtT5)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT4[math.random(#ArtT4)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT3[math.random(#ArtT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT2[math.random(#ArtT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT4[math.random(#BannerT4)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT3[math.random(#BannerT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = TravelT3[math.random(#TravelT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = TravelT2[math.random(#TravelT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT4[math.random(#JewelT4)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT3[math.random(#JewelT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirPermanentProtected[math.random(#ElexirPermanentProtected)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirPermanentDot[math.random(#ElexirPermanentDot)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 2})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 2})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 2})
    table.insert(rewardItems, {id = HighElexir[math.random(#HighElexir)], min = 1, max = 2})
    table.insert(rewardItems, {id = AuraPermanent[math.random(#AuraPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = HighPermanent[math.random(#HighPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = Permanentskill[math.random(#Permanentskill)], min = 1, max = 1})
    table.insert(rewardItems, {id = Permanentskill[math.random(#Permanentskill)], min = 1, max = 1})
    table.insert(rewardItems, {id = CurseOrbs[math.random(#CurseOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = RezistOrbs[math.random(#RezistOrbs)], min = 1, max = 1})
    table.insert(rewardItems, ili({id = 'g001ig0375', min = 1, max = 1}, {id = 'g001ig0500', min = 1, max = 1}))
    table.insert(rewardItems, {id = 'g001ig0522', min = 1, max = 1})
    end
    return rewardItems
end

function getStack(tier, stackCount, itemsTable, race)
    local squad = { }
    if (tier == 1) then squad = SubraceSquad(1)
    elseif (tier == 2 or tier == 3) then squad = SubraceSquad(2)
    elseif (tier == 4) then squad = SubraceSquad(3)
    elseif (tier == 5 or tier == 6) then squad = SubraceSquad(4)
    end
    local expValueStack = { }
    if (tier == 1) then
        expValueStack.min = 160 * stackCount
        expValueStack.max = 280 * stackCount
    elseif (tier == 2) then
        expValueStack.min = 210 * stackCount
        expValueStack.max = 340 * stackCount
    elseif (tier == 3) then
        expValueStack.min = 300 * stackCount
        expValueStack.max = 500 * stackCount
    elseif (tier == 4) then
        expValueStack.min = 460 * stackCount
        expValueStack.max = 760 * stackCount
    elseif (tier == 5) then
        expValueStack.min = 810 * stackCount
        expValueStack.max = 1340 * stackCount
    elseif (tier == 6) then
        expValueStack.min = 1180 * stackCount
        expValueStack.max = 1640 * stackCount
    end
    return {
        count = stackCount,
        subraceTypes = squad,
        value = expValueStack,
        owner = race,
        loot = {
            items = itemsTable
        }
    }
end

function getGuard(tier, itemsTable)
    local squad = { }
    if (tier == 1) then squad = SubraceSquad(1)
    elseif (tier == 2 or tier == 3) then squad = SubraceSquad(2)
    elseif (tier == 4) then squad = SubraceSquad(3)
    elseif (tier == 5) then squad = SubraceSquad(4)
    elseif (tier == 6) then squad = SubraceSquad(GO)
    end
    local expValueGuard = { }
    if (tier == 1) then
        expValueGuard.min = 200
        expValueGuard.max = 360
    elseif (tier == 2) then
        expValueGuard.min = 310
        expValueGuard.max = 490
    elseif (tier == 3) then
        expValueGuard.min = 420
        expValueGuard.max = 720
    elseif (tier == 4) then
        expValueGuard.min = 690
        expValueGuard.max = 970
    elseif (tier == 5) then
        expValueGuard.min = 900
        expValueGuard.max = 1220
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
        expValue.min = 220 * 1.1
        expValue.max = 380 * 1.1
    elseif ( townTier == 2) then
        expValue.min = 320 * 1.1
        expValue.max = 490 * 1.1
    elseif ( townTier == 3) then
        expValue.min = 440 * 1.1
        expValue.max = 730 * 1.1
    elseif ( townTier == 4) then
        expValue.min = 670 * 1.1
        expValue.max = 1030 * 1.1
    elseif ( townTier == 5) then
        expValue.min = 920 * 1.1
        expValue.max = 1420 * 1.1
    end
    local townGuard = { }
    if ( townTier == 1 ) then
        townGuard = SubraceSquad(1)
    elseif ( townTier == 2) then
        townGuard = SubraceSquad(2)
    elseif ( townTier == 3) then
        townGuard = SubraceSquad(3)
    elseif ( townTier == 4 or townTier > 4) then
        townGuard = SubraceSquad(4)
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
    if (tier == 1) then squadStack = SubraceSquad(1)
    elseif (tier == 2 or tier == 3) then squadStack = SubraceSquad(2)
    elseif (tier == 4) then squadStack = SubraceSquad(3)
    elseif (tier == 5) then squadStack = SubraceSquad(4)
    elseif (tier == 6) then squadStack = SubraceSquad(GO)
    end
    local expValueGuard = { }
    if (tier == 1) then
        expValueGuard.min = 200
        expValueGuard.max = 280
    elseif (tier == 2) then
        expValueGuard.min = 240
        expValueGuard.max = 360
    elseif (tier == 3) then
        expValueGuard.min = 320
        expValueGuard.max = 510
    elseif (tier == 4) then
        expValueGuard.min = 490
        expValueGuard.max = 790
    elseif (tier == 5) then
        expValueGuard.min = 780
        expValueGuard.max = 1230
    elseif (tier == 6) then
        expValueGuard.min = 1100
        expValueGuard.max = 1760
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
        table.insert(SpellList, ili(ili('g000ss0003', 'g000ss0023'), 'g000ss0101')) 
        table.insert(SpellList, ili(ili('g000ss0021', 'g000ss0181'), ili('g000ss0045', 'g000ss0065'))) 
        table.insert(SpellList, ili('g000ss0044', 'g000ss0064')) 
        table.insert(SpellList, ili(ili('g000ss0178', 'g000ss0134'), ili('g000ss0106', 'g000ss0179'))) 
        table.insert(SpellList, ili('g000ss0191', 'g000ss0192'))
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

function getMercenaries1(getGuard)

    local unitsMercenaries = {}
    local i = 1
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7594', level = 3, unique = true} i = i + 1 end -- инеит
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8218', level = 3, unique = true} i = i + 1 end -- волхв
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7610', level = 3, unique = true} i = i + 1 end -- ледяной ходок
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7629', level = 1, unique = true} i = i + 1 end -- Благородный эльф
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7609', level = 1, unique = true} i = i + 1 end -- квартирмейстер

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7581', level = 3, unique = true} i = i + 1 end -- Заклинатель
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu2030', level = 3, unique = true} i = i + 1 end -- Детектив
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g003uu5003', level = 3, unique = true} i = i + 1 end -- Ревнитель
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8311', level = 3, unique = true} i = i + 1 end -- Ардет

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7571', level = 2, unique = true} i = i + 1 end -- белый волк
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7583', level = 2, unique = true} i = i + 1 end -- йамму
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0038', level = 3, unique = true} i = i + 1 end -- Ветеран
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0162', level = 3, unique = true} i = i + 1 end -- Защитник горна

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7564', level = 3, unique = true} i = i + 1 end -- хорт
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0091', level = 3, unique = true} i = i + 1 end -- Лорд Тьмы
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu8267', level = 3, unique = true} i = i + 1 end -- эльф-призрак
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu2007', level = 3, unique = true} i = i + 1 end -- Мумификатор

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0171', level = 3, unique = true} i = i + 1 end -- подражатель
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0054', level = 3, unique = true} i = i + 1 end -- Чёрный паладин
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7574', level = 3, unique = true} i = i + 1 end -- Цитриновая гарга
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu2003', level = 3, unique = true} i = i + 1 end -- Мучитель

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8033', level = 3, unique = true} i = i + 1 end -- лесная дева
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8024', level = 3, unique = true} i = i + 1 end -- Часовой
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7579', level = 3, unique = true} i = i + 1 end -- Кентавр-гвардеец
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8027', level = 3, unique = true} i = i + 1 end -- Архонт
    return {
        units = unitsMercenaries,
        guard = getGuard
    }
end

function getMercenaries4(getGuard)

    local unitsMercenaries = {}
    local i = 1

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7604', level = 1, unique = true} i = i + 1 end -- незрячий страж
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7613', level = 1, unique = true} i = i + 1 end -- огнеборец
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8151', level = 3, unique = true} i = i + 1 end -- фурия
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7612', level = 3, unique = true} i = i + 1 end -- королевский арбалетчик
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu8255', level = 1, unique = true} i = i + 1 end -- эльф тень

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7581', level = 3, unique = true} i = i + 1 end -- Заклинатель
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu2030', level = 3, unique = true} i = i + 1 end -- Детектив
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0005', level = 3, unique = true} i = i + 1 end -- Инквизитор
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7562', level = 3, unique = true} i = i + 1 end -- Бореалис

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7571', level = 2, unique = true} i = i + 1 end -- белый волк
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7583', level = 2, unique = true} i = i + 1 end -- йамму
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0038', level = 3, unique = true} i = i + 1 end -- Ветеран
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7568', level = 2, unique = true} i = i + 1 end -- сотрясатель

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7565', level = 3, unique = true} i = i + 1 end -- Чумной оборотень
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0091', level = 3, unique = true} i = i + 1 end -- Орк-палач
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu8267', level = 3, unique = true} i = i + 1 end -- эльф-призрак
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0088', level = 3, unique = true} i = i + 1 end -- скелет-вони

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0171', level = 3, unique = true} i = i + 1 end -- подражатель
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0054', level = 3, unique = true} i = i + 1 end -- Чёрный паладин
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7573', level = 3, unique = true} i = i + 1 end -- Чароитовая гарга
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu0068', level = 3, unique = true} i = i + 1 end -- Колдунья

    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8033', level = 3, unique = true} i = i + 1 end -- лесная дева
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8023', level = 3, unique = true} i = i + 1 end -- Стражник
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8017', level = 3, unique = true} i = i + 1 end -- Кентавр-дикарь
    if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8028', level = 3, unique = true} i = i + 1 end -- Тиург
    return {
        units = unitsMercenaries,
        guard = getGuard
    }
end

function getStartZone(zoneId, playerRace, zoneSize)
    local StartItem = {
        {id = 'g000ig0001', min = 4, max = 4},
        {id = 'g000ig0006', min = 4, max = 4},
        {id = 'g000ig0005', min = 4, max = 4},
        {id = 'g001ig0180', min = 2, max = 2},
        ili({id = 'g000ig0011', min = 1, max = 1}, {id = 'g000ig0008', min = 1, max = 1}),
        ili({id = 'g000ig0002', min = 1, max = 1}, {id = 'g000ig0014', min = 1, max = 1}),
        {id = 'g000ig0022', min = 1, max = 1},
        {id = 'g000ig0021', min = 1, max = 1},
        {id = 'g000ig0023', min = 1, max = 1},
        {id = 'g000ig0024', min = 1, max = 1},
        {id = 'g001ig0125', min = 1, max = 1},
        {id = 'g001ig0036', min = 1, max = 1},
        {id = 'g000ig7002', min = 1, max = 1},
        {id = 'g000ig9017', min = 1, max = 1},
        {id = 'g000ig5084', min = 1, max = 1},
        ili(ili({id = 'g001ig0178', min = 1, max = 1}, {id = 'g001ig0472', min = 1, max = 1}), ili({id = 'g001ig0192', min = 1, max = 1}, {id = 'g001ig0473', min = 1, max = 1}))
    }
    if playerRace == Race.Human then
        table.insert(StartItem, {id = 'g001ig0146', min = 1, max = 1})
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
                  getStack(2, 4, getReward('stack3', 'startZone')),
                  getStack(2, 4, getReward('stack4', 'startZone')),
                  getStack(3, 2, getReward('stack5', 'startZone')),
                  getStack(3, 1, getReward('stackArt', 'startZone')),
                  getStack(4, 1, getReward('stackArt2', 'startZone'))},
        ruins = {getRuins({min = 229, max = 279}, getGuardRuins(1), getReward('ruinst1', 'StartZone')),
                 getRuins({min = 279, max = 359}, getGuardRuins(2), getReward('ruinst2', 'StartZone'))},
        merchants = {{goods = {items = getReward('merchants', 'startZone')},
                      guard = getGuard(1, getReward('guard', 'merchantst1'))}},
        mages = {getMagicTower(1, getGuard(1, getReward('guard', 'maget1')))},
        towns = {getTown(1, getGuard(1, getReward('guard', 'townt1')), getReward('town', 'StartZonet1', playerRace)),
                 getTown(2, getGuard(1, getReward('guard', 'townt2')), getReward('town', 'StartZonet2'))},
        bags =  getBags(5, getReward('bags', 'startZone'))
    }
end

function getBigZone1(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone14(playerRace),
        stacks = {
            getStack(2, 3, getReward('stack1', 'BigZone')),
			getStack(3, 4, getReward('stack2', 'BigZone')),
            getStack(3, 4, getReward('stack3', 'BigZone')),
            getStack(4, 4, getReward('stack4', 'BigZone')),
            getStack(4, 1, getReward('stack4_wand', 'BigZone')),
            getStack(4, 5, getReward('stack5', 'BigZone')),
            getStack(5, 1, getReward('stackArt', 'BigZone'))},
        ruins = {getRuins({min = 320, max = 380}, getGuardRuins(3), getReward('ruinst3.1', 'BigZone14')),
                 getRuins({min = 350, max = 400}, getGuardRuins(3), getReward('ruinst3.2', 'BigZone14')),
                 getRuins({min = 420, max = 530}, getGuardRuins(4), getReward('ruinst4', 'BigZone14')),
                },
        mercenaries = {getMercenaries1(getGuard(3))},
        merchants = {{goods = {items = getReward('merchants', 'BigZone')},
                      guard = getGuard(3, getReward('guard', 'merchantst2'))}},
        mages = {getMagicTower(2, getGuard(3, getReward('guard', 'maget2')))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZtownt3')), getReward('townt3', 'BigZone14', playerRace)),
                },
        bags = getBags(7, getReward('bags', 'BigZone'))
	}
end

function getBigZone2(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone25(playerRace),
        stacks = {
            getStack(2, 3, getReward('stack1', 'BigZone')),
			getStack(3, 4, getReward('stack2', 'BigZone')),
            getStack(3, 5, getReward('stack3', 'BigZone')),
            getStack(4, 5, getReward('stack4', 'BigZone')),
            getStack(4, 5, getReward('stack5', 'BigZone')),
            getStack(4, 1, getReward('stack4_wand', 'BigZone')),
            getStack(5, 1, getReward('stackArt', 'BigZone'))},
        ruins = {getRuins({min = 320, max = 380}, getGuardRuins(3), getReward('ruinst3.1', 'BigZone25')),
                 getRuins({min = 350, max = 400}, getGuardRuins(4), getReward('ruinst3.2', 'BigZone25')),
                 getRuins({min = 420, max = 530}, getGuardRuins(4), getReward('ruinst4.1', 'BigZone25')),
                 getRuins({min = 420, max = 530}, getGuardRuins(5), getReward('ruinst4.2', 'BigZone25'))
                },
        merchants = {{goods = {items = getReward('merchants', 'BigZone')},
                      guard = getGuard(3, getReward('guard', 'merchantst2'))}},
        mages = {getMagicTower(2, getGuard(3, getReward('guard', 'maget2')))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZtownt3')), getReward('townt3', 'BigZone25', playerRace)),
                },
        bags = getBags(7, getReward('bags', 'BigZone'))
	}
end

function getBigZone4(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone14(playerRace),
        stacks = {
            getStack(2, 3, getReward('stack1', 'BigZone')),
			getStack(3, 4, getReward('stack2', 'BigZone')),
            getStack(3, 4, getReward('stack3', 'BigZone')),
            getStack(4, 4, getReward('stack4', 'BigZone')),
            getStack(4, 1, getReward('stack4_wand', 'BigZone')),
            getStack(4, 5, getReward('stack5', 'BigZone')),
            getStack(5, 1, getReward('stackArt', 'BigZone'))},
        ruins = {getRuins({ min = 320, max = 380 }, getGuardRuins(3), getReward('ruinst3.1', 'BigZone14')),
                 getRuins({ min = 350, max = 400 }, getGuardRuins(3), getReward('ruinst3.2', 'BigZone14')),
                 getRuins({ min = 420, max = 530 }, getGuardRuins(4), getReward('ruinst4', 'BigZone14')),
                },
        mercenaries = {getMercenaries4(getGuard(3))},
        merchants = {{goods = {items = getReward('merchants', 'BigZone')},
                      guard = getGuard(3, getReward('guard', 'merchantst2'))}},
        mages = {getMagicTower(2, getGuard(3, getReward('guard', 'maget2')))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZtownt3')), getReward('townt3', 'BigZone14', playerRace)),
                },
        bags = getBags(7, getReward('bags', 'BigZone'))
	}
end

function getBigZone5(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesBigZone25(playerRace),
        stacks = {
            getStack(2, 3, getReward('stack1', 'BigZone')),
			getStack(3, 4, getReward('stack2', 'BigZone')),
            getStack(3, 5, getReward('stack3', 'BigZone')),
            getStack(4, 5, getReward('stack4', 'BigZone')),
            getStack(4, 5, getReward('stack5', 'BigZone')),
            getStack(4, 1, getReward('stack4_wand', 'BigZone')),
            getStack(5, 1, getReward('stackArt', 'BigZone'))},
        ruins = {getRuins({ min = 320, max = 380 }, getGuardRuins(3), getReward('ruinst3.1', 'BigZone25')),
                 getRuins({ min = 350, max = 400 }, getGuardRuins(3), getReward('ruinst3.2', 'BigZone25')),
                 getRuins({ min = 420, max = 530 }, getGuardRuins(4), getReward('ruinst4.1', 'BigZone25')),
                 getRuins({ min = 420, max = 530 }, getGuardRuins(5), getReward('ruinst4.2', 'BigZone25'))
                },
        merchants = {{goods = {items = getReward('merchants', 'BigZone')},
                      guard = getGuard(3, getReward('guard', 'merchantst2'))}},
        mages = {getMagicTower(2, getGuard(3, getReward('guard', 'maget2')))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZtownt3') ), getReward('townt3', 'BigZone25', playerRace)),
                },
        bags = getBags(7, getReward('bags', 'BigZone')),
	}
end

function getVSZone(zoneId, playerRace, playerRace2, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        mines = getMinesVS(playerRace, playerRace2),
        stacks = {
            getStack(4, 6, getReward('stackt4', 'VSZone')),
            getStack(5, 8, getReward('stackt5', 'VSZone')),
            getStack(6, 8, getReward('stackt6', 'VSZone'))
        },
        ruins = {
            getRuins({min = 550, max = 685}, getGuardRuins(5), getReward('ruins', 'VSZonet5')),
            getRuins({min = 420, max = 530}, getGuardRuins(4), getReward('ruins', 'VSZonet4')),
        },
        merchants = {{goods = {items = getReward('merchants', 'VSZone')},
                      guard = getGuard(4, getReward('guard', 'merchantst3'))}},
        mages = {getMagicTower(3, getGuard(4, getReward('guard', 'maget3')))},
        towns = {getTown(4, getGuard(4, getReward('guard', 'vstownt4')), getReward('townt4', 'VSZone')),
                 getTown(5, getGuard(5, getReward('guard', 'vstownt5')), getReward('townt5', 'VSZone'))},
        bags = getBags(6, getReward('bags', 'VSZone'))
	}
end

local bigZone1Id = 1
local bigZone2Id = 2
local bigZone4Id = 4
local bigZone5Id = 5
local startZone1Id = 0
local startZone2Id = 3
local VSZoneId = 6

function getZones(races)

    -- local tilesTotal = 72*72
	-- local BigZoneSize = tilesTotal / 7
	-- local StartZoneSize = tilesTotal / 14
	-- local VSZoneSize = math.floor(tilesTotal / 3.5)


	local BigZoneSize = 1600
	local StartZoneSize = 1200
	local VSZoneSize = 1600

	local zones = {}

    zones[1] = getStartZone(startZone1Id, races[1], StartZoneSize)  --- красная зона
    zones[2] = getBigZone1(bigZone1Id, races[1], BigZoneSize) ----------------- зелёная зона
    zones[3] = getBigZone5(bigZone5Id, races[1], BigZoneSize) ----------------- серая зона
	zones[4] = getVSZone(VSZoneId, races[1], races[2], VSZoneSize) -------------------- жёлтая зона
    zones[5] = getBigZone2(bigZone2Id, races[2], BigZoneSize)  ---------------- синяя зона
	zones[6] = getBigZone4(bigZone4Id, races[2], BigZoneSize) ----------------- чёрная зона
	zones[7] = getStartZone(startZone2Id, races[2], StartZoneSize) ---- белая зона

	return zones
end

-- Описывает соединение зон
function getConnections()
	return {
		{from = 0, to = 1, guard = getGuard( 3, getReward('guard', 'BigZone'))},
		{from = 0, to = 5, guard = getGuard( 3, getReward('guard', 'BigZone'))},
		{from = 1, to = 6, guard = getGuard( 6, getReward('guard', 'GO14'))},
		{from = 2, to = 6, guard = getGuard( 6, getReward('guard', 'GO25'))},
        {from = 1, to = 2, guard = getGuard( 5, getReward('guard', 'BZ'))},
        {from = 4, to = 5, guard = getGuard( 5, getReward('guard', 'BZ'))},
        {from = 5, to = 6, guard = getGuard( 6, getReward('guard', 'GO25'))},
        {from = 4, to = 6, guard = getGuard( 6, getReward('guard', 'GO14'))},
        {from = 3, to = 4, guard = getGuard( 3, getReward('guard', 'BigZone'))},
        {from = 3, to = 2, guard = getGuard( 3, getReward('guard', 'BigZone'))},
	}
end

function getTemplateContents(races)
	return {
		zones = getZones(races),
		connections = getConnections()
	}
end

template = {
	name = 'VerSus 0.8',
	description = 'VerSus 0.8 by iSkromny, sMNS 2, 72x72, 2 players, the yellow zone must be touched by green, blue, gray and black',
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
        'g000uu8209', -- гибельный рой
        'g000uu6116', -- мантикора
        'g000uu6016', -- мантикора лидер   
        'g000uu8265', -- дева пламени
        },
}   forbiddenItems = {
        'g000ig3007', -- коготь
        'g001ig0155', -- имун к разрушению брони
        'g000ig3021', -- шанс к полиморфу
        'g001ig0414', -- шанс на паралич
}
