CREATE TABLE IF NOT EXISTS `AGENT` (
  `ID` VARCHAR(64) NOT NULL,
  `PW` VARCHAR(64) DEFAULT NULL,
  `Name` VARCHAR(64) DEFAULT NULL,
  `Position` VARCHAR(64) DEFAULT NULL,
  `Phone` VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `CCTV` (
  `ID` VARCHAR(64) NOT NULL,
  `Model` VARCHAR(64) DEFAULT NULL,
  `InstallationDate` DATE DEFAULT NULL,
  `AGENT_ID` VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_CCTV_AGENT` FOREIGN KEY (`AGENT_ID`) REFERENCES `AGENT` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `AREA` (
  `ID` VARCHAR(64) NOT NULL,
  `Address` VARCHAR(64) DEFAULT NULL,
  `Building` VARCHAR(64) DEFAULT NULL,
  `Floor` VARCHAR(64) DEFAULT NULL,
  `Indoor` VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `META_LOG_FILE` (
  `ID` VARCHAR(64) NOT NULL,
  `CCTV_ID` VARCHAR(64) DEFAULT NULL,
  `AREA_ID` VARCHAR(64) DEFAULT NULL,
  `StartTime` DATETIME DEFAULT NULL,
  `EndTime` DATETIME DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_META_LOG_FILE_AREA` FOREIGN KEY (`AREA_ID`) REFERENCES `AREA` (`ID`),
  CONSTRAINT `FK_META_LOG_FILE_CCTV` FOREIGN KEY (`CCTV_ID`) REFERENCES `CCTV` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `OBJECT` (
  `ID` VARCHAR(64) NOT NULL,
  `Speed` INT DEFAULT NULL,
  `Size` INT DEFAULT NULL,
  `Color` VARCHAR(64) DEFAULT NULL,
  `PosX` INT DEFAULT NULL,
  `PosY` INT DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ADJACENT_AREA` (
  `PathName` VARCHAR(64) NOT NULL,
  `PathPos` VARCHAR(64) DEFAULT NULL,
  `AREA1_ID` VARCHAR(64) DEFAULT NULL,
  `AREA2_ID` VARCHAR(64) DEFAULT NULL,
  PRIMARY KEY (`PathName`),
  CONSTRAINT `FK_ADJACENT_AREA_AREA_1` FOREIGN KEY (`AREA1_ID`) REFERENCES `AREA` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ADJACENT_AREA_AREA_2` FOREIGN KEY (`AREA2_ID`) REFERENCES `AREA` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `SEQUENCE` (
  `ID` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `LINKS` (
  `SEQUENCE_ID` VARCHAR(64) NOT NULL,
  `ADJACENT_AREA_PathName` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`SEQUENCE_ID`, `AREA_PathName`),
  CONSTRAINT `FK_LINKS_SEQUENCE` FOREIGN KEY (`SEQUENCE_ID`) REFERENCES `SEQUENCE` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_LINKS_ADJACENT_AREA` FOREIGN KEY (`ADJACENT_AREA_PathName`) REFERENCES `ADJACENT_AREA` (`PathName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `META_LOG_RECORD` (
  `TimeStamp` DATETIME NOT NULL,
  `META_LOG_FILE_ID` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`TimeStamp`, `META_LOG_FILE_ID`),
  CONSTRAINT `FK_META_LOG_RECORD_META_LOG_FILE` FOREIGN KEY (`META_LOG_FILE_ID`) REFERENCES `META_LOG_FILE` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `CAPTURES` (
  `META_LOG_RECORD_TimeStamp` DATETIME NOT NULL,
  `OBJECT_ID` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`META_LOG_RECORD_TimeStamp`, `OBJECT_ID`),
  CONSTRAINT `FK_CAPTURES_META_LOG_RECORD` FOREIGN KEY (`META_LOG_RECORD_TimeStamp`) REFERENCES `META_LOG_RECORD` (`TimeStamp`),
  CONSTRAINT `FK_CAPTURES_OBJECT` FOREIGN KEY (`OBJECT_ID`) REFERENCES `OBJECT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `MONITORS` (
  `CCTV_ID` VARCHAR(64) NOT NULL,
  `AREA_ID` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`CCTV_ID`, `AREA_ID`),
  CONSTRAINT `FK_MONITORS_CCTV` FOREIGN KEY (`CCTV_ID`) REFERENCES `CCTV` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MONITORS_AREA` FOREIGN KEY (`AREA_ID`) REFERENCES `AREA` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `RECORDS` (
  `CCTV_ID` VARCHAR(64) NOT NULL,
  `META_LOG_FILE_ID` VARCHAR(64) NOT NULL,
  `AREA_ID` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`CCTV_ID`, `META_LOG_FILE_ID`, `AREA_ID`),
  CONSTRAINT `FK_RECORDS_CCTV` FOREIGN KEY (`CCTV_ID`) REFERENCES `CCTV` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RECORDS_META_LOG_FILE` FOREIGN KEY (`META_LOG_FILE_ID`) REFERENCES `META_LOG_FILE` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_RECORDS_AREA` FOREIGN KEY (`AREA_ID`) REFERENCES `AREA` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `STATISTICS` (
  `META_LOG_FILE_ID` VARCHAR(64) NOT NULL,
  `NumRecords` INT DEFAULT NULL,
  `RunningTime` INT DEFAULT NULL,
  `NumObjs` INT DEFAULT NULL,
  `AvgSize` INT DEFAULT NULL,
  `AvgColor` INT DEFAULT NULL,
  `AvgSpd` INT DEFAULT NULL,
  CONSTRAINT `FK_STATISTICS_META_LOG_FILE` FOREIGN KEY (`META_LOG_FILE_ID`) REFERENCES `META_LOG_FILE` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
