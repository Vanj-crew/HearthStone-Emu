ALTER TABLE gm_tickets ADD type int(2) NOT NULL AFTER level;
ALTER TABLE `gm_tickets` DROP COLUMN `deleted`;
ALTER TABLE `gm_tickets` DROP COLUMN `assignedto`;
ALTER TABLE `gm_tickets` DROP COLUMN `comment`;

ALTER TABLE groups DROP instanceids;
ALTER TABLE `groups` ADD COLUMN `GroupInstanceID` int(30) UNSIGNED NOT NULL DEFAULT 0 AFTER `main_assist`;

ALTER TABLE playerpets DROP reset_time;
ALTER TABLE playerpets DROP reset_cost;
ALTER TABLE playerpets DROP spellid;
ALTER TABLE `playerpets` ADD column `loyaltypts` int(11) NOT NULL DEFAULT 0;
ALTER TABLE `playerpets` ADD column `loyaltyupdate` int(11) NOT NULL DEFAULT 0;

ALTER TABLE `instances` ADD COLUMN `active_members` text NOT NULL AFTER `creator_guid`;

DROP TABLE instanceids;
ALTER TABLE instances DROP persistent;

ALTER TABLE guilds CHANGE bankBalance bankBalance int(30) NOT NULL DEFAULT 0;
alter table `guild_banktabs` drop `tabInfo`;

ALTER TABLE questlog ADD COLUMN `player_slain` int(10) UNSIGNED NOT NULL DEFAULT 0;

ALTER TABLE `characters` DROP COLUMN `available_pvp_titles1`;
ALTER TABLE characters ADD COLUMN `finished_daily_quests` longtext not null AFTER `finished_quests`;
ALTER TABLE characters ADD COLUMN `force_reset_talents` tinyint not null;
ALTER TABLE characters MODIFY COLUMN available_pvp_titles bigint(40) unsigned NOT NULL;
ALTER TABLE `characters` MODIFY `available_pvp_titles` bigint(40) not null;
ALTER TABLE characters ADD COLUMN `available_pvp_titles2` bigint(40) not null after available_pvp_titles;
ALTER TABLE characters CHANGE `available_pvp_titles2` `available_pvp_titles2` bigint(40) unsigned NOT NULL;
ALTER TABLE characters DROP finisheddailies;
ALTER TABLE `characters` 
	CHANGE `name` `name` varchar(21)  COLLATE latin1_swedish_ci NOT NULL after `acct`, 
	CHANGE `race` `race` smallint(3) unsigned   NOT NULL after `name`, 
	CHANGE `class` `class` smallint(3) unsigned   NOT NULL after `race`, 
	CHANGE `gender` `gender` tinyint(1) unsigned   NOT NULL after `class`, 
	CHANGE `level` `level` int(3) unsigned   NOT NULL after `custom_faction`, 
	CHANGE `xp` `xp` int(30) unsigned   NOT NULL after `level`, 
	CHANGE `watched_faction_index` `watched_faction_index` bigint(40) unsigned   NOT NULL after `skills`, 
	CHANGE `selected_pvp_title` `selected_pvp_title` int(30) unsigned   NOT NULL after `watched_faction_index`, 
	CHANGE `available_pvp_titles` `available_pvp_titles` int(30) unsigned   NOT NULL DEFAULT '0' after `selected_pvp_title`, 
	CHANGE `gold` `gold` int(30) unsigned   NOT NULL after `available_pvp_titles`, 
	CHANGE `ammo_id` `ammo_id` int(30) unsigned   NOT NULL after `gold`, 
	CHANGE `available_prof_points` `available_prof_points` int(30) unsigned   NOT NULL after `ammo_id`, 
	CHANGE `available_talent_points` `available_talent_points` int(30) unsigned   NOT NULL after `available_prof_points`, 
	CHANGE `current_hp` `current_hp` int(30) unsigned   NOT NULL after `available_talent_points`, 
	CHANGE `current_power` `current_power` int(30) unsigned   NOT NULL after `current_hp`, 
	CHANGE `pvprank` `pvprank` int(30) unsigned   NOT NULL after `current_power`, 
	CHANGE `bytes` `bytes` int(30) unsigned   NOT NULL after `pvprank`, 
	CHANGE `bytes2` `bytes2` int(30) unsigned   NOT NULL after `bytes`, 
	CHANGE `player_flags` `player_flags` int(30) unsigned   NOT NULL after `bytes2`, 
	CHANGE `player_bytes` `player_bytes` int(30) unsigned   NOT NULL after `player_flags`, 
	CHANGE `banned` `banned` int(40)   NOT NULL after `taximask`, 
	CHANGE `banReason` `banReason` varchar(255)  COLLATE latin1_swedish_ci NULL after `banned`, 
	CHANGE `timestamp` `timestamp` text  COLLATE latin1_swedish_ci NULL after `banReason`, 
	CHANGE `forced_rename_pending` `forced_rename_pending` int(30)   NOT NULL after `first_login`, 
	CHANGE `killsLifeTime` `killsLifeTime` int(10)   NULL DEFAULT '0' after `killsYesterday`, COMMENT='';


ALTER TABLE accounts CHANGE `password` `password` varchar(42) NOT NULL default '';
UPDATE accounts SET password = encrypted_password WHERE encrypted_password != '';
ALTER TABLE ACCOUNTS DROP encrypted_password;
ALTER TABLE accounts ADD COLUMN SessionKey varchar(255) NOT NULL default '' AFTER Password;
ALTER TABLE accounts ADD COLUMN changed int1 unsigned not null default 1;
ALTER TABLE accounts DROP COLUMN forceLanguage;
ALTER TABLE accounts DROP banreason;

ALTER TABLE ipbans DROP banreason;


DROP TABLE IF EXISTS `character_achievement_progress`;
DROP TABLE IF EXISTS `character_achievement`;
DROP TABLE IF EXISTS `playersummons`;

CREATE TABLE `prestartqueries` (
  `Query` varchar(1024) NOT NULL,
  `SingleShot` int(1) unsigned NOT NULL default '1',
  `Seq` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`Seq`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
-- ----------------------------
-- Records (Character database)
-- ----------------------------
INSERT INTO `prestartqueries` (Query,SingleShot) VALUES ('UPDATE characters SET banned=0,banReason=\'\' WHERE banned > 100 AND banned < UNIX_TIMESTAMP();', '0');
INSERT INTO `prestartqueries` (Query,SingleShot) VALUES ('DELETE FROM guild_logs WHERE timestamp < (UNIX_TIMESTAMP()-1209600);', '0');
INSERT INTO `prestartqueries` (Query,SingleShot) VALUES ('DELETE FROM guild_banklogs WHERE timestamp < (UNIX_TIMESTAMP()-1209600);', '0');


CREATE TABLE `playerskills` (
  `player_guid` int(11) NOT NULL DEFAULT '0',
  `skill_id` int(11) NOT NULL DEFAULT '0',
  `type` int(11) NOT NULL,
  `currentlvl` int(11) NOT NULL DEFAULT '1',
  `maxlvl` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`player_guid`,`skill_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



ALTER TABLE `server_settings` MODIFY setting_value INT UNSIGNED NOT NULL;
ALTER TABLE `server_settings` 
	CHANGE `setting_value` `setting_value` int(10) unsigned   NOT NULL after `setting_id`, COMMENT='';

CREATE TABLE `worldstate_save_data`(
	`setting_id` varchar(50) COLLATE utf8_general_ci NOT NULL  , 
	`setting_value` varchar(200) COLLATE utf8_general_ci NOT NULL  , 
	PRIMARY KEY (`setting_id`) 
) ENGINE=MyISAM DEFAULT CHARSET='utf8';

CREATE TABLE `news_timers`(
	`id` int(10) unsigned NOT NULL  , 
	`time` int(10) unsigned NOT NULL  , 
	PRIMARY KEY (`id`) 
) ENGINE=MyISAM DEFAULT CHARSET='latin1';