CREATE TABLE IF NOT EXISTS `chat_data`.`Channel` (
  `ID` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Platform` INT(10) UNSIGNED NOT NULL,
  `Specific_ID` VARCHAR(16) DEFAULT NULL COMMENT 'Platform-specific ID of the channel',
  `Mode` ENUM('Inactive','Last seen','Read','Write','VIP','Moderator') DEFAULT 'Write' COMMENT 'On Twitch, the modes are updated automatically.\r\nModerator = full access, almost no message buffering\r\nVIP = high access, very small message buffering timeout\r\nWrite = behaves as a regular chatter, enforces global slow-mode and spam limiters\r\nRead = read-only access, but will join channel and log it. does not reply or send any messages in channel\r\nInactive = like Read, but will not join channel at all',
  `Ping` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'If true, will attempt to "ping" people who use commands in this channel',
  `Links_Allowed` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'If false, any links in responses will be replaced by placeholder text',
  `NSFW` TINYINT(1) DEFAULT NULL COMMENT 'Flag that determines whether or not NSFW content can be posted in said channel.\r\nCurrently only sets TRUE for Discord channels with nsfw FLAG set to true.',
  `Banphrase_API_Type` ENUM('Pajbot') DEFAULT NULL COMMENT 'If a channel should use an external banphrase API, this should be its type. Currently only supports "Pajbot".',
  `Banphrase_API_URL` VARCHAR(100) DEFAULT NULL COMMENT 'If a channel should use an external banphrase API, this should be its bare URL - no https:// or endpoints',
  `Banphrase_API_Downtime` enum('Ignore','Notify','Nothing','Refuse','Whisper') DEFAULT NULL COMMENT 'Determines the behaviour the bot should take if the banphrase API times out.\r\nIgnore - acts as if nothing happened and posts the message as is.\r\nNotify - as Ignore, but adds a warning emoji/message set up in Config\r\nRefuse - bot will refuse to reply with a warning message set up in Config',
  `Message_Limit` SMALLINT(5) UNSIGNED DEFAULT NULL COMMENT 'If not NULL, this determines the maximum length of a message in said channel. If NULL, will use Platform defaults.',
  `Custom_Code` TEXT DEFAULT NULL COMMENT 'Custom Javascript code executed for every message sent in said channel.',
  `Mirror` INT(10) UNSIGNED DEFAULT NULL COMMENT 'If not NULL, will mirror all messages from this channel to channel specified in Mirror.',
  `Description` TEXT DEFAULT NULL,
  `Data` LONGTEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Specific data to be used in other places, i.e. commands',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name_Platform` (`Name`,`Platform`),
  KEY `Mirror` (`Mirror`),
  KEY `FK_Channel_Platform` (`Platform`),
  CONSTRAINT `FK_Channel_Platform` FOREIGN KEY (`Platform`) REFERENCES `Platform` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Mirror` FOREIGN KEY (`Mirror`) REFERENCES `Channel` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;