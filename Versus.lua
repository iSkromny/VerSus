-- template: versus
-- author: iSkromny
------------------------------------------------------------------------------------------------------------------------------------------------------------------

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

function getNativeSubraces(race)
    if race == Race.Human then return { Subrace.Human } end
    if race == Race.Dwarf then return { Subrace.Dwarf } end
    if race == Race.Heretic then return { Subrace.Heretic } end
    if race == Race.Undead then return { Subrace.Undead } end
    if race == Race.Elf then return { Subrace.Elf } end
    return { Subrace.Neutral }
end


function getStartMines(race)
    local rollofthedice = math.random(0, 3)
    local mines = {
        gold = 2,
    }
	if race == Race.Human then
		mines.lifeMana = 2
        if rollofthedice == 0 then mines.groveMana = 1
        elseif rollofthedice == 1 then mines.runicMana = 1
        elseif rollofthedice == 2 then mines.infernalMana = 1
        elseif rollofthedice == 3 then  mines.deathMana = 1
        end
	elseif race == Race.Dwarf then
		mines.runicMana = 2
        if rollofthedice == 0 then mines.groveMana = 1
        elseif rollofthedice == 1 then mines.lifeMana = 1
        elseif rollofthedice == 2 then mines.infernalMana = 1
        elseif rollofthedice == 3 then mines.deathMana = 1
        end
	elseif race == Race.Undead then
		mines.deathMana = 2
        if rollofthedice == 0 then mines.groveMana = 1
        elseif rollofthedice == 1 then mines.runicMana = 1
        elseif rollofthedice == 2 then mines.infernalMana = 1
        elseif rollofthedice == 3 then mines.lifeMana = 1
        end
	elseif race == Race.Heretic then
		mines.infernalMana = 2
        if rollofthedice == 0 then mines.groveMana = 1
        elseif rollofthedice == 1 then mines.runicMana = 1
        elseif rollofthedice == 2 then mines.lifeMana = 1
        elseif rollofthedice == 3 then mines.deathMana = 1
        end
	elseif race == Race.Elf then
		mines.groveMana = 2
        if rollofthedice == 0 then mines.lifeMana = 1
        elseif rollofthedice == 1 then mines.runicMana = 1
        elseif rollofthedice == 2 then mines.infernalMana = 1
        elseif rollofthedice == 3 then mines.deathMana = 1
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

function getMines1245()
    local mines = { }
    local rollofthedice = math.random(0, 4)
    if rollofthedice == 0 then
        mines.lifeMana = 1
    elseif rollofthedice == 1 then
        mines.runicMana = 1
    elseif rollofthedice == 2 then
        mines.infernalMana = 1
    elseif rollofthedice == 3 then
        mines.deathMana = 1
    elseif rollofthedice == 4 then
        mines.groveMana = 1
    end
    return mines
end

function getResourceMarket(Guard)
    return {
    {
        exchangeRates = [[
            function getExchangeRates(visitor)
                    local r1 = 4
                    local r2 = 1
                    local r3 = 3
                return {
                    {
                        Resource.Gold,
                        {
                        { Resource.LifeMana, r3, r2 },
                        { Resource.DeathMana, r3, r2 },
                        { Resource.RunicMana, r3, r2 },
                        { Resource.InfernalMana, r3, r2 },
                        { Resource.GroveMana, r3, r2 }
                        }
                    },
                    {
                        Resource.GroveMana,
                        {
                        { Resource.LifeMana, r1, r2 },
                        { Resource.DeathMana, r1, r2 },
                        { Resource.RunicMana, r1, r2 },
                        { Resource.InfernalMana, r1, r2 },
                        { Resource.Gold, r3, r2 }
                        }
                    },
                    {
                        Resource.LifeMana,
                        {
                        { Resource.Gold, r3, r2 },
                        { Resource.DeathMana, r1, r2 },
                        { Resource.RunicMana, r1, r2 },
                        { Resource.InfernalMana, r1, r2 },
                        { Resource.GroveMana, r1, r2 }
                        }
                    },
                    {
                        Resource.RunicMana,
                        {
                        { Resource.LifeMana, r1, r2 },
                        { Resource.DeathMana, r1, r2 },
                        { Resource.Gold, r3, r2 },
                        { Resource.InfernalMana, r1, r2 },
                        { Resource.GroveMana, r1, r2 }
                        }
                    },
                    {
                        Resource.DeathMana,
                        {
                        { Resource.LifeMana, r1, r2 },
                        { Resource.Gold, r3, r2 },
                        { Resource.RunicMana, r1, r2 },
                        { Resource.InfernalMana, r1, r2 },
                        { Resource.GroveMana, r1, r2 }
                        }
                    },
                    {
                        Resource.InfernalMana,
                        {
                        { Resource.LifeMana, r1, r2 },
                        { Resource.DeathMana, r1, r2 },
                        { Resource.RunicMana, r1, r2 },
                        { Resource.Gold, r3, r2 },
                        { Resource.GroveMana, r1, r2 }
                        }
                    }
                    },
                }
            end
    ]],
        stock = {
            {resource = Resource.Gold, value = { min = 900, max = 900 }},
            {resource = Resource.GroveMana, value = { min = 500, max = 500 }},
            {resource = Resource.LifeMana, value = { min = 500, max = 500 }},
            {resource = Resource.RunicMana, value = { min = 500, max = 500 }},
            {resource = Resource.DeathMana, value = { min = 500, max = 500 }},
            {resource = Resource.InfernalMana, value = { min = 500, max = 500 }}
            },
            guard = Guard
        }
    }
    end


function getCapitalName(playerRace)
    local name = nil
        if playerRace == Race.Undead then
            name = '����������'
        elseif playerRace == Race.Dwarf then
            name = '�����'
        elseif playerRace == Race.Elf then
            name = '����'
        elseif playerRace == Race.Heretic then
            name = '�������'
        elseif playerRace == Race.Human then
            name = '�������'
        end
        return name
end    

math.randomseed(os.time())

function dropChance(probability)
    if type(probability) ~= "number" or probability < 0 or probability > 100 then
        error("Probability must be a number between 0 and 100")
    end
    local chance = probability / 100
    local random = math.random()
    return random <= chance
end

function getStack(tier, stackCount, itemsTable, nstack)
    local squad = { }
    if (tier == 1) then squad = SubraceSquad(1)
    elseif (tier == 2 or tier == 3) then squad = SubraceSquad(2)
    elseif (tier == 4) then squad = SubraceSquad(3)
    elseif (tier == 5 or tier == 6 or tier == 7) then squad = SubraceSquad(4)
    end
    local expValueStack = { }
    if (tier == 1) then
        expValueStack.min = 180 * stackCount
        expValueStack.max = 240 * stackCount
    elseif (tier == 2) then
        expValueStack.min = 240 * stackCount
        expValueStack.max = 310 * stackCount
    elseif (tier == 3) then
        expValueStack.min = 320 * stackCount
        expValueStack.max = 450 * stackCount
    elseif (tier == 4) then
        expValueStack.min = 450 * stackCount
        expValueStack.max = 710 * stackCount
    elseif (tier == 5) then
        expValueStack.min = 690 * stackCount
        expValueStack.max = 1140 * stackCount
    elseif (tier == 6) then
        expValueStack.min = 1060 * stackCount
        expValueStack.max = 1640 * stackCount
    elseif (tier == 7) then
        expValueStack.min = 1600 * stackCount
        expValueStack.max = 2200 * stackCount
    end
    return {
        count = stackCount,
        subraceTypes = squad,
        value = expValueStack,
        owner = Race,
        loot = {items = itemsTable},
        name = nstack
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
        expValueGuard.min = 1200
        expValueGuard.max = 2150
    end
    return {
        subraceTypes = squad,
        value = expValueGuard,
        loot = {
            items = itemsTable
        }
    }
end

function getTown(townTier, getGuard, itemsTable, ntown)
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
        expValue.min = 990 * 1.1
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
        stack = getGuard,
        name = ntown
    }
end

function getRuins(tier, ruinsGold, ruinsItem, nruins)
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
        expValueGuard.min = 280
        expValueGuard.max = 360
    elseif (tier == 3) then
        expValueGuard.min = 360
        expValueGuard.max = 510
    elseif (tier == 4) then
        expValueGuard.min = 500
        expValueGuard.max = 790
    elseif (tier == 5) then
        expValueGuard.min = 780
        expValueGuard.max = 1230
    elseif (tier == 6) then
        expValueGuard.min = 1100
        expValueGuard.max = 1760
    end
	return {
        gold = ruinsGold,
        guard = {
			subraceTypes = squadStack,
			value = expValueGuard},
        loot = {items = ruinsItem},
        name = nruins
    }
end

function getBags(countBags, itemsBags)
    return {
            count = countBags,
            loot = {items = itemsBags},
        }
end

function ili(x, y)
    local random = math.random(0,1)
    if random == 0 then
        return x
    elseif random == 1 then
        return y
    end
end

function wtf(x, y, z)
    local random = math.random(0,2)
    if random == 0 then
        return x
    elseif random == 1 then
        return y
    elseif random == 2 then
        return z
    end
end

function rand(...)
    return (select(math.random(select('#', ...)), ...))
end




local ElexirDotProtection = {'g001ig0329', 'g001ig0351', 'g001ig0343', 'g001ig0341'}
local ElexirProtection = {'g000ig0022', 'g000ig0021', 'g000ig0023', 'g000ig0024', 'g001ig0125', 'g001ig0036'}
local LowElexir = {'g000ig0014','g000ig0008', 'g000ig0011', 'g000ig0002', 'g001ig0560', 'g001ig0547', 'g001ig0490'}
local MediumElexir = {'g000ig0009', 'g000ig0012', 'g000ig0015', 'g001ig0491', 'g001ig0127', 'g001ig0562', 'g000ig0003', 'g002ig0008'}
local HighElexir = {'g000ig0020', 'g000ig0019', 'g000ig0017', 'g001ig0126', 'g002ig0006', 'g002ig0007', 'g001ig0355', 'g001ig0128'}
local LowPermanent = {'g001ig0315', 'g001ig0309', 'g001ig0313', 'g001ig0130', 'g001ig0311', 'g001ig0307', 'g001ig0083'}
local MediumPermanent = {'g001ig0317', 'g001ig0516', 'g000ig0010', 'g000ig0016', 'g000ig0013', 'g000ig0004', 'g001ig0548', 'g001ig0534'}
local HighPermanent = {'g001ig0376', 'g001ig0518', 'g001ig0312', 'g001ig0308', 'g001ig0316', 'g001ig0310', 'g001ig0318'}
local Permanent_no_pull = {'g001ig0532', 'g001ig0533', 'g001ig0513', 'g001ig0006', 'g001ig0519', 'g001ig0521',}
--  'g001ig0513' -- +5 �����. 'g001ig0519' - 10  �����, 'g001ig0521', - 20 �����, g001ig0006 - -50% ����
local AuraPermanentLow = {'g001ig0026', 'g001ig0027', 'g001ig0563', 'g001ig0028', 'g001ig0034', 'g001ig0029', 'g001ig0030'}
local AuraPermanentHigh = {'g001ig0031', 'g001ig0564', 'g001ig0024', 'g001ig0021', 'g001ig0023',  'g001ig0022', 'g001ig0025', 'g001ig0019'}
local ElexirPermanentDot = {'g001ig0332', 'g001ig0342', 'g001ig0346', 'g001ig0330', 'g001ig0328', 'g001ig0352', 'g001ig0338', 'g001ig0340', 'g001ig0336', 'g001ig0344', 'g001ig0354', 'g001ig0348'}
local ElexirPermanentProtected = {'g001ig0320', 'g001ig0323', 'g001ig0321', 'g001ig0322', 'g001ig0325', 'g001ig0326'}
local Permanentskill = {'g001ig0530', 'g001ig0527', 'g001ig0531', 'g001ig0525', 'g001ig0529', 'g001ig0526', 'g001ig0501', 'g001ig0528'}
local TalismanSummont1 = {'g001ig0267', 'g001ig0265', 'g001ig0266', 'g001ig0264', 'g000ig9101'}
local TalismanT1 = {'g001ig0184', 'g000ig9105', 'g000ig9131', 'g000ig9120'}
local TalismanT2 = {'g000ig9130', 'g000ig9128', 'g000ig9123', 'g001ig0063', 'g000ig9116'}
local TalismanT3 = {'g000ig9136', 'g001ig0185', 'g000ig9140'}
local scrollT1 = {'g001ig0407', 'g000ig5022', 'g000ig5064', 'g000ig5044', 'g000ig5021', 'g001ig0250', 'g001ig0247', 'g001ig0073', 'g000ig5002', 'g000ig5106', 'g001ig0248', 'g000ig5023', 'g000ig5003', 'g000ig5101', 
    'g000ig5045', 'g000ig5065', 'g001ig0252', 'g000ig5102', 'g000ig5042', 'g000ig5041', 'g000ig5025', 'g000ig5061', 'g000ig5098', 'g000ig5084', 'g001ig0492', 'g000ig5009', 'g000ig5007', 'g000ig5119', 
    'g001ig0072', 'g001ig0574', 'g001ig0084', 'g001ig0194', 'g001ig0573', 'g001ig0255', 'g001ig0254', 'g000ig5050', 'g000ig5049', 'g001ig0253', 'g000ig5069', 'g001ig0256', 'g000ig5020', 'g001ig0568', 'g001ig0569',
    'g001ig0193', 'g000ig5030', 'g000ig5029', 'g000ig5068', 'g000ig5034', 'g000ig5088', 'g000ig5107', 'g000ig5047', 'g000ig5046', 'g000ig5066',
    'g000ig5008', 'g000ig5103', 'g001ig0249', 'g000ig5005', 'g000ig5001', 'g000ig5010', 'g000ig5016', 'g001ig0251', 'g001ig0123', 'g001ig0092', 'g001ig0085'}

local scrollT2 = {'g001ig0165', 'g001ig0580', 'g001ig0577', 'g001ig0576', 'g001ig0578', 'g001ig0579', 'g000ig5012', 'g000ig5026', 'g001ig0572', 'g000ig5111', 'g000ig5089', 'g000ig5013', 'g000ig5110', 'g000ig5073', 
    'g000ig5074', 'g000ig5052', 'g001ig0570', 'g000ig5040', 'g000ig5085', 'g000ig5011', 'g000ig5018', 'g000ig5079', 'g000ig5059', 'g000ig5031', 'g000ig5071', 'g000ig5108'}

local scrollT3 = {'g000ig5114', 'g000ig5035', 'g000ig5055', 'g000ig5076', 'g000ig5115', 'g000ig5017', 'g000ig5036', 'g000ig5082', 'g000ig5116',
    'g000ig5075', 'g000ig5113', 'g000ig5091', 'g001ig0586', 'g000ig5039', 'g000ig5057', 'g000ig5118'}

local scrollDmgT1 = {'g000ig5024', 'g000ig5043', 'g000ig5097', 'g000ig5004', 'g000ig5062', 'g000ig5063'}
local scrollDmgT2 = {'g000ig5048', 'g000ig5028', 'g000ig5067', 'g000ig5104'}
local scrollDmgT3 = {'g000ig5054', 'g000ig5109', 'g000ig5033', 'g000ig5014', 'g000ig5072'}

local weakOrbs = {'g001ig0189', 'g001ig0178', 'g001ig0472', 'g001ig0192', 'g001ig0473', 'g001ig0470', 'g001ig0458', 'g000ig9033', 'g001ig0302', 'g000ig9022', 'g000ig9031', 'g001ig0471', 'g000ig9017', 'g001ig0446'}
local mediumOrbs = {'g001ig0450', 'g001ig0464', 'g001ig0176', 'g001ig0133', 'g001ig0191', 'g001ig0304', 'g001ig0467', 'g001ig0468', 'g001ig0469', 'g000ig9018', 'g001ig0453', 'g001ig0454', 'g001ig0300', 'g001ig0496',
                    'g001ig0187', 'g001ig0456', 'g001ig0474', 'g001ig0475', 'g000ig9042', 'g001ig0478', 'g001ig0443', 'g000ig9024', 'g001ig0461',}
local strongOrbs = {'g000ig9025', 'g001ig0303', 'g001ig0477', 'g000ig9027', 'g001ig0459', 'g000ig9023', 'g001ig0136', 'g000ig9021', 'g000ig9016', 'g001ig0455', 'g000ig9032', 'g001ig0479', 'g001ig0134'}
local strongOrbs2 = {'g000ig9043', 'g000ig9020', 'g001ig0131', 'g001ig0183', 'g001ig0462', 'g001ig0203', 'g000ig9014', 'g001ig0480', 'g000ig9028', 'g001ig0457', 'g001ig0466', 'g001ig0489'}
local CurseOrbs = {'g001ig0295', 'g000ig9006', 'g000ig9039', 'g000ig9007', 'g001ig0181', 'g000ig9040'}
local RezistOrbs = {'g001ig0056', 'g001ig0054', 'g001ig0055', 'g001ig0053', 'g001ig0058', 'g001ig0057'}
local startOrbs = {'g001ig0178', 'g001ig0472','g001ig0192', 'g001ig0473'}

local smallValuable = {'g000ig7001', 'g001ig0431', 'g000ig7002'}
local mediumValuable = {'g001ig0433', 'g001ig0432', 'g000ig7004', 'g000ig7003'}
local bigValuable = {'g000ig7007', 'g000ig7008', 'g000ig7005', 'g000ig7006'}
local smallballmana = {'g001ig0481', 'g001ig0485', 'g001ig0482', 'g001ig0483', 'g001ig0484', 'g001ig0486'}
local mediumballmana = {'g001ig0146', 'g001ig0150', 'g001ig0147', 'g001ig0148', 'g001ig0149', 'g001ig0151'}
local bigballmana = {'g001ig0277', 'g001ig0281', 'g001ig0278', 'g001ig0279', 'g001ig0280', 'g001ig0282'}

local ArtT1 = {'g001ig0611', 'g000ig2001', 'g000ig2002', 'g000ig3001', 'g001ig0100', 'g001ig0182'}
local ArtT1Merchant = {'g001ig0611', 'g001ig0418', 'g000ig2001', 'g000ig2002', 'g000ig3001', 'g001ig0100', 'g001ig0182'}
local ArtT2 = {'g001ig0582', 'g001ig0558', 'g001ig0557', 'g001ig0047', 'g000ig3017', 'g001ig0487', 'g001ig0589'}
local ArtT2Merchant = {'g001ig0582', 'g001ig0558', 'g001ig0557', 'g001ig0047', 'g001ig0594','g000ig3017', 'g001ig0487', 'g001ig0589'}
local ArtT3 = {'g000ig3002', 'g001ig0042', 'g001ig0045', 'g000ig2003', 'g001ig0559', 'g001ig0416', 'g001ig0591', 'g001ig0196',  'g000ig9137', 'g001ig0197', 'g001ig0158'}
local ArtT3Merchant = {'g000ig3002', 'g001ig0155', 'g001ig0042', 'g001ig0045', 'g000ig2003', 'g001ig0040', 'g001ig0559', 'g001ig0416', 'g001ig0591',
    'g001ig0173', 'g001ig0196',  'g000ig9137', 'g001ig0197', 'g001ig0158', 'g001ig0041'}
local ArtT4 = {'g001ig0124', 'g001ig0585', 'g001ig0046', 'g000ig2004', 'g001ig0060', 'g001ig0039',
    'g001ig0071', 'g001ig0411', 'g000ig3019', 'g000ig3006', 'g001ig0488', 'g001ig0413', 'g001ig0415', 'g000ig3004','g000ig9035'}
local ArtT4Merchant = {'g001ig0124', 'g001ig0612', 'g001ig0585', 'g001ig0046', 'g001ig0592', 'g000ig2004', 'g001ig0060', 'g001ig0590', 'g001ig0039',
    'g001ig0071', 'g001ig0411', 'g000ig3019', 'g000ig3006', 'g001ig0488', 'g001ig0413', 'g001ig0415', 'g000ig3004','g000ig9035'}
local ArtT5 = {'g001ig0179', 'g001ig0410', 'g000ig3018', 'g001ig0102', 'g001ig0412', 'g000ig2005', 'g001ig0043'}
local ArtT5Merchant = {'g001ig0179', 'g001ig0410', 'g000ig3018', 'g001ig0102', 'g001ig0412', 'g000ig2005', 'g001ig0043', 'g001ig0174'}

local JewelT1 = {'g001ig0101', 'g000ig4008', 'g000ig3008', 'g001ig0428', 'g000ig4006', 'g001ig0494', 'g000ig4004', 'g001ig0495', 'g001ig0497', 'g000ig4003', 'g000ig4005',
    'g000ig4001', 'g000ig4002', 'g001ig0493'}
local JewelT2 = {'g001ig0421', 'g001ig0420', 'g001ig0423', 'g000ig4007', 'g001ig0427', 'g001ig0099', 'g001ig0430', 'g001ig0539', 'g000ig3020', 'g001ig0605'}
local JewelT3 = {'g001ig0037', 'g001ig0424', 'g001ig0425', 'g001ig0597', 'g000ig3022', 'g001ig0610', 'g001ig0156', 'g000ig2006'}
local JewelT4 = {'g001ig0104', 'g000ig7010', 'g000ig3005', 'g001ig0429', 'g001ig0116', 'g001ig0038','g001ig0419'}

local BannerT1 = {'g000ig1005', 'g001ig0051', 'g000ig1001', 'g000ig1007', 'g000ig1003'}
local BannerT2 = {'g001ig0369', 'g001ig0370', 'g001ig0142', 'g001ig0140', 'g001ig0141', 'g001ig0139', 'g001ig0145', 'g001ig0143', 'g001ig0293', 'g000ig1004', 'g001ig0365', 'g001ig0361',
    'g001ig0289', 'g000ig1008', 'g001ig0292', 'g001ig0357', 'g000ig1002', 'g000ig1006', 'g001ig0363', 'g001ig0364', 'g001ig0374', 'g001ig0358', 'g001ig0362'}
local BannerT3 = {'g001ig0373', 'g001ig0367', 'g001ig0360', 'g000ig1016', 'g000ig1017', 'g000ig1015', 'g001ig0290', 'g001ig0291', 'g001ig0359'}
local BannerT4 = {'g001ig0153', 'g001ig0144', 'g001ig0052', 'g001ig0366'}

local TravelT1 = {'g001ig0108', 'g001ig0107', 'g001ig0105', 'g001ig0109', 'g001ig0106', 'g001ig0113'}
local TravelT2 = {'g001ig0111', 'g000ig1010', 'g000ig8003', 'g001ig0606'}
local TravelT3 = {'g000ig8004', 'g001ig0114', 'g001ig0115', 'g001ig0112'}

local Wand = {'g001ig0387', 'g000ig6019', 'g001ig0397', 'g001ig0395', 'g001ig0394', 'g001ig0405', 'g001ig0402', 'g001ig0396', 'g001ig0399', 'g000ig6003', 'g000ig6012', 'g000ig6001'}
local Wand2 = {'g000ig6013', 'g000ig6011', 'g001ig0097', 'g001ig0388', 'g001ig0392', 'g001ig0403', 'g001ig0404', 'g001ig0401', 'g001ig0391', 'g000ig6014', 'g001ig0398'}
local Wand3 = {'g001ig0096', 'g000ig6015'}

function getReward(Type, Zone, playerRace)

local rewardItems = { }
local rnd = nil
local rnditem = math.random(1, 4)
----------------------------------------------------------------------------- RESP --------
if Type == 'townt1' and Zone == 'StartZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT1[math.random(#ArtT1)], min = 1, max = 1})
   
elseif Type == 'guard' and Zone == 'townt1' then
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
elseif Type == 'townt2' and Zone == 'StartZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = BannerT1[math.random(#BannerT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = smallballmana[math.random(#smallballmana)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'townt2' then
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})

elseif Type == 'ruinst1' and Zone == 'StartZone' then
    table.insert(rewardItems, {id = JewelT1[math.random(#JewelT1)], min = 1, max = 1})
elseif Type == 'ruinst2' and Zone == 'StartZone' then
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})

elseif Type == 'stack1' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
elseif Type == 'stack1.2' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = smallballmana[math.random(#smallballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
elseif Type == 'stack1.3' and Zone == 'startZone' then
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 2})
elseif Type == 'stack1.4' and Zone == 'startZone' then
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})
elseif Type == 'stack1.5' and Zone == 'startZone' then
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 1})
elseif Type == 'stack1.6' and Zone == 'startZone' then
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})
elseif Type == 'stack2' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g001ig0180', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
elseif Type == 'stack2.1' and Zone == 'startZone' then
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT1[math.random(#scrollDmgT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})
elseif Type == 'stack2.2' and Zone == 'startZone' then
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
elseif Type == 'stack2.3' and Zone == 'startZone' then
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 2})
    table.insert(rewardItems, {id = TalismanT1[math.random(#TalismanT1)], min = 1, max = 1})
elseif Type == 'stack2.4' and Zone == 'startZone' then
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
elseif Type == 'stack2.5' and Zone == 'startZone' then
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT1[math.random(#scrollDmgT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
elseif Type == 'stack2.6' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
elseif Type == 'stack2.7' and Zone == 'startZone' then
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
elseif Type == 'stack2.8' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    rnd = math.random(0,2)
    if rnd ~= 1 then
        table.insert(rewardItems, {id = 'g001ig0532', min = 1, max = 1}) -- +1 ꠰न󱳠
    end
elseif Type == 'stackhlvl' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})
    rnd = math.random(0,2)
    if rnd ~= 1 then
        table.insert(rewardItems, {id = RezistOrbs[math.random(#RezistOrbs)], min = 1, max = 1})
    end
elseif Type == 'guard' and Zone == 'mageResp' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0486', min = 1, max = 1}) -- 50 ⱥ頬୻
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
elseif Type == 'guard' and Zone == 'merchantsResp' then
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = Wand[math.random(#Wand)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
elseif Type == 'merchants' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 3, max = 3})
    table.insert(rewardItems, {id = 'g000ig0006', min = 3, max = 3})
    table.insert(rewardItems, {id = 'g000ig0005', min = 3, max = 3})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = ArtT1Merchant[math.random(#ArtT1Merchant)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT1Merchant[math.random(#ArtT1Merchant)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT1[math.random(#BannerT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT1[math.random(#JewelT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT1[math.random(#JewelT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = TravelT1[math.random(#TravelT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = TalismanSummont1[math.random(#TalismanSummont1)], min = 1, max = 1})
    table.insert(rewardItems, {id = TalismanT1[math.random(#TalismanT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})
elseif Type == 'bags' and Zone == 'startZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0180', min = 1, max = 1})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
---------- GO ---------- G0 ---------- GO ---------- GO ---------- GO ---------- G0 ---------- GO ----------
elseif Type == 'guardResp' and Zone == 'GOtoBigZone14' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0486', min = 1, max = 1}) -- 50 ���� ����
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
    table.insert(rewardItems, wtf({id = TravelT1[math.random(#TravelT1)], min = 1, max = 1}, {id = BannerT2[math.random(#BannerT2)], min = 1, max = 1}, {id = JewelT2[math.random(#JewelT2)], min = 1, max = 1}))
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})

elseif Type == 'guardResp' and Zone == 'GOtoBigZone25' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g001ig0486', min = 1, max = 1}) -- 50 ���� ����
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
    table.insert(rewardItems, wtf({id = TravelT1[math.random(#TravelT1)], min = 1, max = 1}, {id = BannerT2[math.random(#BannerT2)], min = 1, max = 1}, {id = JewelT2[math.random(#JewelT2)], min = 1, max = 1}))
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})

elseif Type == 'guardResp' and Zone == 'GOtoCenter0949' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = AuraPermanentHigh[math.random(#AuraPermanentHigh)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT4[math.random(#JewelT4)], min = 1, max = 1})

elseif Type == 'guardResp' and Zone == 'GOtoCenter0848' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = HighElexir[math.random(#HighElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = HighPermanent[math.random(#HighPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT4[math.random(#ArtT4)], min = 1, max = 1})

----------- BigZone ---------- BigZone ---------- BigZone ---------- BigZone ---------- BigZone ---------- BigZone ---------- BigZone ----------
elseif Type == 'townt3' and Zone == 'BigZone25' then
    if playerRace == Race.Human then table.insert(rewardItems, {id='g001ig0146', min = 1, max = 1})
    elseif playerRace == Race.Elf then table.insert(rewardItems, {id='g001ig0150', min = 1, max = 1})
    elseif playerRace == Race.Heretic then table.insert(rewardItems, {id='g001ig0147', min = 1, max = 1})
    elseif playerRace == Race.Dwarf then table.insert(rewardItems, {id='g001ig0148', min = 1, max = 1})
    elseif playerRace == Race.Undead then table.insert(rewardItems, {id='g001ig0149', min = 1, max = 1})
    end
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 3})
    table.insert(rewardItems, {id = 'g002ig0007', min = 1, max = 1}) -- ����� � ����� �� 1 ���
    table.insert(rewardItems, {id = 'g001ig0084', min = 1, max = 1}) -- ����������
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, ili({id = ArtT2[math.random(#ArtT2)], min = 1, max = 1}, {id = BannerT2[math.random(#BannerT2)], min = 1, max = 1}))
    rnd = math.random(0,2)
    if rnd == 1 then
        table.insert(rewardItems, {id = AuraPermanentLow[math.random(#AuraPermanentLow)], min = 1, max = 1})
    end
elseif Type == 'townt3' and Zone == 'BigZone14' then
    if playerRace == Race.Human then table.insert(rewardItems, {id='g001ig0146', min = 1, max = 1})
    elseif playerRace == Race.Elf then table.insert(rewardItems, {id='g001ig0150', min = 1, max = 1})
    elseif playerRace == Race.Heretic then table.insert(rewardItems, {id='g001ig0147', min = 1, max = 1})
    elseif playerRace == Race.Dwarf then table.insert(rewardItems, {id='g001ig0148', min = 1, max = 1})
    elseif playerRace == Race.Undead then table.insert(rewardItems, {id='g001ig0149', min = 1, max = 1})
    end
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 3})
    table.insert(rewardItems, {id = 'g002ig0007', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0084', min = 1, max = 1}) -- ����������
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, ili({id = BannerT2[math.random(#BannerT2)], min = 1, max = 1}, {id = JewelT2[math.random(#JewelT2)], min = 1, max = 1}))
    rnd = math.random(0,2)
    if rnd == 1 then
        table.insert(rewardItems, {id = AuraPermanentLow[math.random(#AuraPermanentLow)], min = 1, max = 1})
    end
elseif Type == 'guard' and Zone == 'BZtownt3' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 2, max = 2})
    table.insert(rewardItems, {id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g002ig0005', min = 2, max = 2}) -- +15% ������������� ����� �� 1 ���

elseif Type == 'ruinst3.1' and Zone == 'BigZone25' then
    table.insert(rewardItems, {id = ArtT2[math.random(#ArtT2)], min = 1, max = 1})
elseif Type == 'ruinst3.2' and Zone == 'BigZone25' then
    table.insert(rewardItems, {id = MediumPermanent[math.random(#MediumPermanent)], min = 1, max = 1})
elseif Type == 'ruinst4' and Zone == 'BigZone25' then
    table.insert(rewardItems, ili({id = JewelT2[math.random(#JewelT2)], min = 1, max = 1}, {id = ArtT3[math.random(#ArtT3)], min = 1, max = 1}))

elseif Type == 'ruinst3.1' and Zone == 'BigZone14' then
    table.insert(rewardItems, {id = TalismanT2[math.random(#TalismanT2)], min = 1, max = 1})
elseif Type == 'ruinst3.2' and Zone == 'BigZone14' then
    table.insert(rewardItems, {id = MediumPermanent[math.random(#MediumPermanent)], min = 1, max = 1})
elseif Type == 'ruinst4' and Zone == 'BigZone14' then
    table.insert(rewardItems, ili({id = ArtT2[math.random(#ArtT2)], min = 1, max = 1}, {id = JewelT2[math.random(#JewelT2)], min = 1, max = 1}))

elseif Type == 'guard' and Zone == 'mageBZ' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = 'g001ig0151', min = 1, max = 1}) -- 100 ���� ����

elseif Type == 'merchants' and Zone == 'BZ' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 3, max = 3})
    table.insert(rewardItems, {id = 'g000ig0006', min = 4, max = 4})
    table.insert(rewardItems, {id = 'g000ig0018', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = ArtT2Merchant[math.random(#ArtT2Merchant)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT2Merchant[math.random(#ArtT2Merchant)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT3Merchant[math.random(#ArtT3Merchant)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT3Merchant[math.random(#ArtT3Merchant)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT1[math.random(#BannerT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT2[math.random(#BannerT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT1[math.random(#JewelT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT2[math.random(#JewelT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = TravelT1[math.random(#TravelT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = TravelT2[math.random(#TravelT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 2})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = TalismanSummont1[math.random(#TalismanSummont1)], min = 1, max = 1})
    table.insert(rewardItems, {id = TalismanT2[math.random(#TalismanT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumPermanent[math.random(#MediumPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = Permanentskill[math.random(#Permanentskill)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g002ig0005', min = 1, max = 1}) -- 15% ������������� ����� �� 1 ���
    table.insert(rewardItems, {id = 'g002ig0007', min = 1, max = 1}) -- ������������� ����� �� 1 ���
elseif Type == 'guard' and Zone == 'merchantsBZ' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT2[math.random(#scrollDmgT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})

elseif Type == 'stack1' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
elseif Type == 'stack1.2' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = TalismanT2[math.random(#TalismanT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
elseif Type == 'stack2' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
elseif Type == 'stack2.1' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
elseif Type == 'stack2.2' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})
elseif Type == 'stack2.3' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = smallballmana[math.random(#smallballmana)], min = 1, max = 1})
elseif Type == 'stack2.4' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = Wand2[math.random(#Wand2)], min = 1, max = 1})
elseif Type == 'stack2.5' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 2})    
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
elseif Type == 'stack2.6' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
elseif Type == 'stack2.7' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1})
elseif Type == 'stack3' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
elseif Type == 'stack3.1' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})
    table.insert(rewardItems, {id = 'g001ig0532', min = 1, max = 1}) -- +1 � ������� ������
elseif Type == 'stack3.2' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
elseif Type == 'stack3.3' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
elseif Type == 'stack3.4' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
elseif Type == 'stack3.5' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
elseif Type == 'stack3.6' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
elseif Type == 'stack3.7' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = mediumValuable[math.random(#mediumValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT1[math.random(#scrollDmgT1)], min = 1, max = 1})
elseif Type == 'stack3.8' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = mediumballmana[math.random(#mediumballmana)], min = 1, max = 1})
elseif Type == 'stack5' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 2})
    table.insert(rewardItems, {id = AuraPermanentLow[math.random(#AuraPermanentLow)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})

elseif Type == 'bags' and Zone == 'BigZone' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = 'g000ig0005', min = 2, max = 2})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 2})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
--- Center --- Center --- Center --- Center --- Center --- Center --- Center --- Center --- Center --- Center --- Center --- Center --- Center --- Center --- Center --- Center ---
elseif Type == 'guardGO' and Zone == 'GOBZtoCenter' then
    rnd = math.random(0,2)
    if rnd == 1 then
        table.insert(rewardItems, {id = 'g001ig0513', min = 1, max = 1}) -- +5 ����� ������������ �������
    end
    table.insert(rewardItems, rnditem == 1 and {id = ArtT3[math.random(#ArtT3)]} or rnditem == 2 and {id = BannerT3[math.random(#BannerT3)]} or rnditem == 3 and {id = JewelT3[math.random(#JewelT3)]} or {id = TravelT3[math.random(#TravelT3)]})
    table.insert(rewardItems, {id = AuraPermanentLow[math.random(#AuraPermanentLow)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = HighElexir[math.random(#HighElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1})

elseif Type == 'townt5' and Zone == 'VSZone1' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 2})
    table.insert(rewardItems, wtf({id = ArtT4[math.random(#ArtT4)], min = 1, max = 1}, {id = BannerT4[math.random(#BannerT4)], min = 1, max = 1}, {id = JewelT4[math.random(#JewelT4)], min = 1, max = 1}))
    table.insert(rewardItems, {id = HighElexir[math.random(#HighElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0152', min = 1, max = 1})
    table.insert(rewardItems, {id = HighPermanent[math.random(#HighPermanent)], min = 1, max = 1})
elseif Type == 'townt5' and Zone == 'VSZone2' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 2})
    table.insert(rewardItems, wtf({id = ArtT4[math.random(#ArtT4)], min = 1, max = 1}, {id = BannerT4[math.random(#BannerT4)], min = 1, max = 1}, {id = JewelT4[math.random(#JewelT4)], min = 1, max = 1}))
    table.insert(rewardItems, {id = HighElexir[math.random(#HighElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0152', min = 1, max = 1})
    table.insert(rewardItems, {id = AuraPermanentHigh[math.random(#AuraPermanentHigh)], min = 1, max = 1})

elseif Type == 'guardtownt5' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = TalismanT2[math.random(#TalismanT2)], min = 1, max = 1})

elseif Type == 'ruins' and Zone == 'VSZone1' then
    table.insert(rewardItems, {id = ArtT5[math.random(#ArtT5)], min = 1, max = 1})
elseif Type == 'ruins' and Zone == 'VSZone2' then
    table.insert(rewardItems, {id = ArtT5[math.random(#ArtT5)], min = 1, max = 1})

elseif Type == 'guardVS' and Zone == 'GOVStoVS' then
    table.insert(rewardItems, {id = ArtT5[math.random(#ArtT5)], min = 1, max = 1})
    table.insert(rewardItems, {id = CurseOrbs[math.random(#CurseOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 2})
    table.insert(rewardItems, {id = 'g001ig0152', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0001', min = 1, max = 1})
    table.insert(rewardItems, {id = scrollDmgT3[math.random(#scrollDmgT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirPermanentDot[math.random(#ElexirPermanentDot)], min = 1, max = 1})
    table.insert(rewardItems, {id = strongOrbs2[math.random(#strongOrbs2)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirPermanentProtected[math.random(#ElexirPermanentProtected)], min = 1, max = 1})

elseif Type == 'guard' and Zone == 'mageVS' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = HighElexir[math.random(#HighElexir)], min = 1, max = 1})

elseif Type == 'merchants' and Zone == 'VS' then
    table.insert(rewardItems, {id = 'g000ig0001', min = 3, max = 3})
    table.insert(rewardItems, {id = 'g000ig0006', min = 3, max = 3})
    table.insert(rewardItems, {id = 'g000ig0018', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g001ig0152', min = 2, max = 2})
    table.insert(rewardItems, {id = ArtT4Merchant[math.random(#ArtT4Merchant)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT4Merchant[math.random(#ArtT4Merchant)], min = 1, max = 1})
    table.insert(rewardItems, {id = ArtT5Merchant[math.random(#ArtT5Merchant)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT4[math.random(#BannerT4)], min = 1, max = 1})
    table.insert(rewardItems, {id = BannerT4[math.random(#BannerT4)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT4[math.random(#JewelT4)], min = 1, max = 1})
    table.insert(rewardItems, {id = JewelT4[math.random(#JewelT4)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 2})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = HighElexir[math.random(#HighElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = HighElexir[math.random(#HighElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = mediumOrbs[math.random(#mediumOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = Wand2[math.random(#Wand2)], min = 1, max = 1})
    table.insert(rewardItems, {id = Wand3[math.random(#Wand3)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = TalismanT3[math.random(#TalismanT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT3[math.random(#scrollT3)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumPermanent[math.random(#MediumPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = Permanentskill[math.random(#Permanentskill)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g002ig0005', min = 1, max = 1}) -- 15% ������������� ����� �� 1 ���
    table.insert(rewardItems, {id = 'g002ig0007', min = 1, max = 1}) -- ������������� ����� �� 1 ���

elseif Type == 'merchantsguard' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})

elseif Type == 'stackt4' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = 'g000ig0005', min = 3, max = 3})
    table.insert(rewardItems, {id = smallballmana[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0151', min = 1, max = 1}) -- 100 ���� ����
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
elseif Type == 'stackt5' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 3, max = 3})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 3})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
elseif Type == 'stackt6' and Zone == 'VSZone' then
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 3, max = 3})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 2})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})

elseif Type == 'guard' and Zone == '12tocenter' then
    table.insert(rewardItems, {id = 'g000ig5068', min = 1, max = 1}) -- ����
    table.insert(rewardItems, {id = MediumPermanent[math.random(#MediumPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})

elseif Type == 'guard' and Zone == '45tocenter' then
    table.insert(rewardItems, {id = 'g000ig5068', min = 1, max = 1}) -- ����
    table.insert(rewardItems, {id = MediumPermanent[math.random(#MediumPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT2[math.random(#scrollT2)], min = 1, max = 1})
    table.insert(rewardItems, {id = strongOrbs[math.random(#strongOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})

elseif Type == 'bags' and Zone == '1245' then
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 2})
    table.insert(rewardItems, {id = bigValuable[math.random(#bigValuable)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0005', min = 1, max = 2})
    table.insert(rewardItems, {id = LowElexir[math.random(#LowElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirDotProtection[math.random(#ElexirDotProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})

elseif Type == 'guard' and Zone == 'BZto1245' then
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 2})
    table.insert(rewardItems, {id = 'g000ig0006', min = 1, max = 2})
    table.insert(rewardItems, {id = bigballmana[math.random(#bigballmana)], min = 1, max = 1})
    table.insert(rewardItems, {id = strongOrbs2[math.random(#strongOrbs2)], min = 1, max = 1})
    table.insert(rewardItems, {id = LowPermanent[math.random(#LowPermanent)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})

elseif Type == 'stack' and Zone == 'BZto1245' then
    table.insert(rewardItems, {id = 'g000ig0006', min = 2, max = 2})
    table.insert(rewardItems, {id = MediumElexir[math.random(#MediumElexir)], min = 1, max = 1})
    table.insert(rewardItems, {id = scrollT1[math.random(#scrollT1)], min = 1, max = 1})
    table.insert(rewardItems, {id = weakOrbs[math.random(#weakOrbs)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = ElexirProtection[math.random(#ElexirProtection)], min = 1, max = 1})
    table.insert(rewardItems, {id = 'g000ig0018', min = 1, max = 1})
    table.insert(rewardItems, {id = 'g001ig0378', min = 2, max = 2})
elseif Type == 'ruins' and Zone == '1245' then
    table.insert(rewardItems, {id = AuraPermanentLow[math.random(#AuraPermanentLow)], min = 1, max = 1})
end
    return rewardItems
end


    local spellt1 = {
    'g000ss0044', -- -5%dmg -5%accuracy Heretic
    'g000ss0064', -- -5%dmg -5%ini undead
    'g000ss0045', -- -10arm Heretic
    'g000ss0065', -- -10arm undead
    'g000ss0134', -- -10%acc undead
    'g000ss0178', -- -10%acc Human
    'g000ss0002', -- +7%ini Human
    'g000ss0007', -- +30hp Human
    'g000ss0021', -- +7%arm Dwarf
    'g000ss0181', -- +7%arm undead
    'g000ss0101', -- -10%dmg elf
    'g000ss0192', -- using orbs Neutral
    'g000ss0152', -- podkup
    'g000ss0191', -- using orbs Neutral
    'g000ss0003', -- +10%dmg human
    'g000ss0023', -- +10%dmg dwarf
    'g000ss0179', -- -10%ini dwarf
    'g000ss0106', -- -10%ini elf
    'g000ss0022'} -- walking in the forest dwarf
    local spellt1summon = {'g000ss0025', 'g000ss0061', 'g000ss0098'}
    local spellt2 = {
    'g000ss0180', -- water protection 
    'g000ss0050', -- -15%ini
    'g000ss0049', -- -15%dmg
    'g000ss0185', -- +10%acc +10%dmg
    'g000ss0107', -- 4*4 forest
    'g000ss0123', -- -15%krit
    'g000ss0034', -- +10%acc (two attack), protection from leveldown 
    'g000ss0197', -- bodyguard +15%
    'g000ss0005', -- water protection
    'g000ss0001', -- air protection
    'g000ss0010', -- earth protection
    'g000ss0016', -- fire protection
    'g000ss0121', -- -15%krit
    'g000ss0187', -- +15%dmg
    'g000ss0184', -- -15%dmg
    'g000ss0069', -- -15%dmg
    'g000ss0029', -- +40hp
    'g000ss0183', -- -15arm
    'g000ss0186', -- +10%acc +5%dmg
    'g000ss0182'} -- fire protection
    local spellt2summon = {'g000ss0046', 'g000ss0047', 'g000ss0008', 'g000ss0066', 'g000ss0103'}
    local spellt3 = {
    'g000ss0206', -- removes resist to fire and burns, replaces immun with resist
    'g000ss0207', -- removes resist to water and frost, replaces immun with resist
    'g000ss0089', -- -15%dmg -15%acc
    'g000ss0051', -- invis
    'g000ss0026', -- +12%ini
    'g000ss0011', -- mind protection
    'g000ss0018', -- death protection
    'g000ss0085', -- discount 20%
    'g000ss0209', -- removes resist to air and RB, replaces immun with resist
    'g000ss0201', -- +15%krit
    'g000ss0111', -- -15%acc -15%dmg
    'g000ss0205', -- removes resist to death, vamp, taum, replaces immun with resist
    'g000ss0073', -- +20%hp
    'g000ss0012', -- +12%arm   
    'g000ss0013', -- +15%acc +15%dmg
    'g000ss0208'} -- removes resist to earth and poison, replaces immun with resist
    -- local spellt4 =  {'g000ss0055', 'g000ss0036', 'g000ss0082', 'g000ss0116', 'g000ss0076', 'g000ss0114', 'g000ss0017', 'g000ss0115', 'g000ss0035', 'g000ss0075'}
function getMagicTower(tier, GuardTower)
    -- local rnd = nil
    local SpellList = { }
    if tier == 1 then
        for i = 1,4 do
            s = math.random(1, #spellt1)
            SpellList[i] = spellt1[s]
            table.remove(spellt1, s)
        end
        for i = 5,7 do
            s = math.random(1, #spellt2)
            SpellList[i] = spellt2[s]
            table.remove(spellt2, s)
        end
        for i = 8,8 do
            s = math.random(1, #spellt1summon)
            SpellList[i] = spellt1summon[s]
            table.remove(spellt1summon, s)
        end

    elseif tier == 2 then
        for i = 1,2 do
            s = math.random(1, #spellt1)
            SpellList[i] = spellt1[s]
            table.remove(spellt1, s)
        end
        for i = 3,5 do
            s = math.random(1, #spellt2)
            SpellList[i] = spellt2[s]
            table.remove(spellt2, s)
        end
        for i = 6,7 do
            s = math.random(1, #spellt3)
            SpellList[i] = spellt3[s]
            table.remove(spellt3, s)
        end
        for i = 8,8 do
            s = math.random(1, #spellt2summon)
            SpellList[i] = spellt2summon[s]
            table.remove(spellt2summon, s)
        end

    elseif tier == 3 then
        for i = 1,1 do
            s = math.random(1, #spellt1)
            SpellList[i] = spellt1[s]
            table.remove(spellt1, s)
        end
        for i = 2,2 do
            s = math.random(1, #spellt2)
            SpellList[i] = spellt2[s]
            table.remove(spellt2, s)
        end
        for i = 3,6 do
            s = math.random(1, #spellt3)
            SpellList[i] = spellt3[s]
            table.remove(spellt3, s)
        end
    end
    return
        {
        spells = SpellList,
        guard = GuardTower,
        }
end

function getMercenaries12(getGuard)
    local unitsMercenaries = {}
    local i = 1
-- melee
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7610', level = 1, unique = true} i = i + 1 end -- ������� ����� 490
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8306', level = 1, unique = true} i = i + 1 end -- ��������� 525
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7604', level = 1, unique = true} i = i + 1 end -- �������� ����� 525
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8041', level = 1, unique = true} i = i + 1 end -- ������ ���� ������ 625
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu8284', level = 1, unique = true} i = i + 1 end -- ���������� 690
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8247', level = 1, unique = true} i = i + 1 end -- ���������� 725
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu5012', level = 1, unique = true} i = i + 1 end -- ��� ������� 750
if math.random(0,2) == 1 then unitsMercenaries[i] = {id = 'g000uu8151', level = 1, unique = true} i = i + 1 end -- ����� 1215 
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu5032', level = 1, unique = true} i = i + 1 end -- ����� �������� 1400
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g003uu0023', level = 1, unique = true} i = i + 1 end -- ��������� 1650
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu5010', level = 1, unique = true} i = i + 1 end -- �������� �������� 2370
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu5014', level = 1, unique = true} i = i + 1 end -- ��� ����� 3000
if math.random(0,2) == 1 then unitsMercenaries[i] = {id = 'g000uu6117', level = 1, unique = true} i = i + 1 end -- �������� ���� 3250
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7600', level = 1, unique = true} i = i + 1 end -- ����� ���������� 3400
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu6115', level = 1, unique = true} i = i + 1 end -- ������ ������ 4500
-- archer
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu8282', level = 1, unique = true} i = i + 1 end -- �������� ���� 860
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8045', level = 1, unique = true} i = i + 1 end -- ������� 1070
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7617', level = 1, unique = true} i = i + 1 end -- ���� ������ 1070
if math.random(0,2) == 1 then unitsMercenaries[i] = {id = 'g001uu7594', level = 1, unique = true} i = i + 1 end -- ����� 1320
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8174', level = 1, unique = true} i = i + 1 end -- ������� ������� 1400
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7624', level = 1, unique = true} i = i + 1 end -- ������������ 1900
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7567', level = 1, unique = true} i = i + 1 end -- ���������� 1800
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7566', level = 1, unique = true} i = i + 1 end -- ���������� 1800
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8237', level = 1, unique = true} i = i + 1 end -- ���������� 1800
if math.random(0,2) == 1 then unitsMercenaries[i] = {id = 'g001uu8255', level = 1, unique = true} i = i + 1 end -- ����-���� 3200
-- mage
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8218', level = 1, unique = true} i = i + 1 end -- ����� 1750
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu8260', level = 1, unique = true} i = i + 1 end -- ���������� 3450
    return {
        units = unitsMercenaries,
        guard = getGuard
    }
end

function getMercenaries45(getGuard)
    local unitsMercenaries = {}
    local i = 1
-- melee
if math.random(0,2) == 1 then unitsMercenaries[i] = {id = 'g000uu7608', level = 1, unique = true} i = i + 1 end -- �������� 515
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7609', level = 1, unique = true} i = i + 1 end -- �������������� 525
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu5040', level = 1, unique = true} i = i + 1 end -- ������ 590
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu8283', level = 1, unique = true} i = i + 1 end -- �������� ���� 690
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7588', level = 1, unique = true} i = i + 1 end -- ���������� 725
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8276', level = 1, unique = true} i = i + 1 end -- ������������� 725
if math.random(0,2) == 1 then unitsMercenaries[i] = {id = 'g000uu6106', level = 1, unique = true} i = i + 1 end -- ��������� ������ 1200
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7560', level = 1, unique = true} i = i + 1 end -- �������� 1230
if math.random(0,2) == 1 then unitsMercenaries[i] = {id = 'g000uu8277', level = 1, unique = true} i = i + 1 end -- ���� ����� 1520
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7613', level = 1, unique = true} i = i + 1 end -- ��������� 1700
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7589', level = 1, unique = true} i = i + 1 end -- ������������ 2500
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8244', level = 1, unique = true} i = i + 1 end -- ��������� 3250
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8278', level = 1, unique = true} i = i + 1 end -- ������������ ����� 3400
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8153', level = 1, unique = true} i = i + 1 end -- ���� 4100
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8231', level = 1, unique = true} i = i + 1 end -- ������������� 4700
-- archer
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu8282', level = 1, unique = true} i = i + 1 end -- �������� ���� 860
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8045', level = 1, unique = true} i = i + 1 end -- ������� 1070
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7617', level = 1, unique = true} i = i + 1 end -- ���� ������ 1070
if math.random(0,2) == 1 then unitsMercenaries[i] = {id = 'g001uu7594', level = 1, unique = true} i = i + 1 end -- ����� 1320
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8174', level = 1, unique = true} i = i + 1 end -- ������� ������� 1400
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu7624', level = 1, unique = true} i = i + 1 end -- ������������ 1900
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7567', level = 1, unique = true} i = i + 1 end -- ���������� 1800
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu7566', level = 1, unique = true} i = i + 1 end -- ���������� 1800
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8237', level = 1, unique = true} i = i + 1 end -- ���������� 1800
if math.random(0,2) == 1 then unitsMercenaries[i] = {id = 'g001uu8255', level = 1, unique = true} i = i + 1 end -- ����-���� 3200
-- mage
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g000uu8218', level = 1, unique = true} i = i + 1 end -- ����� 1750
if math.random(0,1) == 1 then unitsMercenaries[i] = {id = 'g001uu8260', level = 1, unique = true} i = i + 1 end -- ���������� 3450
    return {
        units = unitsMercenaries,
        guard = getGuard
    }
end

function getStartZone(zoneId, playerRace, zoneSize)
    local startelexirprotection = {'g000ig0022', 'g000ig0021', 'g000ig0023', 'g000ig0024', 'g001ig0125', 'g001ig0036'}
    local startelexirdotprotection = {'g001ig0329', 'g001ig0351', 'g001ig0343', 'g001ig0341'}
    local StartItem = {
        {id = 'g000ig0001', min = 4, max = 4},
        {id = 'g000ig0006', min = 4, max = 4},
        {id = 'g000ig0005', min = 3, max = 3},
        {id = 'g001ig0180', min = 4, max = 4},
        ili({id = 'g000ig0011', min = 1, max = 1}, {id = 'g000ig0008', min = 1, max = 1}),
        ili({id = 'g000ig0002', min = 1, max = 1}, {id = 'g000ig0014', min = 1, max = 1}),
        {id = rand(startOrbs), min = 1, max = 1}
    }
    table.insert(StartItem, {id = smallValuable[math.random(#smallValuable)], min = 1, max = 1})
        for i = 1,3 do
            x = math.random(1, #startelexirprotection)
            table.insert(StartItem, {id = startelexirprotection[x], min = 1, max = 1})
            table.remove(startelexirprotection, x)
        end
        for i = 1,2 do
            x = math.random(1, #startelexirdotprotection)
            table.insert(StartItem, {id = startelexirdotprotection[x], min = 1, max = 1})
            table.remove(startelexirdotprotection, x)
        end
    if playerRace == Race.Human then table.insert(StartItem, {id = 'g001ig0146', min = 1, max = 1})
    elseif playerRace == Race.Elf then table.insert(StartItem, {id = 'g001ig0150', min = 1, max = 1})
    elseif playerRace == Race.Heretic then table.insert(StartItem, {id = 'g001ig0147', min = 1, max = 1})
    elseif playerRace == Race.Dwarf then table.insert(StartItem, {id = 'g001ig0148', min = 1, max = 1})
    elseif playerRace == Race.Undead then table.insert(StartItem, {id = 'g001ig0149', min = 1, max = 1})
    end
	return {
		id = zoneId,
		type = Zone.PlayerStart,
		race = playerRace,
		size = zoneSize,
        border = Border.Open,
        gapMask = 9,
        capital = {garrison =
                        {value = { min = 50, max = 50 },
                        subraceTypes = getNativeSubraces(playerRace),
                        loot = {items = StartItem}},
                        name = getCapitalName(playerRace)},
        mines = getStartMines(playerRace),
        stacks = {getStack(1, 1, getReward('stack1', 'startZone')), getStack(1, 1, getReward('stack1.2', 'startZone')), getStack(1, 1, getReward('stack1.3', 'startZone')),
                  getStack(1, 1, getReward('stack1.4', 'startZone')), getStack(1, 1, getReward('stack1.5', 'startZone')), getStack(1, 1, getReward('stack1.6', 'startZone')),
                  getStack(2, 1, getReward('stack2', 'startZone')), getStack(2, 1, getReward('stack2.1', 'startZone')), getStack(2, 1, getReward('stack2.2', 'startZone')), 
                  getStack(2, 1, getReward('stack2.3', 'startZone')),
                  getStack(2, 1, getReward('stack2.4', 'startZone')), getStack(2, 1, getReward('stack2.5', 'startZone')), getStack(2, 1, getReward('stack2.6', 'startZone')), 
                  getStack(2, 1, getReward('stack2.7', 'startZone')), getStack(2, 1, getReward('stack2.8', 'startZone')),
                  getStack(3, 1, getReward('stackhlvl', 'startZone'))},
        ruins = {getRuins(1, {min = 300, max = 330}, getReward('ruinst1', 'StartZone')),
                 getRuins(2, {min = 330, max = 360}, getReward('ruinst2', 'StartZone'))},
        merchants = {{goods = {items = getReward('merchants', 'startZone')},
                      guard = getGuard(2, getReward('guard', 'merchantsResp'))}},
        mages = {getMagicTower(1, getGuard(2, getReward('guard', 'mageResp')))},
        towns = {getTown(1, getGuard(1, getReward('guard', 'townt1')), getReward('townt1', 'StartZone')),
                 getTown(2, getGuard(2, getReward('guard', 'townt2')), getReward('townt2', 'StartZone'))},
        bags =  getBags(4, getReward('bags', 'startZone'))
    }
end

function getBigZone1(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        gapMask = 9,
        mines = getMinesBigZone14(playerRace),
        stacks = {
            getStack(2, 1, getReward('stack1', 'BigZone')), getStack(2, 1, getReward('stack1.2', 'BigZone')), getStack(2, 1),
			getStack(3, 1, getReward('stack2', 'BigZone')), getStack(3, 1, getReward('stack2.1', 'BigZone')), getStack(3, 1, getReward('stack2.2', 'BigZone')), 
            getStack(3, 1, getReward('stack2.3', 'BigZone')),
            getStack(3, 1, getReward('stack2.4', 'BigZone')), getStack(3, 1, getReward('stack2.5', 'BigZone')), getStack(3, 1, getReward('stack2.6', 'BigZone')), 
            getStack(3, 1, getReward('stack2.7', 'BigZone')),
            getStack(4, 1, getReward('stack3', 'BigZone')), getStack(4, 1, getReward('stack3.1', 'BigZone')), getStack(4, 1, getReward('stack3.2', 'BigZone')), 
            getStack(4, 1, getReward('stack3.3', 'BigZone')), getStack(4, 1, getReward('stack3.4', 'BigZone')),
            getStack(4, 1, getReward('stack3.6', 'BigZone')), getStack(4, 1, getReward('stack3.7', 'BigZone')), getStack(4, 1, getReward('stack3.8', 'BigZone')), 
            getStack(4, 1, getReward('stack3.9', 'BigZone')),
            getStack(5, 1, getReward('stack5', 'BigZone'))},
        ruins = {getRuins(3, {min = 360, max = 390}, getReward('ruinst3.1', 'BigZone14')),
                 getRuins(3, {min = 360, max = 390}, getReward('ruinst3.2', 'BigZone14')),
                 getRuins(4, {min = 400, max = 450}, getReward('ruinst4', 'BigZone14'))},
        merchants = {{goods = {items = getReward('merchants', 'BZ')},
                      guard = getGuard(3, getReward('guard', 'merchantsBZ'))}},
        mages = {getMagicTower(2, getGuard(3, getReward('guard', 'mageBZ')))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZtownt3')), getReward('townt3', 'BigZone14'))},
        bags = getBags(4, getReward('bags', 'BigZone'))
	}
end

function getBigZone2(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        gapMask = 9,
        mines = getMinesBigZone25(playerRace),
        stacks = {
            getStack(2, 1, getReward('stack1', 'BigZone')), getStack(2, 1, getReward('stack1.2', 'BigZone')), getStack(2, 1),
			getStack(3, 1, getReward('stack2', 'BigZone')), getStack(3, 1, getReward('stack2.1', 'BigZone')), getStack(3, 1, getReward('stack2.2', 'BigZone')), 
            getStack(3, 1, getReward('stack2.3', 'BigZone')),
            getStack(3, 1, getReward('stack2.4', 'BigZone')), getStack(3, 1, getReward('stack2.5', 'BigZone')), getStack(3, 1, getReward('stack2.6', 'BigZone')), 
            getStack(3, 1, getReward('stack2.7', 'BigZone')),
            getStack(4, 1, getReward('stack3', 'BigZone')), getStack(4, 1, getReward('stack3.1', 'BigZone')), getStack(4, 1, getReward('stack3.2', 'BigZone')), 
            getStack(4, 1, getReward('stack3.3', 'BigZone')), getStack(4, 1, getReward('stack3.4', 'BigZone')),
            getStack(4, 1, getReward('stack3.6', 'BigZone')), getStack(4, 1, getReward('stack3.7', 'BigZone')), getStack(4, 1, getReward('stack3.8', 'BigZone')), 
            getStack(4, 1, getReward('stack3.9', 'BigZone')),
            getStack(5, 1, getReward('stack5', 'BigZone'))},
        ruins = {getRuins(3, {min = 360, max = 390}, getReward('ruinst3.1', 'BigZone25')),
                 getRuins(3, {min = 360, max = 390}, getReward('ruinst3.2', 'BigZone25')),
                 getRuins(4, {min = 400, max = 450}, getReward('ruinst4', 'BigZone25'))},
        merchants = {{goods = {items = getReward('merchants', 'BZ')},
                      guard = getGuard(3, getReward('guard', 'merchantsBZ'))}},
        mages = {getMagicTower(2, getGuard(3, getReward('guard', 'mageBZ')))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZtownt3')), getReward('townt3', 'BigZone25'))},
        bags = getBags(4, getReward('bags', 'BigZone'))
	}
end

function getBigZone4(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        gapMask = 9,
        mines = getMinesBigZone14(playerRace),
        stacks = {
            getStack(2, 1, getReward('stack1', 'BigZone')), getStack(2, 1, getReward('stack1.2', 'BigZone')), getStack(2, 1),
			getStack(3, 1, getReward('stack2', 'BigZone')), getStack(3, 1, getReward('stack2.1', 'BigZone')), getStack(3, 1, getReward('stack2.2', 'BigZone')), 
            getStack(3, 1, getReward('stack2.3', 'BigZone')),
            getStack(3, 1, getReward('stack2.4', 'BigZone')), getStack(3, 1, getReward('stack2.5', 'BigZone')), getStack(3, 1, getReward('stack2.6', 'BigZone')), 
            getStack(3, 1, getReward('stack2.7', 'BigZone')),
            getStack(4, 1, getReward('stack3', 'BigZone')), getStack(4, 1, getReward('stack3.1', 'BigZone')), getStack(4, 1, getReward('stack3.2', 'BigZone')), 
            getStack(4, 1, getReward('stack3.3', 'BigZone')), getStack(4, 1, getReward('stack3.4', 'BigZone')),
            getStack(4, 1, getReward('stack3.6', 'BigZone')), getStack(4, 1, getReward('stack3.7', 'BigZone')), getStack(4, 1, getReward('stack3.8', 'BigZone')), 
            getStack(4, 1, getReward('stack3.9', 'BigZone')),
            getStack(5, 1, getReward('stack5', 'BigZone'))},
        ruins = {getRuins(3, {min = 360, max = 390}, getReward('ruinst3.1', 'BigZone14')),
                 getRuins(3, {min = 360, max = 390}, getReward('ruinst3.2', 'BigZone14')),
                 getRuins(4, {min = 400, max = 450}, getReward('ruinst4', 'BigZone14'))},
        merchants = {{goods = {items = getReward('merchants', 'BZ')},
                      guard = getGuard(3, getReward('guard', 'merchantsBZ'))}},
        mages = {getMagicTower(2, getGuard(3, getReward('guard', 'mageBZ')))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZtownt3')), getReward('townt3', 'BigZone14'))},
        bags = getBags(4, getReward('bags', 'BigZone'))
	}
end

function getBigZone5(zoneId, playerRace, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        gapMask = 9,
        mines = getMinesBigZone25(playerRace),
        stacks = {
            getStack(2, 1, getReward('stack1', 'BigZone')), getStack(2, 1, getReward('stack1.2', 'BigZone')), getStack(2, 1),
			getStack(3, 1, getReward('stack2', 'BigZone')), getStack(3, 1, getReward('stack2.1', 'BigZone')), getStack(3, 1, getReward('stack2.2', 'BigZone')), 
            getStack(3, 1, getReward('stack2.3', 'BigZone')),
            getStack(3, 1, getReward('stack2.4', 'BigZone')), getStack(3, 1, getReward('stack2.5', 'BigZone')), getStack(3, 1, getReward('stack2.6', 'BigZone')), 
            getStack(3, 1, getReward('stack2.7', 'BigZone')),
            getStack(4, 1, getReward('stack3', 'BigZone')), getStack(4, 1, getReward('stack3.1', 'BigZone')), getStack(4, 1, getReward('stack3.2', 'BigZone')), 
            getStack(4, 1, getReward('stack3.3', 'BigZone')), getStack(4, 1, getReward('stack3.4', 'BigZone')),
            getStack(4, 1, getReward('stack3.6', 'BigZone')), getStack(4, 1, getReward('stack3.7', 'BigZone')), getStack(4, 1, getReward('stack3.8', 'BigZone')), 
            getStack(4, 1, getReward('stack3.9', 'BigZone')),
            getStack(5, 1, getReward('stack5', 'BigZone'))},
        ruins = {getRuins(3, {min = 360, max = 390}, getReward('ruinst3.1', 'BigZone25')),
                 getRuins(3, {min = 360, max = 390}, getReward('ruinst3.2', 'BigZone25')),
                 getRuins(4, {min = 400, max = 450}, getReward('ruinst4', 'BigZone25'))},
        merchants = {{goods = {items = getReward('merchants', 'BZ')},
                      guard = getGuard(3, getReward('guard', 'merchantsBZ'))}},
        mages = {getMagicTower(2, getGuard(3, getReward('guard', 'mageBZ')))},
		towns = {getTown(3, getGuard(3, getReward('guard', 'BZtownt3') ), getReward('townt3', 'BigZone25'))},
        bags = getBags(4, getReward('bags', 'BigZone'))
	}
end

function getVSZone(zoneId, playerRace, playerRace2, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        gapMask = 9,
        mines = getMinesVS(playerRace, playerRace2),
        stacks = {
            getStack(3, 2, getReward()),
            getStack(4, 4, getReward('stackt4', 'VSZone')),
            getStack(5, 5, getReward('stackt5', 'VSZone')),
            getStack(6, 5, getReward('stackt6', 'VSZone'))},
        ruins = {getRuins(5, {min = 450, max = 500}, getReward('ruins', 'VSZone1'), "��! ���������? �� �����. �� ���� �� ������")},
        mercenaries = {getMercenaries12(getGuard(4))},
        merchants = {{goods = {items = getReward('merchants', 'VS')},
                      guard = getGuard(4, getReward('merchantsguard', 'VSZone'))}},
        mages = {getMagicTower(4, getGuard(4, getReward('guard', 'mageVS')))},
        towns = {getTown(5, getGuard(5, getReward('guardtownt5', 'VSZone')), getReward('townt5', 'VSZone1'))},
        bags = getBags(4, getReward('bags', 'VSZone'))
	}
end


function getVSZone2(zoneId, playerRace, playerRace2, zoneSize)
	return {
		id = zoneId,
		type = Zone.Treasure,
		size = zoneSize,
        gapMask = 9,
        mines = getMinesVS(playerRace, playerRace2),
        stacks = {
            getStack(3, 2, getReward()),
            getStack(4, 4, getReward('stackt4', 'VSZone')),
            getStack(5, 5, getReward('stackt5', 'VSZone')),
            getStack(6, 5, getReward('stackt6', 'VSZone'))},
        ruins = {getRuins(5, {min = 450, max = 500}, getReward('ruins', 'VSZone2'), "��! ���������? �� �����. �� ���� �� ������")},
        mercenaries = {getMercenaries45(getGuard(4))},
        merchants = {{goods = {items = getReward('merchants', 'VS')},
                      guard = getGuard(4, getReward('merchantsguard', 'VSZone'))}},
        mages = {getMagicTower(4, getGuard(4, getReward('guard', 'mageVS')))},
        towns = {getTown(5, getGuard(5, getReward('guardtownt5', 'VSZone')), getReward('townt5', 'VSZone2'))},
        bags = getBags(4, getReward('bags', 'VSZone'))
	}
end

function getzone12(zoneId, zoneSize)
	return {
		id = zoneId,
		type = Zone.Junction,
		size = zoneSize,
        border = Border.Open,
        mines = getMines1245(),
        resourceMarkets = getResourceMarket(getGuard(4, getReward('guard', 'RM'))),
        stacks = {getStack(5, 4, getReward('stack', 'BZto1245'))},
        ruins = {getRuins(4, {min = 400, max = 450}, getReward('ruins', '1245'))},
        bags = getBags(3, getReward('bags', '1245'))
	}
end

function getzone45(zoneId, zoneSize)
	return {
		id = zoneId,
		type = Zone.Junction,
		size = zoneSize,
        border = Border.Open,
        mines = getMines1245(),
        resourceMarkets = getResourceMarket(getGuard(4, getReward('guard', 'RM'))),
        stacks = {getStack(5, 4, getReward('stack', 'BZto1245'))},
        ruins = {getRuins(4, {min = 400, max = 450}, getReward('ruins', '1245'))},
        bags = getBags(3, getReward('bags', '1245'))
	}
end

local startZone1Id = 0
local bigZone1Id = 1
local zone12Id = 2
local bigZone2Id = 3
local startZone2Id = 4
local bigZone4Id = 5
local zone45Id = 6
local bigZone5Id = 7
local VSZoneId = 8
local VSZone2Id = 9

function getZones(races)

	local BigZoneSize = 600
	local StartZoneSize = 500
	local VSZoneSize = 615
	local VSZone2Size = 615
    local zone12size = 200
    local zone45size = 200
	local zones = {}

    zones[1] = getStartZone(startZone1Id, races[1], StartZoneSize)
    zones[2] = getBigZone1(bigZone1Id, races[1], BigZoneSize)
    zones[3] = getzone12(zone12Id, zone12size)
    zones[4] = getBigZone2(bigZone2Id, races[2], BigZoneSize)
	zones[5] = getStartZone(startZone2Id, races[2], StartZoneSize)
	zones[6] = getBigZone4(bigZone4Id, races[2], BigZoneSize)
    zones[7] = getzone45(zone45Id, zone45size)
    zones[8] = getBigZone5(bigZone5Id, races[1], BigZoneSize)
	zones[9] = getVSZone(VSZoneId, races[1], races[2], VSZoneSize)
	zones[10] = getVSZone2(VSZone2Id, races[1], races[2], VSZone2Size)

    -- zones[1] = getStartZone(startZone1Id, races[1], StartZoneSize)
    -- zones[2] = getBigZone1(bigZone1Id, races[1], BigZoneSize)
    -- zones[3] = getBigZone2(bigZone2Id, races[2], BigZoneSize)
	-- zones[4] = getStartZone(startZone2Id, races[2], StartZoneSize)
	-- zones[5] = getBigZone4(bigZone4Id, races[2], BigZoneSize)
    -- zones[6] = getBigZone5(bigZone5Id, races[1], BigZoneSize)
	-- zones[7] = getVSZone(VSZoneId, races[1], races[2], VSZoneSize)
	-- zones[8] = getVSZone2(VSZone2Id, races[1], races[2], VSZone2Size)

	return zones
end

-- ��������� ���������� ���
function getConnections()
	return {
		{from = 0, to = 1, guard = getGuard(3, getReward('guardResp', 'GOtoBigZone14'))},
		{from = 7, to = 0, guard = getGuard(3, getReward('guardResp', 'GOtoBigZone25'))},
		{from = 0, to = 8, guard = getGuard(6, getReward('guardResp', 'GOtoCenter0848'))},
		{from = 9, to = 0, guard = getGuard(6, getReward('guardResp', 'GOtoCenter0949'))},
		{from = 1, to = 9, guard = getGuard(6, getReward('guardGO', 'GOBZtoCenter'))},
		{from = 1, to = 2, guard = getGuard(5, getReward('guard', 'BZto1245'))},
        {from = 2, to = 3, guard = getGuard(5, getReward('guard', 'BZto1245'))},
        {from = 3, to = 9, guard = getGuard(6, getReward('guardGO', 'GOBZtoCenter'))},
        {from = 3, to = 4, guard = getGuard(3, getReward('guardResp', 'GOtoBigZone25'))},
        {from = 4, to = 5, guard = getGuard(3, getReward('guardResp', 'GOtoBigZone14'))},
        {from = 4, to = 8, guard = getGuard(6, getReward('guardResp', 'GOtoCenter0848'))},
        {from = 4, to = 9, guard = getGuard(6, getReward('guardResp', 'GOtoCenter0949'))},
        {from = 5, to = 6, guard = getGuard(5, getReward('guard', 'BZto1245'))},
        {from = 5, to = 8, guard = getGuard(6, getReward('guardGO', 'GOBZtoCenter'))},
        {from = 6, to = 7, guard = getGuard(5, getReward('guard', 'BZto1245'))},
        {from = 7, to = 8, guard = getGuard(6, getReward('guardGO', 'GOBZtoCenter'))},
        {from = 8, to = 9, guard = getGuard()},
        {from = 9, to = 8, guard = getGuard()},
        {from = 8, to = 9, guard = getGuard()},
        {from = 9, to = 8, guard = getGuard()},
        {from = 8, to = 9, guard = getGuard(7, getReward('guardVS', 'GOVStoVS'))},
        {from = 9, to = 8, guard = getGuard()},
        {from = 8, to = 9, guard = getGuard()},
        {from = 9, to = 8, guard = getGuard()},
        {from = 2, to = 9, guard = getGuard(6, getReward('guard', '12tocenter'))},
        {from = 6, to = 8, guard = getGuard(6, getReward('guard', '45tocenter'))},
	}
end

function getTemplateContents(races)
	return {
		zones = getZones(races),
		connections = getConnections()
	}
end

template = {
	name = 'VerSus 1.1',
	description = 'VerSus 1.0 by iSkromny, sMNS 2, 72x72, 2 players, \nTimer: First day: 420, next days: 360',
    minSize = 72,
	maxSize = 72,
	maxPlayers = 2,
	roads = 50,
	forest = 40,
	startingGold = 1150,
    startingNativeMana = 200,
	getContents = getTemplateContents,
    forbiddenUnits = {
                -- ����������� �����-������ � �� ������ �����
        'g000uu0021', --�������
        'g000uu8248', --�������
        'g000uu0020', --��������
        'g000uu0019', --������ �� ������
        'g000uu0022', --��������
        'g000uu0023', --���
        'g000uu5300', --���
        'g000uu0044', --����������� �����
        'g000uu0045', --�������
        'g000uu0046', --������
        'g000uu8249', --������
        'g000uu0047', --����������
        'g000uu0048', --���
        'g000uu5301', --���
        'g000uu0070', --������
        'g000uu0071', --��������
        'g000uu0072', --����������
        'g000uu8250', --����������
        'g000uu0073', --���������
        'g000uu0074', --���
        'g000uu5302', --���
        'g000uu0096', --������ ������
        'g000uu0097', --���������
        'g000uu8252', --���������
        'g000uu0098', --�������� �����
        'g000uu8253', --�������� �����
        'g000uu0099', --������
        'g000uu0100', --���
        'g000uu5303', --���
        'g000uu8251', --������
        'g000uu8010', --������
        'g000uu8009', --������ ����
        'g000uu8011', --����� ����
        'g000uu8012', --������
        'g000uu8013', --���
        'g000uu5304', --���

                -- ����������� �����-�������
        'g001uu0021', --�������
        'g001uu0020', --��������
        'g001uu0019', --������ �� ������
        'g001uu0022', --��������
        'g001uu0023', --���
        'g001uu0045', --�������
        'g001uu0044', --����������� �����
        'g001uu0046', --������
        'g070uu0003', --������
        'g001uu0047', --����������
        'g001uu0048', --���
        'g001uu0072', --����������
        'g070uu0004', --����������
        'g001uu0071', --��������
        'g001uu0070', --������
        'g001uu0073', --���������
        'g001uu0074', --���
        'g001uu0098', --�������� �����
        'g070uu0001', --���������
        'g001uu0097', --���������
        'g001uu0096', --������ ������
        'g001uu0099', --������
        'g001uu0100', --���
        'g001uu8010', --������
        'g070uu0002', --������
        'g001uu8009', --������ ����
        'g001uu8011', --����� ����
        'g001uu8012', --������
        'g001uu8013', --���

                -- ����������� �����������-������� � ������� ���-��� �����
        'g000uu8185', -- ������� ������
        'g001uu7598', -- ���������
        'g001uu8242', -- X����� �����
        'g000uu0164', -- ���������� ������

                -- ����������� �������-������� � ������� ���-��� ����� 
        'g000uu0017', -- ��������
        'g000uu8035', -- ��������
        'g002uu8039', -- �������
        'g000uu7570', -- �������
        'g000uu7569', -- �����
        'g000uu8264', -- ������
        'g000uu0151', -- ���������������
        'g000uu0013', -- ���������
        'g000uu8214', -- ���������
        'g000uu8034', -- ��������� ����������
        'g000uu0150', -- ��������
        'g003uu8039', -- ����� �����
        'g003uu8038', -- ��� ��������
        'g000uu8235', -- ��������
        'g000uu2002', -- ��������
        'g003uu8037', -- ��������� �����

                -- ����������� ������ � ������ �������������� 20%
        'g000uu5236', -- ����
        'g000uu5117', -- ������
        'g000uu5101', -- ����������
        'g000uu8308', -- ������� �������
        'g000uu5130', -- ���������
        'g000uu7556', -- ������-����
        'g000uu7533', -- �����
        'g000uu7510', -- ����� ��� �����
        'g000uu7616', -- ���� ����� �����
        'g000uu6004', -- ������� ��� �.
        'g000uu5201', -- ������ �.
        'g000uu7539', -- �������
        'g000uu7592', -- ������
        'g000uu7516', -- ��� ����� �.
        'g000uu5262', -- ������� �.
        'g000uu7614', -- �������� ��� �����
        'g000uu7553', -- �������-�����

                --��� ����������� ������� � ������� ���-��� ����� (������ � �������)
        'g000uu8287', -- ��.������ �.
        'g000uu8288', -- ��� �������� �.
        'g000uu7519', -- ������� �.
        'g000uu8215', -- ��������� �.
        'g000uu8262', -- �������� �.
        'g000uu8289', -- ����� ����� �
        'g000uu7521', -- �������� �.
        'g000uu5006', -- ������� ������
        'g000uu8222', -- ����� �. �����
        'g000uu8218', -- �����
        'g000uu7544', -- ��������������
        'g000uu8213', -- ������-�����
        'g001uu8262', -- ��������
        'g000uu2021', -- �����������
        'g000uu8223', -- ��������� ��������� �. �����
        'g000uu8219', -- ��������� ���������
        'g000uu6107', -- ������ ����-����
        'g000uu7619', -- ����� ������
        'g000uu8044', -- ������ ���� ���� �.

        'g000uu8210', -- ��������� ��� (�����)
        'g000uu6116', -- ���������
        'g000uu6016', -- ��������� �����   
        'g000uu8265', -- ���� �������
        'g000uu8133', -- ������ ���� (�����)
        'g000uu8033', -- ������ ���� 
        },
    forbiddenItems = {
        'g000ig3007', -- ������
        'g001ig0155', -- ���� � ���������� �����
        'g000ig3021', -- ���� � ���������
        'g001ig0414', -- ���� �� �������
        'g001ig0388', -- ����� �����


    }
}
