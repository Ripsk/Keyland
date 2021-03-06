local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

 
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

function creatureSayCallback(cid, type, msg)
	if(not npcHandler:isFocused(cid)) then
		return false
	end
	
	
	if(msgcontains(msg, "monument tower")) then
		npcHandler:say("Do you want to travel to the {monument tower} for a 50 gold fee?", cid)
		npcHandler.topic[cid] = 1
	elseif(msgcontains(msg, "yes")) then
		if(npcHandler.topic[cid] == 1) then
			if(getPlayerMoney(cid) >= 50) then
				doPlayerRemoveMoney(cid, 50)
				doTeleportThing(cid, {x = 32940, y = 31182, z = 7})
				doSendMagicEffect({x = 32940, y = 31182, z = 7}, CONST_ME_TELEPORT)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't have enought money.", cid)
			end
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Can I interest you in a trip to the {monument tower}?")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())