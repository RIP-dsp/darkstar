-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Yahsra
-- Type: Assault Mission Giver
-- !pos 120.967 0.161 -44.002 50
-----------------------------------
package.loaded["scripts/zones/Aht_Urhgan_Whitegate/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/keyitems");
require("scripts/zones/Aht_Urhgan_Whitegate/TextIDs");
require("scripts/globals/besieged");
require("scripts/globals/missions");
-----------------------------------

function onTrade(player,npc,trade)
end;

function onTrigger(player,npc)
    local rank = getMercenaryRank(player);
    local haveimperialIDtag;
    local assaultPoints = player:getAssaultPoint(LEUJAOAM_ASSAULT_POINT);

    if (player:hasKeyItem(dsp.ki.IMPERIAL_ARMY_ID_TAG)) then
        haveimperialIDtag = 1;
    else
        haveimperialIDtag = 0;
    end

    --[[if (rank > 0) then
        player:startEvent(273,rank,haveimperialIDtag,assaultPoints,player:getCurrentAssault());
    else]]
        player:startEvent(279); -- no rank
    --end
end;

function onEventUpdate(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
end;

function onEventFinish(player,csid,option)
    -- printf("CSID: %u",csid);
    -- printf("RESULT: %u",option);
    if (csid == 273) then
        local selectiontype = bit.band(option, 0xF);
        if (selectiontype == 1) then
            -- taken assault mission
            player:addAssault(bit.rshift(option,4));
            player:delKeyItem(dsp.ki.IMPERIAL_ARMY_ID_TAG);
            player:addKeyItem(dsp.ki.LEUJAOAM_ASSAULT_ORDERS);
            player:messageSpecial(KEYITEM_OBTAINED,dsp.ki.LEUJAOAM_ASSAULT_ORDERS);
        elseif (selectiontype == 2) then
            -- purchased an item
            local item = bit.rshift(option,14);
            local itemID = 0;
            local price = 0;

            if (item == 1) then
                itemID = 15970;
                price = 3000;
            elseif (item == 2) then
                itemID = 15775;
                price = 5000;
            elseif (item == 3) then
                itemID = 15521;
                price = 8000;
            elseif (item == 4) then
                itemID = 15884;
                price = 10000;
            elseif (item == 5) then
                itemID = 15490;
                price = 10000;
            elseif (item == 6) then
                itemID = 18408;
                price = 10000;
            elseif (item == 7) then
                itemID = 18485;
                price = 15000;
            elseif (item == 8) then
                itemID = 18365;
                price = 15000;
            elseif (item == 9) then
                itemID = 14933;
                price = 15000;
            elseif (item == 10) then
                itemID = 16069;
                price = 20000;
            elseif (item == 11) then
                itemID = 15606;
                price = 20000;
            else
                return;
            end
            if player:getFreeSlotsCount() > 0 then
                player:addItem(itemID);
                player:messageSpecial(ITEM_OBTAINED,itemID);
                player:delCurrency("LEUJAOAM_ASSAULT_POINT",price);
            else
                player:messageSpecial(ITEM_CANNOT_BE_OBTAINED);
            end
        end
    end
end;
