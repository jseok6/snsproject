CREATE DATABASE `sns`

-- sns.address definition

CREATE TABLE `address` (
  `zipcode` int NOT NULL,
  `area` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.chat definition

CREATE TABLE `chat` (
  `roomId` int NOT NULL,
  `chatID` int NOT NULL,
  `chatName` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `chatContent` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `chatTime` datetime DEFAULT NULL,
  PRIMARY KEY (`roomId`,`chatID`) USING BTREE,
  CONSTRAINT `chat_ibfk_1` FOREIGN KEY (`roomId`) REFERENCES `chatroom` (`roomId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.chatroom definition

CREATE TABLE `chatroom` (
  `roomId` int NOT NULL,
  `userEmail` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `createTime` datetime NOT NULL,
  `lastCheck` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`roomId`,`userEmail`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.comment definition

CREATE TABLE `comment` (
  `commentId` int NOT NULL AUTO_INCREMENT,
  `postId` int NOT NULL,
  `userEmail` varchar(80) NOT NULL,
  `commentDetail` varchar(200) NOT NULL,
  `commentParrent` smallint DEFAULT NULL,
  `commentChild` smallint NOT NULL,
  `commentDate` datetime NOT NULL,
  `commentCorrect` datetime DEFAULT NULL,
  PRIMARY KEY (`commentId`),
  KEY `postId` (`postId`),
  KEY `userEmail` (`userEmail`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `post` (`postId`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`userEmail`) REFERENCES `userinfo` (`userEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.follow definition

CREATE TABLE `follow` (
  `userEmail` varchar(80) NOT NULL,
  `followNumber` int NOT NULL,
  PRIMARY KEY (`userEmail`),
  CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`userEmail`) REFERENCES `userinfo` (`userEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.friendmanager definition

CREATE TABLE `friendmanager` (
  `idx` int NOT NULL AUTO_INCREMENT,
  `userEmail` varchar(80) NOT NULL,
  `friendEmail` varchar(80) NOT NULL,
  `friendSign` int NOT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.guestbook definition

CREATE TABLE `guestbook` (
  `userEmail` varchar(80) NOT NULL,
  `gbComment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '',
  `gbBackGroundImage` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`userEmail`),
  CONSTRAINT `guestbook_ibfk_1` FOREIGN KEY (`userEmail`) REFERENCES `userinfo` (`userEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.manager definition

CREATE TABLE `manager` (
  `mgEmail` varchar(80) NOT NULL,
  `pwd` varchar(60) NOT NULL,
  PRIMARY KEY (`mgEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.post definition

CREATE TABLE `post` (
  `postId` int NOT NULL AUTO_INCREMENT,
  `userEmail` varchar(80) NOT NULL,
  `likeNum` int NOT NULL,
  `imageName` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `videoName` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `shareNum` int NOT NULL,
  `commentNum` int NOT NULL,
  `creationDate` date DEFAULT NULL,
  `postReport` int DEFAULT NULL,
  PRIMARY KEY (`postId`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.postimage definition

CREATE TABLE `postimage` (
  `imageId` int NOT NULL AUTO_INCREMENT,
  `userEmail` varchar(80) NOT NULL,
  `imageName` varchar(500) DEFAULT NULL,
  `videoName` varchar(500) DEFAULT NULL,
  `imageSize` int DEFAULT NULL,
  `videoSize` int DEFAULT NULL,
  PRIMARY KEY (`imageId`),
  KEY `userEmail` (`userEmail`),
  CONSTRAINT `postimage_ibfk_1` FOREIGN KEY (`userEmail`) REFERENCES `userinfo` (`userEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.postlike definition

CREATE TABLE `postlike` (
  `postId` int NOT NULL AUTO_INCREMENT,
  `userEmail` varchar(80) NOT NULL,
  `likeNum` int NOT NULL,
  PRIMARY KEY (`postId`),
  CONSTRAINT `postlike_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `post` (`postId`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.postshare definition

CREATE TABLE `postshare` (
  `postId` int NOT NULL AUTO_INCREMENT,
  `userEmail` varchar(80) NOT NULL,
  `shareNum` int NOT NULL,
  PRIMARY KEY (`postId`),
  KEY `userEmail` (`userEmail`),
  CONSTRAINT `postshare_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `post` (`postId`),
  CONSTRAINT `postshare_ibfk_2` FOREIGN KEY (`userEmail`) REFERENCES `userinfo` (`userEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.sms definition

CREATE TABLE `sms` (
  `userPN` varchar(50) DEFAULT NULL,
  `content` varchar(100) DEFAULT NULL,
  `userRegTime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.tblfileload definition

CREATE TABLE `tblfileload` (
  `num` int NOT NULL AUTO_INCREMENT,
  `upFile` char(50) NOT NULL,
  `size` int DEFAULT '0',
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=euckr;

-- sns.postlike definition

CREATE TABLE `postlike` (
  `postId` int NOT NULL AUTO_INCREMENT,
  `userEmail` varchar(80) NOT NULL,
  `likeNum` int NOT NULL,
  PRIMARY KEY (`postId`),
  CONSTRAINT `postlike_ibfk_1` FOREIGN KEY (`postId`) REFERENCES `post` (`postId`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- sns.userinfo definition

CREATE TABLE `userinfo` (
  `userName` varchar(20) NOT NULL,
  `userGender` varchar(20) NOT NULL,
  `userNickName` varchar(100) NOT NULL,
  `userEmail` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `userPwd` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `userPN` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `userSchool` varchar(50) DEFAULT NULL,
  `userAddress` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `userSocial` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `userSocialId` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `emailHash` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `emailcertification` int DEFAULT NULL,
  `userImage` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `userRegDate` date NOT NULL,
  `userAd` int NOT NULL,
  `userRegTime` datetime NOT NULL,
  `userInfoType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`userNickName`,`userPN`) USING BTREE,
  UNIQUE KEY `userEmail` (`userEmail`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;