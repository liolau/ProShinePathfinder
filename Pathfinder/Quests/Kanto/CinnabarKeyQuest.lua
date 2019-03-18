-- Copyright � 2016 g0ld <g0ld@tuta.io>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the COPYING file for more details.
-- Quest: @Rympex


local Lib    = require "Pathfinder/Lib/Lib"
local Game   = require "Pathfinder/Lib/Game"
local Quest  = require "Pathfinder/Quests/Quest"
local Dialog = require "Pathfinder/Quests/Dialog"
local PathFinder = require "Pathfinder/MoveToApp"

local name		  = 'Cinnabar mansion'
local description = ' Get Cinnabar Key + All Items'
local level = 55

local CinnabarKeyQuest = Quest:new()

function CinnabarKeyQuest:new()
	return Quest.new(CinnabarKeyQuest, name, description, level)
end

function CinnabarKeyQuest:isDoable()
	if self:hasMap() and not hasItem("Earth Badge") then
		return true
	end
	return false
end

function CinnabarKeyQuest:isDone()
	if getMapName() == "Pokecenter Cinnabar" or getMapName() == "Cinnabar Island" then
		return true
	end
	return false
end

function CinnabarKeyQuest:Cinnabarmansion1()
	if not hasItem("Cinnabar Key") then
		if Game.inRectangle(1,3,29,15) or Game.inRectangle(1,16,19,41)  or Game.inRectangle(20,16,21,21) then
			if isNpcOnCell(1,36) then --Item: Moon Stone
				return talkToNpcOnCell(1,36)
			elseif isNpcOnCell(24,8) then --Item: Escape Rope
				return talkToNpcOnCell(24,8)
			else
				return moveToCell(12,17) --Cinnabar mansion 2
			end
		elseif Game.inRectangle(20,27,42,42) then
			return moveToCell(29,35)
		else
			error("CinnabarKeyQuest:Cinnabarmansion1: [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
		end
	else
		if Game.inRectangle(20,27,42,42) then
			return moveToCell(39,42) -- Cinnabar Island
		else
			error("CinnabarKeyQuest:Cinnabarmansion1: [" .. getPlayerX() .. "," .. getPlayerY() .. "] is not a known position")
		end
	end
end

function CinnabarKeyQuest:Cinnabarmansion2()
	if not hasItem("Cinnabar Key") then
		if isNpcOnCell(20,30) then --Item: Calcium
			return talkToNpcOnCell(20,30)
		elseif isNpcOnCell(39,6) then
			return talkToNpcOnCell(39,6)
		else
			return moveToCell(9,4) -- Cinnabar mansion 3
		end
	else
		return moveToCell(14,19) -- Cinnabar mansion 1
	end
end

function CinnabarKeyQuest:Cinnabarmansion3()
	if not hasItem("Cinnabar Key") then
		if isNpcOnCell(31,3) then -- Item: Nothing *WOW FUNNY MAPPER -.- (Added Anyway)
			return talkToNpcOnCell(31,3)
		else
			return moveToCell(20,19) -- Cinnabar mansion B1F
		end
	else
		return moveToCell(6,4) -- Cinnabar mansion 2
	end
end

function CinnabarKeyQuest:CinnabarmansionB1F()
	if isNpcOnCell(5,15) then
		if Game.inRectangle(1,16,9,22) then
			if isNpcOnCell(5,19) then -- Item: Cinnabar Key
				return talkToNpcOnCell(5,19)
			else
				return talkToNpcOnCell(5,15)
			end
		else
			if isNpcOnCell(21,4) then --Item: TM22: SolarBeam
				return talkToNpcOnCell(21,4)
			elseif isNpcOnCell(5,4) then --Item: Antidote
				return talkToNpcOnCell(5,4)
			elseif isNpcOnCell(5,29) then --Item: Full Restore
				return talkToNpcOnCell(5,29)
			else
				return talkToNpcOnCell(5,26) --Library Hidden Passage
			end
		end
	else
		return moveToCell(36,30) --Cinnabar mansion 1
	end
end

return CinnabarKeyQuest