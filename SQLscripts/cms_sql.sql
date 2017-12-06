CREATE TABLE IF NOT EXISTS `AGENT` (
  `ID` varchar(64) NOT NULL,
  `PW` varchar(64) DEFAULT NULL,
  `Name` varchar(64) DEFAULT NULL,
  `Position` varchar(64) DEFAULT NULL,
  `Phone` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `CCTV` (
  `ID` varchar(64) NOT NULL,
  `Model` varchar(64) DEFAULT NULL,
  `InstallationDate` date DEFAULT NULL,
  `AGENT_ID` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_CCTV_AGENT` FOREIGN KEY (`AGENT_ID`) REFERENCES `AGENT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `AREA` (
  `ID` varchar(64) NOT NULL,
  `Address` varchar(64) DEFAULT NULL,
  `Building` varchar(64) DEFAULT NULL,
  `Floor` int(3) DEFAULT NULL,
  `Indoor` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `META_LOG_FILE` (
  `ID` varchar(64) NOT NULL,
  `CCTV_ID` varchar(64) DEFAULT NULL,
  `AREA_ID` varchar(64) DEFAULT NULL,
  `StartTime` timestamp NULL DEFAULT NULL,
  `EndTime` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `FK_META_LOG_FILE_AREA` FOREIGN KEY (`AREA_ID`) REFERENCES `AREA` (`ID`),
  CONSTRAINT `FK_META_LOG_FILE_CCTV` FOREIGN KEY (`CCTV_ID`) REFERENCES `CCTV` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `OBJECT` (
  `ID` varchar(64) NOT NULL,
  `Speed` int UNSIGNED DEFAULT NULL,
  `Size` int UNSIGNED DEFAULT NULL,
  `Color` varchar(64) DEFAULT NULL,
  `PosX` int DEFAULT NULL,
  `PosY` int DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `ADJACENT_AREA` (
  `PathName` varchar(64) NOT NULL,
  `PathPos` varchar(64) DEFAULT NULL,
  `AREA1_ID` varchar(64) DEFAULT NULL,
  `AREA2_ID` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`PathName`),
  CONSTRAINT `FK_ADJACENT_AREA_AREA_1` FOREIGN KEY (`AREA1_ID`) REFERENCES `AREA` (`ID`),
  CONSTRAINT `FK_ADJACENT_AREA_AREA_2` FOREIGN KEY (`AREA2_ID`) REFERENCES `AREA` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `SEQUENCE` (
  `ID` varchar(64) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `LINKS` (
  `SEQUENCE_ID` varchar(64) NOT NULL,
  `AREA_PathName` varchar(64) NOT NULL,
  PRIMARY KEY (`SEQUENCE_ID`, `AREA_PathName`),
  CONSTRAINT `FK_LINKS_SEQUENCE` FOREIGN KEY (`SEQUENCE_ID`) REFERENCES `SEQUENCE` (`ID`),
  CONSTRAINT `FK_LINKS_ADJACENT_AREA` FOREIGN KEY (`AREA_PathName`) REFERENCES `ADJACENT_AREA` (`PathName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `META_LOG_RECORD` (
  `TimeStamp` timestamp NOT NULL,
  `META_LOG_FILE_ID` varchar(64) NOT NULL,
  PRIMARY KEY (`TimeStamp`, `META_LOG_FILE_ID`),
  CONSTRAINT `FK_META_LOG_RECORD_META_LOG_FILE` FOREIGN KEY (`META_LOG_FILE_ID`) REFERENCES `META_LOG_FILE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `CAPTURES` (
  `META_LOG_RECORD_TimeStamp` timestamp NOT NULL,
  `OBJECT_ID` varchar(64) NOT NULL,
  PRIMARY KEY (`META_LOG_RECORD_TimeStamp`, `OBJECT_ID`),
  CONSTRAINT `FK_CAPTURES_META_LOG_RECORD` FOREIGN KEY (`META_LOG_RECORD_TimeStamp`) REFERENCES `META_LOG_RECORD` (`TimeStamp`),
  CONSTRAINT `FK_CAPTURES_OBJECT` FOREIGN KEY (`OBJECT_ID`) REFERENCES `OBJECT` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `MONITORS` (
  `CCTV_ID` varchar(64) NOT NULL,
  `AREA_ID` varchar(64) NOT NULL,
  PRIMARY KEY (`CCTV_ID`, `AREA_ID`),
  CONSTRAINT `FK_MONITORS_CCTV` FOREIGN KEY (`CCTV_ID`) REFERENCES `CCTV` (`ID`),
  CONSTRAINT `FK_MONITORS_AREA` FOREIGN KEY (`AREA_ID`) REFERENCES `AREA` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `RECORDS` (
  `CCTV_ID` varchar(64) NOT NULL,
  `META_LOG_FILE_ID` varchar(64) NOT NULL,
  `AREA_ID` varchar(64) NOT NULL,
  PRIMARY KEY (`CCTV_ID`, `META_LOG_FILE_ID`, `AREA_ID`),
  CONSTRAINT `FK_RECORDS_CCTV` FOREIGN KEY (`CCTV_ID`) REFERENCES `CCTV` (`ID`),
  CONSTRAINT `FK_RECORDS_META_LOG_FILE` FOREIGN KEY (`META_LOG_FILE_ID`) REFERENCES `META_LOG_FILE` (`ID`),
  CONSTRAINT `FK_RECORDS_AREA` FOREIGN KEY (`AREA_ID`) REFERENCES `AREA` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE IF NOT EXISTS `STATISTICS` (
  `META_LOG_FILE_ID` varchar(64) NOT NULL,
  `NumRecords` int UNSIGNED DEFAULT NULL,
  `RunningTime` int UNSIGNED DEFAULT NULL,
  `NumObjs` int UNSIGNED DEFAULT NULL,
  `AvgSize` int UNSIGNED DEFAULT NULL,
  `AvgColor` varchar(64) DEFAULT NULL,
  `AvgSpd` int UNSIGNED DEFAULT NULL,
  CONSTRAINT `FK_STATISTICS_META_LOG_FILE` FOREIGN KEY (`META_LOG_FILE_ID`) REFERENCES `META_LOG_FILE` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
