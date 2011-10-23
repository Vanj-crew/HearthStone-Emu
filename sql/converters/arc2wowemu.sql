-- WowEmu Database Converter
-- Copyright (C) 2008 - 2009 WowEmu <http://www.wow-emu.org//>

-- This Converter is a free Mysql code you can redistribute it and/or modify as long as you give credit to Monta and Neccta.

-- ai_agents
ALTER TABLE `ai_agents` DROP column `event`;
ALTER TABLE `ai_agents` CHANGE column `cooldown_ovewrite` `cooldown` int(8) NOT NULL DEFAULT '0';
ALTER TABLE ai_agents CHANGE type type VARCHAR(50) NOT NULL DEFAULT '';
ALTER TABLE ai_agents CHANGE spelltype spelltype VARCHAR(50) NOT NULL DEFAULT '';
ALTER TABLE ai_agents CHANGE targettype_overwrite targettype VARCHAR(50) NOT NULL DEFAULT '';
UPDATE ai_agents SET type = 'SPELL' WHERE type = 0;
UPDATE ai_agents SET type = 'MELEE' WHERE type = 1;
UPDATE ai_agents SET type = 'RANGED' WHERE type = 2;
UPDATE ai_agents SET type = 'FLEE' WHERE type = 3;
UPDATE ai_agents SET type = 'SPELL' WHERE type = 4;
UPDATE ai_agents SET type = 'CALLFORHELP' WHERE type = 5;
UPDATE ai_agents SET spelltype = 'ROOT' WHERE spelltype = 0;
UPDATE ai_agents SET spelltype = 'ROOT' WHERE spelltype = 1;
UPDATE ai_agents SET spelltype = 'HEAL' WHERE spelltype = 2;
UPDATE ai_agents SET spelltype = 'STUN' WHERE spelltype = 3;
UPDATE ai_agents SET spelltype = 'FEAR' WHERE spelltype = 4;
UPDATE ai_agents SET spelltype = 'SILENCE' WHERE spelltype = 5;
UPDATE ai_agents SET spelltype = 'CURSE' WHERE spelltype = 6;
UPDATE ai_agents SET spelltype = 'AOEDAMAGE' WHERE spelltype = 7;
UPDATE ai_agents SET spelltype = 'DAMAGE' WHERE spelltype = 8;
UPDATE ai_agents SET spelltype = 'SUMMON' WHERE spelltype = 9;
UPDATE ai_agents SET spelltype = 'BUFF' WHERE spelltype = 10;
UPDATE ai_agents SET spelltype = 'DEBUFF' WHERE spelltype = 11;
UPDATE ai_agents SET targettype = 'RANDOMTARGET' WHERE targettype = -1;
UPDATE ai_agents SET targettype = 'RANDOMTARGET' WHERE targettype = 0;
UPDATE ai_agents SET targettype = 'RANDOMTARGET' WHERE targettype = 1;
UPDATE ai_agents SET targettype = 'TARGETLOCATION' WHERE targettype = 2;
UPDATE ai_agents SET targettype = 'CREATURELOCATION' WHERE targettype = 3;
UPDATE ai_agents SET targettype = 'SELF' WHERE targettype = 4;
UPDATE ai_agents SET targettype = 'OWNER' WHERE targettype = 5;
ALTER TABLE ai_agents CHANGE type type enum('MELEE','RANGED','FLEE','SPELL','CALLFORHELP') NOT NULL DEFAULT 'SPELL'; 
ALTER TABLE ai_agents CHANGE spelltype spelltype enum('ROOT','HEAL','STUN','FEAR','SILENCE','CURSE','AOEDAMAGE','DAMAGE','SUMMON','BUFF','DEBUFF') NOT NULL DEFAULT 'ROOT';
ALTER TABLE ai_agents CHANGE targettype targettype enum('RANDOMTARGET','TARGETLOCATION','CREATURELOCATION','SELF','OWNER') NOT NULL DEFAULT 'RANDOMTARGET';
ALTER TABLE ai_agents CHANGE spelltype spelltype enum('ROOT','HEAL','STUN','FEAR','SILENCE','CURSE','AOEDAMAGE','DAMAGE','SUMMON','BUFF','DEBUFF','INTERRUPT') NOT NULL DEFAULT 'ROOT';
UPDATE ai_agents SET spelltype = 'DEBUFF' where spelltype = 'CURSE';
UPDATE ai_agents SET spelltype = 'INTERRUPT' where spelltype = 'SILENCE';
ALTER TABLE ai_agents CHANGE spelltype spelltype enum('ROOT','DAMAGE','AOEDAMAGE','INTERRUPT','FEAR','STUN','BUFF','DEBUFF','SUMMON','HEAL') NOT NULL DEFAULT 'ROOT';

-- ai_threattospellid
ALTER TABLE `ai_threattospellid` DROP column `modcoef`;

-- creature_formations
ALTER TABLE `creature_formations` CHANGE column `spawn_id` `spawn_id` int(30) NOT NULL;
ALTER TABLE `creature_formations` CHANGE column `target_spawn_id` `target_spawn_id` int(30) NOT NULL;

-- creature_names
ALTER TABLE `creature_names` CHANGE column `entry` `entry` int(20) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_names` CHANGE column `Flags1` `Flags1` int(30) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_names` CHANGE column `type` `type` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `creature_names` CHANGE column `family` `family` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `creature_names` CHANGE column `rank` `rank` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `creature_names` CHANGE column `unk4` `unk4` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `creature_names` CHANGE column `spelldataid` `spelldataid` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `creature_names` CHANGE column `unknown_float1` `unknown_float1` float NOT NULL DEFAULT 0;
ALTER TABLE `creature_names` CHANGE column `unknown_float2` `unknown_float2` float NOT NULL DEFAULT 0;
UPDATE `creature_names` SET `civilian`='0' WHERE (`entry`='0');
UPDATE `creature_names` SET `civilian`='0' WHERE (`entry`<>'0');
UPDATE `creature_names` SET `leader`='0' WHERE (`entry`<>'0');
ALTER TABLE `creature_names` CHANGE column `civilian` `civilian` tinyint(30) NOT NULL DEFAULT 0;
ALTER TABLE `creature_names` CHANGE column `leader` `leader` tinyint(30) NOT NULL DEFAULT 0;

-- creature_names_localized
ALTER TABLE `creature_names_localized` CHANGE column `name` `name` varchar(100) NOT NULL;
ALTER TABLE `creature_names_localized` CHANGE column `subname` `subname` varchar(100) NOT NULL;

-- creature_proto
ALTER TABLE `creature_proto` ADD COLUMN `Item1` int(30) UNSIGNED NOT NULL DEFAULT 0 AFTER `rangedmaxdamage`;
ALTER TABLE `creature_proto` ADD COLUMN `Item2` int(30) UNSIGNED NOT NULL DEFAULT 0 AFTER `Item1`;
ALTER TABLE `creature_proto` ADD COLUMN `Item3` int(30) UNSIGNED NOT NULL DEFAULT 0 AFTER `Item2`;
UPDATE `creature_proto` JOIN creature_spawns ON creature_spawns.entry = creature_proto.entry SET creature_proto.Item1 = creature_spawns.slot1item;
UPDATE `creature_proto` JOIN creature_spawns ON creature_spawns.entry = creature_proto.entry SET creature_proto.Item2 = creature_spawns.slot2item;
UPDATE `creature_proto` JOIN creature_spawns ON creature_spawns.entry = creature_proto.entry SET creature_proto.Item3 = creature_spawns.slot3item;
ALTER TABLE `creature_proto` ADD COLUMN `auraimmune_flag` int(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `extra_a9_flags`;
ALTER TABLE `creature_proto` DROP COLUMN `spell1`;
ALTER TABLE `creature_proto` DROP COLUMN `spell2`;
ALTER TABLE `creature_proto` DROP COLUMN `spell3`;
ALTER TABLE `creature_proto` DROP COLUMN `spell4`;
ALTER TABLE `creature_proto` DROP COLUMN `spell_flags`;
ALTER TABLE `creature_proto` DROP COLUMN `modImmunities`;
ALTER TABLE `creature_proto` ADD COLUMN `vehicle_entry` int(11) NOT NULL DEFAULT '-1';
ALTER TABLE `creature_proto` ADD COLUMN `CanMove` int  DEFAULT '7' NOT NULL  after `vehicle_entry`;
ALTER TABLE `creature_proto` CHANGE column resistance6 `resistance7` int(30) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_proto` CHANGE column resistance5 `resistance6` int(30) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_proto` CHANGE column resistance4 `resistance5` int(30) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_proto` CHANGE column resistance3 `resistance4` int(30) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_proto` CHANGE column resistance2 `resistance3` int(30) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_proto` CHANGE column resistance1 `resistance2` int(30) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_proto` CHANGE column armor `resistance1` int(30) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_proto` DROP column `can_ranged`;

-- creature_spawns
ALTER TABLE `creature_spawns` CHANGE column `id` `id` int(30) NOT NULL AUTO_INCREMENT;
ALTER TABLE `creature_spawns` CHANGE column `bytes0` `bytes` int(30) NOT NULL default '0';
ALTER TABLE `creature_spawns` DROP column `slot1item`;
ALTER TABLE `creature_spawns` DROP column `slot2item`;
ALTER TABLE `creature_spawns` DROP column `slot3item`;
ALTER TABLE `creature_spawns` ADD COLUMN `phase` int(11) NOT NULL DEFAULT 1;
ALTER TABLE `creature_spawns` ADD COLUMN `vehicle` int(10) NOT NULL DEFAULT 0;
ALTER TABLE `creature_spawns` DROP COLUMN npc_respawn_link;
ALTER TABLE `creature_spawns` CHANGE column `mountdisplayid` `MountedDisplayID` int(10) NOT NULL default '0';
UPDATE creature_spawns SET phase = 1 WHERE phase = 0;
ALTER TABLE `creature_spawns` change COLUMN `channel_target_sqlid` `channel_target_sqlid_go` int(30) UNSIGNED NOT NULL DEFAULT 0;

-- creature_staticspawns
ALTER TABLE `creature_staticspawns` CHANGE column `o` `orientation` float NOT NULL;
ALTER TABLE `creature_staticspawns` CHANGE column `factionid` `faction` int(30) NOT NULL DEFAULT 35;
ALTER TABLE `creature_staticspawns` CHANGE column `bytes0` `bytes` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `creature_staticspawns` ADD COLUMN `channel_spell` int(30) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `creature_staticspawns` ADD COLUMN `channel_target_sqlid` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `creature_staticspawns` ADD COLUMN `channel_target_sqlid_creature` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `creature_staticspawns` ADD COLUMN `standstate` int(10) NOT NULL DEFAULT 0;
ALTER TABLE `creature_staticspawns` ADD COLUMN `MounteddisplayID` int(10) NOT NULL DEFAULT 0;
ALTER TABLE `creature_staticspawns` ADD COLUMN `Phase` int(10) NOT NULL DEFAULT 0;

-- creature_waypoints
ALTER TABLE `creature_waypoints` CHANGE column `spawnid` `spawnid` int(10) NOT NULL;
ALTER TABLE `creature_waypoints` ADD column `orientation` float NOT NULL DEFAULT 0 AFTER `position_z`;
ALTER TABLE `creature_waypoints` CHANGE column `waittime` `waittime` int(6) NOT NULL DEFAULT 0;
ALTER TABLE `creature_waypoints` CHANGE column `forwardemoteoneshot` `forwardemoteoneshot` int(1) NOT NULL DEFAULT 0;
ALTER TABLE `creature_waypoints` CHANGE column `forwardemoteid` `forwardemoteid` int(4) NOT NULL DEFAULT 0;
ALTER TABLE `creature_waypoints` CHANGE column `backwardemoteoneshot` `backwardemoteoneshot` int(1) NOT NULL DEFAULT 0;
ALTER TABLE `creature_waypoints` CHANGE column `backwardemoteid` `backwardemoteid` int(4) NOT NULL DEFAULT 0;
ALTER TABLE `creature_waypoints` ADD COLUMN `forwardStandState` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `creature_waypoints` ADD COLUMN `backwardStandState` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `creature_waypoints` ADD COLUMN `forwardSpellToCast` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `creature_waypoints` ADD COLUMN `backwardSpellToCast` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `creature_waypoints` ADD COLUMN `forwardSayText` varchar(1024) NOT NULL DEFAULT '';
ALTER TABLE `creature_waypoints` ADD COLUMN `backwardSaytext` varchar(1024) NOT NULL DEFAULT '';
UPDATE `creature_waypoints` SET `forwardSayText`='' WHERE  `forwardSayText` = '0';
UPDATE `creature_waypoints` SET `backwardSayText`='' WHERE  `backwardSayText` = '0';

-- fishing
ALTER TABLE `fishing` CHANGE column `Zone` `Zone` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `fishing` CHANGE column `MinSkill` `MinSkill` int(11) UNSIGNED DEFAULT NULL;
ALTER TABLE `fishing` CHANGE column `MaxSkill` `MaxSkill` int(11) UNSIGNED DEFAULT NULL;

-- gameobject_names
ALTER TABLE `gameobject_names` CHANGE column `spellfocus` `spellfocus` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `sound1` `sound1` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `sound2` `sound2` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `sound3` `sound3` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `sound4` `sound4` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `sound5` `sound5` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `sound6` `sound6` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `sound7` `sound7` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `sound8` `sound8` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `sound9` `sound9` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown1` `unknown1` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown2` `unknown2` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown3` `unknown3` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown4` `unknown4` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown5` `unknown5` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown6` `unknown6` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown7` `unknown7` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown8` `unknown8` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown9` `unknown9` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown10` `unknown10` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown11` `unknown11` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown12` `unknown12` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown13` `unknown13` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` CHANGE column `unknown14` `unknown14` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_names` DROP column `Name2`;
ALTER TABLE `gameobject_names` DROP column `Name3`;
ALTER TABLE `gameobject_names` DROP column `Name4`;
ALTER TABLE `gameobject_names` DROP column `Category`;
ALTER TABLE `gameobject_names` DROP column `CastBarText`;
ALTER TABLE `gameobject_names` DROP column `UnkStr`;



-- gameobject_spawns
ALTER TABLE `gameobject_spawns` CHANGE COLUMN `id` `ID` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_spawns` CHANGE COLUMN `map` `Map` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `gameobject_spawns` ADD COLUMN `phase` int(11) NOT NULL DEFAULT 1 AFTER `Scale`;
ALTER TABLE `gameobject_spawns` DROP COLUMN stateNpcLink;
UPDATE gameobject_spawns SET phase = 1 WHERE phase = 0;

-- gameobject_staticspawns
ALTER TABLE `gameobject_staticspawns` CHANGE COLUMN `o3` `o4` float NOT NULL; 
ALTER TABLE `gameobject_staticspawns` CHANGE COLUMN `o2` `o3` float NOT NULL;
ALTER TABLE `gameobject_staticspawns` CHANGE COLUMN `o1` `o2` float NOT NULL;
ALTER TABLE `gameobject_staticspawns` CHANGE COLUMN `o` `o1` float NOT NULL;
ALTER TABLE `gameobject_staticspawns` ADD COLUMN `phase` int(11) NOT NULL DEFAULT 1 AFTER `scale`;
ALTER TABLE `gameobject_staticspawns` DROP COLUMN `respawnNpcLink`;

-- graveyards
ALTER TABLE `graveyards` CHANGE column `name` `name` varchar(255) NOT NULL;

-- Loot tables renmaed
DROP TABLE IF EXISTS `creatureloot`;
RENAME TABLE loot_creatures TO creatureloot;
ALTER TABLE `creatureloot` DROP COLUMN `index`;

DROP TABLE IF EXISTS `disenchantingloot`;
RENAME TABLE loot_disenchanting TO disenchantingloot;
ALTER TABLE `disenchantingloot` DROP COLUMN `index`;

DROP TABLE IF EXISTS `fishingloot`;
RENAME TABLE loot_fishing TO fishingloot;
ALTER TABLE `fishingloot` DROP COLUMN `index`;

DROP TABLE IF EXISTS `objectloot`;
RENAME TABLE loot_gameobjects TO objectloot;
ALTER TABLE `objectloot` DROP COLUMN `index`;

DROP TABLE IF EXISTS `itemloot`;
RENAME TABLE loot_items TO itemloot;
ALTER TABLE `itemloot` DROP COLUMN `index`;

DROP TABLE IF EXISTS `millingloot`;
RENAME TABLE loot_milling TO millingloot;
ALTER TABLE `millingloot` DROP COLUMN `index`;

DROP TABLE IF EXISTS `pickpocketingloot`;
RENAME TABLE loot_pickpocketing TO pickpocketingloot;
ALTER TABLE `pickpocketingloot` DROP COLUMN `index`;

DROP TABLE IF EXISTS `prospectingloot`;
RENAME TABLE loot_prospecting TO prospectingloot;
ALTER TABLE `prospectingloot` DROP COLUMN `index`;

DROP TABLE IF EXISTS `skinningloot`;
RENAME TABLE loot_skinning TO skinningloot;
ALTER TABLE `skinningloot` DROP COLUMN `index`;

-- Vendors
ALTER TABLE `vendors` CHANGE column `extended_cost` `extendedcost` int(11) NOT NULL DEFAULT 1;

-- creature_loot
ALTER TABLE `creatureloot` CHANGE column `mincount` `mincount` int(11) NOT NULL DEFAULT 1;
ALTER TABLE `creatureloot` CHANGE column `maxcount` `maxcount` int(11) NOT NULL DEFAULT 1;


-- itempages_localized
ALTER TABLE `itempages_localized` CHANGE column `text` `text` text DEFAULT NULL;

-- items
ALTER TABLE `items` CHANGE `entry` `entry` int(30) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `items` CHANGE `unk203_1` `RandomSuffixId`  int(11) NOT NULL DEFAULT 0 AFTER `randomprop`;
ALTER TABLE `items` CHANGE `unk2` `ArmorDamageModifier`  int(11) NOT NULL DEFAULT 0 AFTER `ReqDisenchantSkill`;
ALTER TABLE `items` DROP COLUMN `ScaledStatsDistributionId`;
ALTER TABLE `items` DROP COLUMN `ScaledStatsDistributionFlags`;
ALTER TABLE `items` DROP COLUMN `ItemLimitCategoryId`;
-- npc_monstersay
ALTER TABLE `npc_monstersay` CHANGE `entry` `entry` int(11) NOT NULL;
ALTER TABLE `npc_monstersay` CHANGE `event` `event` int(11) NOT NULL;
ALTER TABLE `npc_monstersay` CHANGE `chance` `chance` float NOT NULL;
ALTER TABLE `npc_monstersay` CHANGE `language` `language` int(11) NOT NULL;
ALTER TABLE `npc_monstersay` CHANGE `type` `type` int(11) NOT NULL;
ALTER TABLE `npc_monstersay` CHANGE `monstername` `monstername` longtext DEFAULT NULL;
ALTER TABLE `npc_monstersay` CHANGE `text0` `text0` longtext DEFAULT NULL;
ALTER TABLE `npc_monstersay` CHANGE `text1` `text1` longtext DEFAULT NULL;
ALTER TABLE `npc_monstersay` CHANGE `text2` `text2` longtext DEFAULT NULL;
ALTER TABLE `npc_monstersay` CHANGE `text3` `text3` longtext DEFAULT NULL;
ALTER TABLE `npc_monstersay` CHANGE `text4` `text4` longtext DEFAULT NULL;

-- npc_text
ALTER TABLE `npc_text` CHANGE `text0_0` `text0_0` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text0_1` `text0_1` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text1_0`  `text1_0` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text1_1` `text1_1` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text2_0` `text2_0` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text2_1` `text2_1` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text3_0` `text3_0` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text3_1` `text3_1` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text4_0` `text4_0` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text4_1` `text4_1` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text5_0` `text5_0` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text5_1` `text5_1` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text6_0` `text6_0` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text6_1` `text6_1` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text7_0` `text7_0` longtext NOT NULL;
ALTER TABLE `npc_text` CHANGE `text7_1` `text7_1` longtext NOT NULL;

-- npc_text_localized
ALTER TABLE `npc_text_localized` CHANGE `entry` `entry` int(30) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `language_code` `language_code` varchar(5) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text0` `text0` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text0_1` `text0_1` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text1` `text1` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text1_1` `text1_1` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text2` `text2` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text2_1` `text2_1` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text3` `text3` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text3_1` `text3_1` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text4` `text4` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text4_1` `text4_1` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text5` `text5` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text5_1` `text5_1` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text6` `text6` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text6_1` `text6_1` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text7` `text7` varchar(200) NOT NULL;
ALTER TABLE `npc_text_localized` CHANGE `text7_1` `text7_1` varchar(200) NOT NULL;

-- playercreateinfo
ALTER TABLE `playercreateinfo` CHANGE column `factiontemplate` `factiontemplate` int(5) NOT NULL DEFAULT 0;
ALTER TABLE `playercreateinfo` CHANGE column `mapID` `mapID` mediumint(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `playercreateinfo` CHANGE column `zoneID` `zoneID` mediumint(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `playercreateinfo` CHANGE column `BaseHealth` `BaseHealth` mediumint(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `playercreateinfo` CHANGE column `BaseMana` `BaseMana` mediumint(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `playercreateinfo` CHANGE column `BaseRage` `BaseRage` mediumint(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `playercreateinfo` CHANGE column `BaseFocus` `BaseFocus` mediumint(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `playercreateinfo` CHANGE column `BaseEnergy` `BaseEnergy` mediumint(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE playercreateinfo ADD COLUMN BaseRunic int4 unsigned not null DEFAULT 0 AFTER BaseEnergy;
ALTER TABLE `playercreateinfo` CHANGE column `attackpower` `attackpower` mediumint(8) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `playercreateinfo` DROP COLUMN `introid`;

-- playercreateinfo_items
ALTER TABLE `playercreateinfo_items` CHANGE column `indexid` `indexid` int(4) NOT NULL;
ALTER TABLE `playercreateinfo_items` CHANGE column `protoid` `protoid` int(4) NOT NULL;
ALTER TABLE `playercreateinfo_items` CHANGE column `slotid` `slotid` int(10) NOT NULL;
ALTER TABLE `playercreateinfo_items` CHANGE column `amount` `amount` int(3) NOT NULL;
ALTER TABLE `items` DROP column `itemstatscount`;
ALTER TABLE `items` DROP column `existingduration`;

-- itempetfood
REPLACE INTO itempetfood(entry, food_type) VALUES(30610, 1);

-- quests
ALTER TABLE `quests` CHANGE column `entry` `entry` int(11) UNSIGNED NOT NULL;
ALTER TABLE `quests` CHANGE column `ZoneId` `ZoneId` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `sort` `sort` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `flags` `flags` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `MinLevel` `MinLevel` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `questlevel` `questlevel` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `Type` `Type` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RequiredRaces` `RequiredRaces` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RequiredClass` `RequiredClass` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RequiredTradeskill` `RequiredTradeskill` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RequiredTradeskillValue` `RequiredTradeskillValue` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RequiredRepFaction` `RequiredRepFaction` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RequiredRepValue` `RequiredRepValue` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `SuggestedPlayers` `SuggestedPlayers` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `LimitTime` `LimitTime` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `SpecialFlags` `SpecialFlags` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `PrevQuestId` `PrevQuestId` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `NextQuestId` `NextQuestId` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `srcItem` `srcItem` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `SrcItemCount` `SrcItemCount` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `Title` `Title` text NOT NULL;
ALTER TABLE `quests` CHANGE column `Details` `Details` text NOT NULL;
ALTER TABLE `quests` CHANGE column `Objectives` `Objectives` text NOT NULL;
ALTER TABLE `quests` CHANGE column `CompletionText` `CompletionText` text NOT NULL;
ALTER TABLE `quests` CHANGE column `IncompleteText` `IncompleteText` text NOT NULL;
ALTER TABLE `quests` CHANGE column `EndText` `EndText` text NOT NULL;
ALTER TABLE `quests` CHANGE column `ObjectiveText1` `ObjectiveText1` text NOT NULL;
ALTER TABLE `quests` CHANGE column `ObjectiveText2` `ObjectiveText2` text NOT NULL;
ALTER TABLE `quests` CHANGE column `ObjectiveText3` `ObjectiveText3` text NOT NULL;
ALTER TABLE `quests` CHANGE column `ObjectiveText4` `ObjectiveText4` text NOT NULL;
ALTER TABLE `quests` CHANGE column `ReqItemId1` `ReqItemId1` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqItemId2` `ReqItemId2` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqItemId3` `ReqItemId3` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqItemId4` `ReqItemId4` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqItemCount1` `ReqItemCount1` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqItemCount2` `ReqItemCount2` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqItemCount3` `ReqItemCount3` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqItemCount4` `ReqItemCount4` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqKillMobOrGOId1` `ReqKillMobOrGOId1` bigint(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqKillMobOrGOId2` `ReqKillMobOrGOId2` bigint(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqKillMobOrGOId3` `ReqKillMobOrGOId3` bigint(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqKillMobOrGOId4` `ReqKillMobOrGOId4` bigint(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqKillMobOrGOCount1` `ReqKillMobOrGOCount1` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqKillMobOrGOCount2` `ReqKillMobOrGOCount2` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqKillMobOrGOCount3` `ReqKillMobOrGOCount3` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqKillMobOrGOCount4` `ReqKillMobOrGOCount4` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqCastSpellId1` `ReqCastSpellId1` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqCastSpellId2` `ReqCastSpellId2` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqCastSpellId3` `ReqCastSpellId3` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `ReqCastSpellId4` `ReqCastSpellId4` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemId1` `RewChoiceItemId1` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemId2` `RewChoiceItemId2` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemId3` `RewChoiceItemId3` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemId4` `RewChoiceItemId4` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemId5` `RewChoiceItemId5` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemId6` `RewChoiceItemId6` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemCount1` `RewChoiceItemCount1` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemCount2` `RewChoiceItemCount2` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemCount3` `RewChoiceItemCount3` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemCount4` `RewChoiceItemCount4` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemCount5` `RewChoiceItemCount5` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewChoiceItemCount6` `RewChoiceItemCount6` int(11) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE `quests` CHANGE column `RewRepFaction5` `RewRepFaction5` INT(11) DEFAULT 0 NOT NULL;
ALTER TABLE `quests` CHANGE column `RewRepFaction4` `RewRepFaction4` INT(11) DEFAULT 0 NOT NULL;
ALTER TABLE `quests` CHANGE column `RewRepFaction3` `RewRepFaction3` INT(11) DEFAULT 0 NOT NULL;
ALTER TABLE `quests` CHANGE column `RewRepValue5` `RewRepValue5` INT(11) DEFAULT 0 NOT NULL;
ALTER TABLE `quests` CHANGE column `RewRepValue4` `RewRepValue4` INT(11) DEFAULT 0 NOT NULL;
ALTER TABLE `quests` CHANGE column `RewRepValue3` `RewRepValue3` INT(11) DEFAULT 0 NOT NULL;
ALTER TABLE `quests` CHANGE COLUMN `bonushonor` `RewBonusHonor` int(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `RewMoney`;
ALTER TABLE `quests` CHANGE COLUMN `rewardtalents` `RewTalent` int(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `RewSpell`;
ALTER TABLE `quests` CHANGE COLUMN `rewardtitleid` `RewTitle` int(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `RewRepLimit`;
ALTER TABLE `quests` CHANGE COLUMN `suggestedplayers` `SuggestedPlayers` int(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `RequiredRepValue`;
ALTER TABLE `quests` ADD COLUMN `RequiredQuest_and_or` INT(3) DEFAULT 0 NOT NULL AFTER `RequiredQuest4`;
ALTER TABLE `quests` ADD COLUMN `ReqKillPlayer` int(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `ReqItemCount4`;
ALTER TABLE `quests` ADD COLUMN `RequiredMoney` int(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `PointOpt`;

ALTER TABLE `quests` DROP column `RewardMoneyAtMaxLevel`;
ALTER TABLE `quests` DROP column `detailemotecount`;
ALTER TABLE `quests` DROP column `detailemote1`;
ALTER TABLE `quests` DROP column `detailemote2`;
ALTER TABLE `quests` DROP column `detailemote3`;
ALTER TABLE `quests` DROP column `detailemote4`;
ALTER TABLE `quests` DROP column `detailemotedelay1`;
ALTER TABLE `quests` DROP column `detailemotedelay2`;
ALTER TABLE `quests` DROP column `detailemotedelay3`;
ALTER TABLE `quests` DROP column `detailemotedelay4`;
ALTER TABLE `quests` DROP column `completionemotecnt`;
ALTER TABLE `quests` DROP column `completionemote1`;
ALTER TABLE `quests` DROP column `completionemote2`;
ALTER TABLE `quests` DROP column `completionemote3`;
ALTER TABLE `quests` DROP column `completionemote4`;
ALTER TABLE `quests` DROP column `completionemotedelay1`;
ALTER TABLE `quests` DROP column `completionemotedelay2`;
ALTER TABLE `quests` DROP column `completionemotedelay3`;
ALTER TABLE `quests` DROP column `completionemotedelay4`;
ALTER TABLE `quests` DROP column `completeemote`;
ALTER TABLE `quests` DROP column `incompleteemote`;
ALTER TABLE `quests` DROP column `RemoveQuests`;
ALTER TABLE `quests` DROP column `RequiredOneOfQuest`;
ALTER TABLE `quests` DROP column `RewRepValue6`;
ALTER TABLE `quests` DROP column `RewRepFaction6`;

-- quests_localized
ALTER TABLE `quests_localized` CHANGE column `language_code` `language_code` varchar(5) NOT NULL;
ALTER TABLE `quests_localized` CHANGE column `Title` `Title` text NOT NULL;
ALTER TABLE `quests_localized` CHANGE column `Details` `Details` text NOT NULL;
ALTER TABLE `quests_localized` CHANGE column `Objectives` `Objectives` text NOT NULL;
ALTER TABLE `quests_localized` CHANGE column `CompletionText` `CompletionText` text NOT NULL;
ALTER TABLE `quests_localized` CHANGE column `IncompleteText` `IncompleteText` text NOT NULL;
ALTER TABLE `quests_localized` CHANGE column `EndText` `EndText` text NOT NULL;
ALTER TABLE `quests_localized` CHANGE column `ObjectiveText1` `ObjectiveText1` text NOT NULL;
ALTER TABLE `quests_localized` CHANGE column `ObjectiveText2` `ObjectiveText2` text NOT NULL;
ALTER TABLE `quests_localized` CHANGE column `ObjectiveText3` `ObjectiveText3` text NOT NULL;

-- reputation_instance_onkill
ALTER TABLE `reputation_instance_onkill` 
ADD COLUMN `mob_rep_reward_heroic` int(30) NOT NULL AFTER `mob_rep_reward`,
ADD COLUMN `mob_rep_limit_heroic` int(30) NOT NULL AFTER `mob_rep_limit`,
ADD COLUMN `boss_rep_reward_heroic` int(30) NOT NULL AFTER `boss_rep_reward`,
ADD COLUMN `boss_rep_limit_heroic` int(30) NOT NULL AFTER `boss_rep_limit`;
UPDATE `reputation_instance_onkill` SET
`mob_rep_reward_heroic`= `mob_rep_reward`,
`mob_rep_limit_heroic` = `mob_rep_limit`,
`boss_rep_reward_heroic` = `boss_rep_reward`,
`boss_rep_limit_heroic` = `boss_rep_limit`;

-- spelloverride
ALTER TABLE `spelloverride` CHANGE column `overrideId` `overrideId` int(30) NOT NULL DEFAULT 0;
ALTER TABLE `spelloverride` CHANGE column `spellId` `spellId` int(30) NOT NULL DEFAULT 0;

-- teleport_coords
ALTER TABLE `teleport_coords` CHANGE column `id` `entry` int(16) NOT NULL;
ALTER TABLE `teleport_coords` CHANGE column `mapId` `mapId` int(16) NOT NULL;
ALTER TABLE `teleport_coords` CHANGE column `mapId` `mapId` int(16) NOT NULL;
ALTER TABLE `teleport_coords` DROP column `totrigger`;
ALTER TABLE `teleport_coords` ADD column `orientation` float NOT NULL DEFAULT 0 AFTER `position_z`;

-- trainer_defs
ALTER TABLE `trainer_defs` DROP column `RequiredRace`;
ALTER TABLE `trainer_defs` DROP column `RequiredReputation`;
ALTER TABLE `trainer_defs` DROP column `RequiredReputationValue`;

-- transport_data
DROP TABLE IF EXISTS `transport_data`;

-- spellfixes
ALTER TABLE spellfixes DROP SpellGroupType;
ALTER TABLE spellfixes DROP groupRelation0;
ALTER TABLE spellfixes DROP groupRelation1;
ALTER TABLE spellfixes DROP groupRelation2;
ALTER TABLE spellfixes ADD effect0ClassMask0 int4 UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE spellfixes ADD effect0ClassMask1 int4 UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE spellfixes ADD effect0ClassMask2 int4 UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE spellfixes ADD effect1ClassMask0 int4 UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE spellfixes ADD effect1ClassMask1 int4 UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE spellfixes ADD effect1ClassMask2 int4 UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE spellfixes ADD effect2ClassMask0 int4 UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE spellfixes ADD effect2ClassMask1 int4 UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE spellfixes ADD effect2ClassMask2 int4 UNSIGNED NOT NULL DEFAULT 0;

-- wordfilter_character_names
ALTER TABLE `wordfilter_character_names` CHANGE column `regex_match` `regex_match` varchar(255) NOT NULL;
ALTER TABLE `wordfilter_character_names` CHANGE column `regex_ignore_if_matched` `regex_ignore_if_matched` varchar(255) DEFAULT '';


-- worldmap_info
ALTER TABLE `worldmap_info` CHANGE column  `area_name` `area_name` varchar(100) DEFAULT '0';
ALTER TABLE worldmap_info ADD COLUMN collision int1 unsigned not null default 1;
ALTER TABLE `worldmap_info` DROP COLUMN `minlevel_heroic`;


-- worldstate_template

DROP TABLE IF EXISTS `worldstate_template`;

CREATE TABLE `worldstate_template` (
  `mapid` int(30) unsigned NOT NULL,
  `zone_mask` int(30) NOT NULL,
  `faction_mask` int(30) NOT NULL,
  `field_number` int(30) unsigned NOT NULL,
  `initial_value` int(30) NOT NULL,
  `comment` varchar(200) NOT NULL,
  PRIMARY KEY (`field_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `worldstate_template` VALUES (530,3483,-1,2476,0,'WORLDSTATE_HELLFIRE_ALLIANCE_TOWERS_CONTROLLED'),(530,3483,-1,2478,0,'WORLDSTATE_HELLFIRE_HORDE_TOWERS_CONTROLLED'),(530,3483,-1,2490,1,'WORLDSTATE_HELLFIRE_TOWER_DISPLAY_ALLIANCE'),(530,3483,-1,2489,1,'WORLDSTATE_HELLFIRE_TOWER_DISPLAY_HORDE'),(530,3483,-1,2473,0,'WORLDSTATE_HELLFIRE_PVP_CAPTURE_BAR_DISPLAY'),(530,3483,-1,2474,0,'WORLDSTATE_HELLFIRE_PVP_CAPTURE_BAR_VALUE'),(530,3483,-1,2472,1,'WORLDSTATE_HELLFIRE_STADIUM_NEUTRAL'),(530,3483,-1,2471,0,'WORLDSTATE_HELLFIRE_STADIUM_ALLIANCE'),(530,3483,-1,2470,0,'WORLDSTATE_HELLFIRE_STADIUM_HORDE'),(530,3483,-1,2482,1,'WORLDSTATE_HELLFIRE_OVERLOOK_NEUTRAL'),(530,3483,-1,2480,0,'WORLDSTATE_HELLFIRE_OVERLOOK_ALLIANCE'),(530,3483,-1,2481,0,'WORLDSTATE_HELLFIRE_OVERLOOK_HORDE'),(530,3483,-1,2485,1,'WORLDSTATE_HELLFIRE_BROKENHILL_NEUTRAL'),(530,3483,-1,2483,0,'WORLDSTATE_HELLFIRE_BROKENHILL_ALLIANCE'),(530,3483,-1,2484,0,'WORLDSTATE_HELLFIRE_BROKENHILL_HORDE'),(530,3518,-1,2502,0,'WORLDSTATE_HALAA_GUARD_DISPLAY_ALLIANCE'),(530,3518,-1,2503,0,'WORLDSTATE_HALAA_GUARD_DISPLAY_HORDE'),(530,3518,-1,2491,0,'WORLDSTATE_HALAA_GUARDS_REMAINING'),(530,3518,-1,2493,0,'WORLDSTATE_HALAA_GUARDS_REMAINING_MAX');
ALTER TABLE worldstate_template CHANGE COLUMN mapid mapid int4 not null;
INSERT INTO worldstate_template(mapid, zone_mask, faction_mask, field_number, initial_value, comment) VALUES(-1, -1, -1, 3901, 4, 'ARENA_SEASON_COUNT');
INSERT INTO worldstate_template(mapid, zone_mask, faction_mask, field_number, initial_value, comment) VALUES(-1, -1, -1, 3191, 4, 'ARENA_SEASON_STATE; 0 = finished; else started');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2621','0','WORLDSTATE_TEROKKAR_ALLIANCE_TOWERS_CONTROLLED');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2622','0','WORLDSTATE_TEROKKAR_HORDE_TOWERS_CONTROLLED');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2620','1','WORLDSTATE_TEROKKAR_TOWER_DISPLAY');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2623','0','WORLDSTATE_TEROKKAR_PVP_CAPTURE_BAR_DISPLAY');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2625','0','WORLDSTATE_TEROKKAR_PVP_CAPTURE_BAR_VALUE');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2681','1','WORLDSTATE_TEROKKAR_TOWER1_NEUTRAL');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2686','1','WORLDSTATE_TEROKKAR_TOWER2_NEUTRAL');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2690','1','WORLDSTATE_TEROKKAR_TOWER3_NEUTRAL');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2696','1','WORLDSTATE_TEROKKAR_TOWER4_NEUTRAL');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2693','1','WORLDSTATE_TEROKKAR_TOWER5_NEUTRAL');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2683','0','WORLDSTATE_TEROKKAR_TOWER1_ALLIANCE');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2684','0','WORLDSTATE_TEROKKAR_TOWER2_ALLIANCE');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2688','0','WORLDSTATE_TEROKKAR_TOWER3_ALLIANCE');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2694','0','WORLDSTATE_TEROKKAR_TOWER4_ALLIANCE');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2691','0','WORLDSTATE_TEROKKAR_TOWER5_ALLIANCE');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2682','0','WORLDSTATE_TEROKKAR_TOWER1_HORDE');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2685','0','WORLDSTATE_TEROKKAR_TOWER2_HORDE');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2689','0','WORLDSTATE_TEROKKAR_TOWER3_HORDE');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2695','0','WORLDSTATE_TEROKKAR_TOWER4_HORDE');
REPLACE INTO `worldstate_template` (`mapid`,`zone_mask`,`faction_mask`,`field_number`,`initial_value`,`comment`) VALUES ('530','3519','-1','2692','0','WORLDSTATE_TEROKKAR_TOWER5_HORDE');

-- Prestartqueries

DROP TABLE IF EXISTS `prestartqueries`;

CREATE TABLE `prestartqueries` (
  `Query` varchar(1024) NOT NULL,
  `SingleShot` int(1) unsigned NOT NULL default '1',
  `Seq` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`Seq`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Achievement_Rewards

DROP TABLE IF EXISTS `achievement_rewards`;

CREATE TABLE `achievement_rewards` (
  `achievementid` int(10) unsigned NOT NULL,
  `title_alliance` int(10) unsigned NOT NULL,
  `title_horde` int(10) unsigned NOT NULL,
  `itemid` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`achievementid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `news_announcements`;

CREATE TABLE `news_announcements` (
  `id` int(30) unsigned NOT NULL AUTO_INCREMENT,
  `faction_mask` int(30) NOT NULL,
  `message_text` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;