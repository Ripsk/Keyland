local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

 
function onCreatureAppear(cid)				npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 			npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 	npcHandler:onCreatureSay(cid, type, msg) end
function onThink() 						npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
 
	if(msgcontains(msg, "trouble") and getPlayerStorageValue(cid, 204) < 1 and getPlayerStorageValue(cid, 82324) < 1) then
		npcHandler:say("I'm fine. There's no trouble at all.", cid)
		npcHandler.topic[cid] = 1
	elseif(msgcontains(msg, "foresight of the authorities")) then
		if(npcHandler.topic[cid] == 1) then
			npcHandler:say("Well, of course. We live in safety and peace.", cid)
			npcHandler.topic[cid] = 2
		end
	elseif(msgcontains(msg, "also for the gods")) then
		if(npcHandler.topic[cid] == 2) then
			npcHandler:say("I think the gods are looking after us and their hands shield us from evil.", cid)
			setPlayerStorageValue(cid, 82324, 1)
		end
	elseif(msgcontains(msg, "trouble will arise in the near future")) then
		if(getPlayerStorageValue(cid, 82324) == 1) then
			npcHandler:say("I think the gods and the government do their best to keep away harm from the citizens.", cid)
			npcHandler.topic[cid] = 0
			if(getPlayerStorageValue(cid, 204) < 1) then
				setPlayerStorageValue(cid, 204, 1)
				Player(cid):setStorageValue(12111, Player(cid):getStorageValue(12111) + 1) -- The Inquisition Questlog- "Mission 1: Interrogation"
				doSendMagicEffect(getCreaturePosition(cid), CONST_ME_HOLYAREA)
			end
		end
	end
	return true
end
 
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())