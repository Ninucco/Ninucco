-- MariaDB dump 10.19  Distrib 10.11.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: ninucco
-- ------------------------------------------------------
-- Server version	10.11.2-MariaDB-1:10.11.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `battle`
--

DROP TABLE IF EXISTS `battle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `battle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `applicant_odds` double DEFAULT NULL,
  `applicant_url` varchar(255) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `finish_at` datetime(6) DEFAULT NULL,
  `opponent_odds` double DEFAULT NULL,
  `opponent_url` varchar(255) DEFAULT NULL,
  `result` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `applicant_id` varchar(40) DEFAULT NULL,
  `opponent_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3wik3s6lys6kvqrffgw6pk2m9` (`applicant_id`),
  KEY `FKnyvykedb24gsuxne9lqufsg1f` (`opponent_id`),
  CONSTRAINT `FK3wik3s6lys6kvqrffgw6pk2m9` FOREIGN KEY (`applicant_id`) REFERENCES `member` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKnyvykedb24gsuxne9lqufsg1f` FOREIGN KEY (`opponent_id`) REFERENCES `member` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `battle`
--

LOCK TABLES `battle` WRITE;
/*!40000 ALTER TABLE `battle` DISABLE KEYS */;
INSERT INTO `battle` VALUES
(1,2,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/abd0784d-c30f-3845-a5d7-bdbd99ed2df1.png','2023-05-17 05:46:27.000000','2023-05-18 00:00:00.000000',2,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/76c172c5-138f-30d9-b4fd-9ea3ec661b3b.png','DRAW','TERMINATED','누가 더 빨리 부자가 될 것 같나요?','2023-05-17 14:54:41.000000','ksqkfRjYhUUFKPaFc0e5e9wICMC3','BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(2,2,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/6c2e3a78-e9f2-3027-a685-1eb582fba9ec.png','2023-05-17 05:48:25.000000','2023-05-18 00:00:00.000000',2,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/6d9ed778-4562-3789-ab16-5542afc463ed.png','DRAW','TERMINATED','기부를 더 잘할 것 같은 사람은?','2023-05-17 14:55:01.000000','ksqkfRjYhUUFKPaFc0e5e9wICMC3','BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(3,2,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/c79f5f2e-27a8-301c-9e55-1909e1b25937.png','2023-05-17 05:57:12.000000','2023-05-18 00:00:00.000000',2,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/c15df171-b385-3f0b-9c98-1c3f113f7756.png','OPPONENT','TERMINATED','술 잘 마실 것 같은 사람은?','2023-05-17 15:00:05.000000','ksqkfRjYhUUFKPaFc0e5e9wICMC3','BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(4,2,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/7ee5a8e8-dab9-3975-b39d-d96dc5fc423b.png','2023-05-17 05:57:18.000000','2023-05-18 00:00:00.000000',2,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/de7bf588-2673-3cd1-98ea-b66dfd2803a0.png','OPPONENT','TERMINATED','둘 중 공부를 더 잘할 것처럼 생긴 사람은?','2023-05-17 14:57:36.000000','BMvfDMpS90Y3SIY6mYzdg2Urt8u2','ksqkfRjYhUUFKPaFc0e5e9wICMC3'),
(7,2.0549558390579,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/07a04fd7-b638-3e2b-805e-074534918118.png','2023-05-18 04:11:34.000000','2023-05-19 23:59:00.000000',1.9450441609421,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/39323137-c4db-3f04-a3a7-d7dce430d64d.png','PROCEEDING','PROCEEDING','누가 더 프론트 개발자처럼 생겼나요?','2023-05-18 13:12:16.000000','ksqkfRjYhUUFKPaFc0e5e9wICMC3','BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(8,1.9450441609421,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/1302aca3-7b35-368f-ba3c-d1ff2bf481b4.png','2023-05-18 05:28:04.000000','2023-05-19 23:59:00.000000',2.0549558390579,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/37dd9598-fa09-3421-a7ef-d7ebae4c900d.png','PROCEEDING','PROCEEDING','요리를 더 잘할 것 같은 사람은?','2023-05-18 14:48:52.000000','BMvfDMpS90Y3SIY6mYzdg2Urt8u2','ksqkfRjYhUUFKPaFc0e5e9wICMC3'),
(9,2,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/07a04fd7-b638-3e2b-805e-074534918118.png','2023-05-18 12:54:32.000000','2023-05-19 23:59:00.000000',2,'https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/813d2464-23eb-3aa3-a7d9-e234bbd37e05.png','PROCEEDING','PROCEEDING','누가 더 프론트 개발자처럼 생겼나요?','2023-05-18 21:54:53.000000','MvISt9aL5ma9bXrJp8I3zR9wfSZ2','93hkaLzA9YPKCNOTlC2m2KY8hzy2');
/*!40000 ALTER TABLE `battle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `betting`
--

DROP TABLE IF EXISTS `betting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `betting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bet_money` bigint(20) NOT NULL,
  `bet_side` varchar(255) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `battle_id` bigint(20) DEFAULT NULL,
  `member_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKigogr06jntqmh8cxy13yonrog` (`battle_id`),
  KEY `FK1gu5ayiqlbb082djcehw58vf2` (`member_id`),
  CONSTRAINT `FK1gu5ayiqlbb082djcehw58vf2` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `FKigogr06jntqmh8cxy13yonrog` FOREIGN KEY (`battle_id`) REFERENCES `battle` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `betting`
--

LOCK TABLES `betting` WRITE;
/*!40000 ALTER TABLE `betting` DISABLE KEYS */;
INSERT INTO `betting` VALUES
(3,50,'APPLICANT','2023-05-18 06:12:27.000000',8,'0RvWgOQCgqO9JIElGL6PttBIgys1'),
(4,100,'APPLICANT','2023-05-18 06:12:30.000000',8,'EiY9VAMzjyPCfYqefNyu1jscSub2'),
(5,1,'APPLICANT','2023-05-18 07:00:25.000000',7,'EiY9VAMzjyPCfYqefNyu1jscSub2'),
(6,500,'OPPONENT','2023-05-18 07:21:40.000000',8,'ByykHMLYckX7LjG7VzuECWsfF3f2'),
(7,1,'APPLICANT','2023-05-18 07:58:26.000000',8,'93hkaLzA9YPKCNOTlC2m2KY8hzy2'),
(8,123,'APPLICANT','2023-05-18 08:02:12.000000',8,'BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(9,2,'APPLICANT','2023-05-18 08:08:51.000000',8,'fuNwN4GVwCYiwryoLJeq6DOmofq1'),
(10,5000,'APPLICANT','2023-05-18 08:11:30.000000',7,'ByykHMLYckX7LjG7VzuECWsfF3f2'),
(11,1000,'APPLICANT','2023-05-18 08:35:01.000000',7,'Zb7UMFfW3JcAiN4HzjiE1TzcYkq1'),
(12,100,'APPLICANT','2023-05-18 08:38:29.000000',8,'ksqkfRjYhUUFKPaFc0e5e9wICMC3'),
(13,50,'APPLICANT','2023-05-18 08:40:52.000000',7,'ksqkfRjYhUUFKPaFc0e5e9wICMC3'),
(14,320,'APPLICANT','2023-05-18 12:30:57.000000',8,'IG6OqYMDXkXRMq0vSounihrNNw13'),
(15,30,'OPPONENT','2023-05-18 12:32:33.000000',7,'IG6OqYMDXkXRMq0vSounihrNNw13'),
(16,900,'OPPONENT','2023-05-18 12:46:57.000000',8,'MvISt9aL5ma9bXrJp8I3zR9wfSZ2');
/*!40000 ALTER TABLE `betting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `content` varchar(200) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `battle_id` bigint(20) NOT NULL,
  `member_id` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK15i2svrgrfrdq80nb09xs0abi` (`battle_id`),
  KEY `FKmrrrpi513ssu63i2783jyiv9m` (`member_id`),
  CONSTRAINT `FK15i2svrgrfrdq80nb09xs0abi` FOREIGN KEY (`battle_id`) REFERENCES `battle` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKmrrrpi513ssu63i2783jyiv9m` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES
(1,'hi~','2023-05-17 06:00:45.000000',3,'BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(2,'넹','2023-05-17 06:20:27.000000',3,'ksqkfRjYhUUFKPaFc0e5e9wICMC3'),
(3,'하이','2023-05-17 06:23:30.000000',3,'ksqkfRjYhUUFKPaFc0e5e9wICMC3'),
(5,'하이하이','2023-05-18 03:38:27.000000',3,'3UXGE8EAAidH16Szug1J2AY0nMf2'),
(6,'hihi','2023-05-18 04:13:55.000000',7,'BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(7,'gogo!!','2023-05-18 04:47:13.000000',7,'BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(10,'go get it~!!!','2023-05-18 04:49:04.000000',7,'BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(11,'hmm','2023-05-18 05:25:31.000000',7,'BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(12,'거북이는 인정이지','2023-05-18 07:21:35.000000',8,'ByykHMLYckX7LjG7VzuECWsfF3f2'),
(13,'배고파... ㅠ','2023-05-18 07:27:48.000000',8,'JYGDFjHqFvNfGAkYi7OroFHnhBV2'),
(14,'정배야 잘먹을게 ','2023-05-18 08:11:23.000000',7,'ByykHMLYckX7LjG7VzuECWsfF3f2'),
(15,'거북이님이 더 하훈목님처럼 생겼으므로 저는 전자에 배팅하겠습니다 ^^','2023-05-18 08:19:36.000000',7,'laB0F69Hv1cVytgnWWWvJClo46y2'),
(16,'댓글','2023-05-18 08:21:31.000000',7,'laB0F69Hv1cVytgnWWWvJClo46y2'),
(17,'빠나나~','2023-05-18 08:35:18.000000',7,'Zb7UMFfW3JcAiN4HzjiE1TzcYkq1'),
(18,'무조건 거북이지','2023-05-18 12:47:08.000000',8,'MvISt9aL5ma9bXrJp8I3zR9wfSZ2'),
(19,'힝','2023-05-18 12:55:40.000000',9,'MvISt9aL5ma9bXrJp8I3zR9wfSZ2');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(200) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  `url` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member` (
  `id` varchar(40) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `elo` int(11) NOT NULL DEFAULT 1000,
  `lose_count` int(11) NOT NULL DEFAULT 0,
  `nickname` varchar(255) NOT NULL,
  `point` bigint(20) NOT NULL DEFAULT 0,
  `updated_at` datetime(6) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `win_count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_hh9kg6jti4n1eoiertn2k6qsc` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES
('0RvWgOQCgqO9JIElGL6PttBIgys1','2023-05-18 06:09:32.000000',1000,0,'살벌하게 뛰어노는 토끼 14',950,'2023-05-18 06:12:27.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_2.png',0),
('3UXGE8EAAidH16Szug1J2AY0nMf2','2023-05-17 07:26:54.000000',1000,0,'놀랍게 주체하는 앵무새 7',1000,'2023-05-17 07:30:09.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/b9011164-0070-3b1e-bffe-e5bc26fbf3c4.png',0),
('6OD8R1LkueXCXEYfJyWhY6xc8EU2','2023-05-18 03:37:32.000000',1000,0,'열심히 탐구하는 하마 10',1000,'2023-05-18 03:37:32.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_1.png',0),
('7hbs6UGOS6azn9hrUSd5vbWiqLm1','2023-05-17 05:37:21.000000',962,0,'어디서나 아쉬워한 해마 3',8000,'2023-05-17 15:15:00.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_2.png',0),
('93hkaLzA9YPKCNOTlC2m2KY8hzy2','2023-05-18 05:27:41.000000',1000,0,'급히 도와주는 펭귄 11',649,'2023-05-18 22:06:57.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_3.png',0),
('9Vbo44RixVUsmaOEsdqA3hX7Ll83','2023-05-18 08:41:04.000000',1000,0,'어느새 살펴보는 낙타 28',850,'2023-05-18 08:42:43.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_3.png',0),
('bI6UMVXNhzZihdbVDRq6wBykW1H3','2023-05-17 22:13:14.000000',1000,0,'너그럽게 달리는 갈매기 8',1000,'2023-05-17 22:13:14.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_4.png',0),
('BMvfDMpS90Y3SIY6mYzdg2Urt8u2','2023-05-17 05:24:46.000000',1075,0,'각별히 빛나는 독수리 2',28873,'2023-05-18 08:02:12.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/49ed8ed6-e9db-3adf-97ea-d932ad5dee75.png',0),
('ByykHMLYckX7LjG7VzuECWsfF3f2','2023-05-18 07:18:10.000000',1000,0,'사랑으로 뛰어노는 바다거북 19',93849,'2023-05-18 12:27:56.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_0.png',0),
('CdSOMjoizPVSFXLVxszvejgad2t2','2023-05-18 07:19:56.000000',1000,0,'아득히 보여주는 낙타 20',1000,'2023-05-18 07:19:56.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_1.png',0),
('CY51FMBSpsWBEu8YbuyClv9zq8F2','2023-05-18 07:21:29.000000',1000,0,'마구 올려놓는 악어 22',900,'2023-05-18 07:26:21.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_6.png',0),
('dtuuvQDxA9O06AdzaWKsuyBAs5A2','2023-05-18 07:33:26.000000',1000,0,'광폭하게 떠오르는 토끼 24',1000,'2023-05-18 07:33:26.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_2.png',0),
('E5UgvTldfrfG3HyJCFgOoPF5LjA3','2023-05-18 05:44:05.000000',1000,0,'계속해서 살아있는 햄스터 12',1000,'2023-05-18 05:44:05.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_0.png',0),
('EePujnlZ1gfwymSPNvUVqjxlzku2','2023-05-18 08:47:48.000000',1000,0,'광폭하게 추천하는 바다거북 29',850,'2023-05-18 08:54:17.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_1.png',0),
('eg95A6zlFzgO8j93BJ7K6bFDD5N2','2023-05-18 07:20:17.000000',1000,0,'빠르게 당기는 펭귄 21',850,'2023-05-18 07:28:26.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_7.png',0),
('EiY9VAMzjyPCfYqefNyu1jscSub2','2023-05-18 06:09:50.000000',1000,0,'둥글둥글 사라지는 다람쥐 15',799,'2023-05-18 07:00:25.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_7.png',0),
('fuNwN4GVwCYiwryoLJeq6DOmofq1','2023-05-18 08:06:15.000000',1000,0,'내심술술 매일하는 캥거루 26',2000,'2023-05-18 08:08:51.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_5.png',0),
('gNkwPfVtUqhyDDNeLBtbCrtTf0d2','2023-05-18 22:31:49.000000',1000,0,'부드럽게 기대는 앵무새 34',700,'2023-05-18 22:47:39.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_1.png',0),
('IG6OqYMDXkXRMq0vSounihrNNw13','2023-05-18 12:24:15.000000',1000,0,'시끄럽게 요청하는 다람쥐 31',600,'2023-05-18 12:32:33.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_4.png',0),
('IgdgzFbKyacdhGQcuylmz98gBU23','2023-05-18 22:08:55.000000',1000,0,'따로 살펴보는 하이에나 33',700,'2023-05-18 22:30:30.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_4.png',0),
('JYGDFjHqFvNfGAkYi7OroFHnhBV2','2023-05-17 07:00:13.000000',1000,0,'영롱한 진주같은 김싸피 1',900,'2023-05-18 07:44:19.146835','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_3.png',0),
('KePpvWaO7hUr0XWfpzdRpvitCJn1','2023-05-18 22:07:29.000000',1000,0,'내심술술 도와주는 고양이 32',950,'2023-05-18 22:07:42.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_5.png',0),
('ksqkfRjYhUUFKPaFc0e5e9wICMC3','2023-05-17 05:19:32.000000',963,0,'똑바로 보여주는 거북이 0',3850,'2023-05-18 08:40:52.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/117a3946-7a18-3080-b9b6-46e3dad32f5a.png',0),
('laB0F69Hv1cVytgnWWWvJClo46y2','2023-05-18 00:39:17.000000',1000,0,'이홍주',4000,'2023-05-18 08:40:41.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/50eafcb2-eb03-30e4-a0f6-8db50f8547a8.png',0),
('mOQEgK6HXJUinHldGSLMkZc4VGO2','2023-05-18 06:35:34.000000',1000,0,'만만하게 매일하는 강아지 16',950,'2023-05-18 06:40:36.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_7.png',0),
('MvISt9aL5ma9bXrJp8I3zR9wfSZ2','2023-05-17 07:26:09.000000',1000,0,'심술궂게 주체하는 미어캣 5',0,'2023-05-18 12:46:57.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_5.png',0),
('nGYmfdp7lDPAs1cVNWGhnMGDgiY2','2023-05-17 05:21:19.000000',1000,0,'둥글둥글 선사하는 하마 1',1000,'2023-05-17 05:21:19.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_girl.png',0),
('pW6ESvGlisbaRsDBi4TW1WX3kwk1','2023-05-18 07:14:40.000000',1000,0,'너그럽게 선사하는 치타 17',1000,'2023-05-18 07:14:40.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_3.png',0),
('soCofB3YNvSXKJQ98nJnpIaGFXz2','2023-05-17 07:26:44.000000',1000,0,'취한듯이 울리는 고양이 6',1000,'2023-05-17 07:26:44.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_2.png',0),
('sYh5mgS5HmPDlqIggJC0aNzz80G2','2023-05-18 07:49:07.662742',1000,0,'변함없이 자세한 북극곰 25',1000,'2023-05-18 07:49:07.662742','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_1.png',0),
('tKiOsa3F3XYM5Nr4fDxkMLWFrlg2','2023-05-18 07:25:14.000000',1000,0,'시끄럽게 채워지는 벌새 23',2000,'2023-05-18 07:43:46.263222','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_3.png',0),
('U30f9MVc2pWf1WQh1mRTppsPQ5E2','2023-05-18 08:51:49.000000',1000,0,'오래 조언하는 독수리 30',1000,'2023-05-18 08:51:49.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_6.png',0),
('Y1AR3yylknOESDBj2DYvuM2GIDI2','2023-05-18 07:17:56.000000',1000,0,'생각보다 청소하는 햄스터 18',1000,'2023-05-18 07:17:56.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_1.png',0),
('YYXQiGLHZiYp0BLFG3V3FN4zguc2','2023-05-18 06:09:25.000000',1000,0,'비슷하게 언급하는 하이에나 13',950,'2023-05-18 06:09:48.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_5.png',0),
('Zb7UMFfW3JcAiN4HzjiE1TzcYkq1','2023-05-18 08:34:34.000000',1000,0,'반갑게 빛나는 사막여우 27',8700,'2023-05-18 13:04:16.000000','https://ninucco-bucket.s3.ap-northeast-2.amazonaws.com/static/default_3.png',0);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_friend`
--

DROP TABLE IF EXISTS `member_friend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_friend` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` int(11) NOT NULL,
  `friend_id` varchar(40) DEFAULT NULL,
  `member_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKn4p2ijfec40mkng8wuhdbq6q5` (`friend_id`),
  KEY `FKk3wij0sds2e2f3730b6wfphxq` (`member_id`),
  CONSTRAINT `FKk3wij0sds2e2f3730b6wfphxq` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `FKn4p2ijfec40mkng8wuhdbq6q5` FOREIGN KEY (`friend_id`) REFERENCES `member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_friend`
--

LOCK TABLES `member_friend` WRITE;
/*!40000 ALTER TABLE `member_friend` DISABLE KEYS */;
INSERT INTO `member_friend` VALUES
(1,2,'BMvfDMpS90Y3SIY6mYzdg2Urt8u2','ksqkfRjYhUUFKPaFc0e5e9wICMC3'),
(2,2,'ksqkfRjYhUUFKPaFc0e5e9wICMC3','BMvfDMpS90Y3SIY6mYzdg2Urt8u2'),
(3,1,'nGYmfdp7lDPAs1cVNWGhnMGDgiY2','ksqkfRjYhUUFKPaFc0e5e9wICMC3'),
(4,1,'6OD8R1LkueXCXEYfJyWhY6xc8EU2','ksqkfRjYhUUFKPaFc0e5e9wICMC3'),
(5,1,'JYGDFjHqFvNfGAkYi7OroFHnhBV2','ksqkfRjYhUUFKPaFc0e5e9wICMC3'),
(6,2,'YYXQiGLHZiYp0BLFG3V3FN4zguc2','EiY9VAMzjyPCfYqefNyu1jscSub2'),
(7,2,'YYXQiGLHZiYp0BLFG3V3FN4zguc2','0RvWgOQCgqO9JIElGL6PttBIgys1'),
(8,2,'0RvWgOQCgqO9JIElGL6PttBIgys1','YYXQiGLHZiYp0BLFG3V3FN4zguc2'),
(9,2,'EiY9VAMzjyPCfYqefNyu1jscSub2','YYXQiGLHZiYp0BLFG3V3FN4zguc2'),
(10,2,'ByykHMLYckX7LjG7VzuECWsfF3f2','laB0F69Hv1cVytgnWWWvJClo46y2'),
(11,2,'laB0F69Hv1cVytgnWWWvJClo46y2','ByykHMLYckX7LjG7VzuECWsfF3f2'),
(12,1,'laB0F69Hv1cVytgnWWWvJClo46y2','93hkaLzA9YPKCNOTlC2m2KY8hzy2'),
(13,2,'IG6OqYMDXkXRMq0vSounihrNNw13','93hkaLzA9YPKCNOTlC2m2KY8hzy2'),
(14,2,'93hkaLzA9YPKCNOTlC2m2KY8hzy2','IG6OqYMDXkXRMq0vSounihrNNw13'),
(15,1,'ksqkfRjYhUUFKPaFc0e5e9wICMC3','MvISt9aL5ma9bXrJp8I3zR9wfSZ2'),
(16,1,'MvISt9aL5ma9bXrJp8I3zR9wfSZ2','93hkaLzA9YPKCNOTlC2m2KY8hzy2'),
(17,1,'MvISt9aL5ma9bXrJp8I3zR9wfSZ2','ByykHMLYckX7LjG7VzuECWsfF3f2'),
(18,1,'CY51FMBSpsWBEu8YbuyClv9zq8F2','MvISt9aL5ma9bXrJp8I3zR9wfSZ2');
/*!40000 ALTER TABLE `member_friend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_item`
--

DROP TABLE IF EXISTS `member_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` bigint(20) NOT NULL,
  `item_id` bigint(20) DEFAULT NULL,
  `member_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9enqbn035alkkr61q5t5soq19` (`item_id`),
  KEY `FK6ohv34vf9kikd89qigs1k3bko` (`member_id`),
  CONSTRAINT `FK6ohv34vf9kikd89qigs1k3bko` FOREIGN KEY (`member_id`) REFERENCES `member` (`id`),
  CONSTRAINT `FK9enqbn035alkkr61q5t5soq19` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_item`
--

LOCK TABLES `member_item` WRITE;
/*!40000 ALTER TABLE `member_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-19  0:17:37
