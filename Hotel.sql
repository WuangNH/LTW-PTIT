-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hotel
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` bigint NOT NULL,
  `active` bit(1) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `roles` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7m8ru44m93ukyb61dfxw0apf6` (`user_id`),
  CONSTRAINT `FK7m8ru44m93ukyb61dfxw0apf6` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,_binary '','2023-11-21 22:38:40.845000','123456','ROLE_MANAGER','huyquang110@gmail.com',1),(2,_binary '','2023-11-21 22:38:49.573000','123456','ROLE_USER','huyquang880@gmail.com',1),(3,_binary '','2023-11-22 11:39:07.587000','123456','ROLE_ADMIN','huyquang000@gmail.com',2);
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `checkin` varchar(255) DEFAULT NULL,
  `checkout` varchar(255) DEFAULT NULL,
  `is_cancelled` bit(1) NOT NULL,
  `is_paid` bit(1) NOT NULL,
  `is_receive` bit(1) NOT NULL,
  `note` varchar(255) DEFAULT NULL,
  `total_price` bigint DEFAULT NULL,
  `client_id` bigint DEFAULT NULL,
  `room_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhs7eej4m2orrmr5cfbcrqs8yw` (`client_id`),
  KEY `FKq83pan5xy2a6rn0qsl9bckqai` (`room_id`),
  CONSTRAINT `FKhs7eej4m2orrmr5cfbcrqs8yw` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
  CONSTRAINT `FKq83pan5xy2a6rn0qsl9bckqai` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (56,'2023-12-29','2024-01-06',_binary '\0',_binary '',_binary '','',88,1,4),(57,'2023-12-29','2024-01-06',_binary '\0',_binary '',_binary '','',888,1,8),(58,'2023-12-29','2023-12-31',_binary '\0',_binary '',_binary '','',22,1,4);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `bank_account` varchar(255) DEFAULT NULL,
  `client_note` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKk1fi84oi1yyuswr40h38kjy1s` (`user_id`),
  CONSTRAINT `FKk1fi84oi1yyuswr40h38kjy1s` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'Nghệ An','123','2321','huyquang880@gmail.com','G46-23-Nguyễn Huy Quang','','0965555555',1),(2,'Làng Nhùng, Tam Quang, Tương Dương, Nghệ An','0548394','92348','nguyenhuyquang880@gmail.com','Nguyễn Huy Quang','12','21',2);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hibernate_sequence`
--

DROP TABLE IF EXISTS `hibernate_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hibernate_sequence` (
  `next_val` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hibernate_sequence`
--

LOCK TABLES `hibernate_sequence` WRITE;
/*!40000 ALTER TABLE `hibernate_sequence` DISABLE KEYS */;
INSERT INTO `hibernate_sequence` VALUES (4);
/*!40000 ALTER TABLE `hibernate_sequence` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `floor` bigint DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` bigint DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (4,'Phòng có view đẹp nhưng giá cả phải chăng',1,'https://scarpa-us.com/wp-content/uploads/2020/02/nha-nghi-vung-tau-gia-binh-dan.jpg','Phòng 101T',11,'Trống','Thường'),(5,'Phòng có view đẹp nhưng giá cả phải chăng, đồ nội thật có chút năng cấp',1,'https://khachsanodalat.com/wp-content/uploads/2021/04/gia-nha-nghi-binh-dan-1.jpg','Phòng 102T',12,'Trống','Thường'),(6,'Phòng có view đẹp nhưng giá cả phải chăng, đồ nội thật có chút năng cấp hơn',1,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdQjbyyetJJCgrzC12dU5gDclgGvc-rSBeuwFmfkVsgad-xI0RQI7lrthkWPHfU-p3qJk&usqp=CAU','Phòng 103T',13,'Trống','Thường'),(7,'Phòng có view đẹp nhưng giá cả phải chăng, đồ nội thật có chút năng cấp hơn',1,'https://nhanghivietdung.com/wp-content/uploads/2019/05/54727400_10157078001916649_5375169025691090944_n.jpg','Phòng 104T',14,'Trống','Thường'),(8,'Phòng cao cấp có view đẹp, nội thất đầy đủ tiện nghi',1,'https://lh5.googleusercontent.com/RlJON_-16LWnbrM9brECoCGlH5nrTANv83ctVGcFNF1ataFuLGwQe9z73_kgX-QWRP2wjHIe4SnKy2QykPqqDQXSc_m8IxEBE_cdJZWYsDBkHzVCbVrGKbJHNWQb-Oy5qOAxWra8','Phòng 101V',111,'Trống','VIP'),(9,'Phòng cao cấp có view đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng',1,'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/24/e5/03/presidensial-suite--v15614830.jpg?w=700&h=-1&s=1','Phòng 102V',112,'Trống','VIP'),(10,'Phòng cao cấp có view đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng',1,'https://i.pinimg.com/736x/e4/39/a6/e439a647d4bd903cce3857ecb660bdc0--ice-hotel-luxurious-bedrooms.jpg','Phòng 103V',113,'Trống','VIP'),(11,'Phòng cao cấp có view đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng',1,'https://3dzip.org/wp-content/uploads/2020/05/3D-Interior-Scenes-File-3dsmax-Model-Hotel-Room-by-LamDao-2.jpg','Phòng 104V',114,'Trống','VIP'),(12,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả người đi làm xa, và ở tầng 2',2,'https://nhanghivietdung.com/wp-content/uploads/2018/06/phong-to-view-ho.jpg','Phòng 201T',11,'Trống','Thường'),(13,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả người đi làm xa, và ở tầng 2, nội thất hơi cũ kỹ',2,'https://pimg.fabhotels.com/propertyimages/873/images/photos-fabexpress-gold-inn-chandigarh-Hotels_1669443046871.jpg','Phòng 202T',12,'Trống','Thường'),(14,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả người đi làm xa, và ở tầng 2, nội thất hơi cũ kỹ',2,'https://th.bing.com/th/id/R.9bced423b9eff0b1dcba18b1d5d847e1?rik=yfSsEJ1x7UETqg&riu=http%3a%2f%2fsanandaahall.com%2fimages%2f0002.jpg&ehk=BPG4V3%2f8NmDQ7YL3DwJfZhasVJAWgYgKNshOhDI%2bPbE%3d&risl=&pid=ImgRaw&r=0','Phòng 203T',13,'Trống','Thường'),(15,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả người đi làm xa, và ở tầng 2, nội thất hơi cũ kỹ',2,'https://th.bing.com/th/id/OIP.v_agY-aq8gerDvv2vr7XbAHaE8?rs=1&pid=ImgDetMain','Phòng 204T',14,'Trống','Thường'),(16,'Phòng cao cấp có vieu đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, và ở tầng 2',2,'https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2018/01/phong-nghi-cao-cap-tai-Salinda-Phu-Quoc.png','Phòng 201V',111,'Trống','VIP'),(17,'Phòng cao cấp có vieu đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, và ở tầng 2',2,'https://noithatlongthanh.vn/upload1/images/mau-phong-ngu-cao-cap-voi-tran-go-dep.jpg','Phòng 202V',112,'Trống','VIP'),(18,'Phòng cao cấp có vieu đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, và ở tầng 2, hơi sa hoa',2,'https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2017/11/muong-thanh-luxury-moc-chau.jpg','Phòng 203V',113,'Trống','VIP'),(19,'Phòng cao cấp có vieu đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, và ở tầng 2, hơi sa hoa',2,'https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2020/03/khach-san-intercntinental-da-nang-9.jpg','Phòng 204V',114,'Trống','VIP'),(20,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả, cho những người thích ở trên cao hóng mát',3,'https://th.bing.com/th/id/OIP.bOqAJ0uw7iPtXJSdITRNKgHaE-?rs=1&pid=ImgDetMain','Phòng 301T',11,'Trống','Thường'),(21,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả, cho những người thích ở trên cao hóng mát, nội thất hơi cũ kỹ',3,'https://static.wixstatic.com/media/f6f5f8_40573fb4af1f4aab9264ff4518031f67~mv2.jpeg/v1/fill/w_506,h_337,al_c,q_80,usm_0.66_1.00_0.01,enc_auto/Deluxe-room-e1614884043500.jpeg','Phòng 302T',12,'Trống','Thường'),(22,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả, cho những người thích ở trên cao hóng mát, nội thất hơi cũ kỹ',3,'https://th.bing.com/th/id/OIP.kp_4f8A6qYdeZdioctPrSAEyDM?rs=1&pid=ImgDetMain','Phòng 303T',13,'Trống','Thường'),(23,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả, cho những người thích ở trên cao hóng mát, nội thất hơi cũ kỹ',3,'https://th.bing.com/th/id/OIP.aBvHvvQNNH1tRGIE82h6RgHaFe?w=1000&h=740&rs=1&pid=ImgDetMain','Phòng 304T',14,'Trống','Thường'),(24,'Phòng cao cấp ở tầng 3 ở giữ ',3,'https://th.bing.com/th/id/R.740172318d5a64192d2be19c80eddbca?rik=Wqv06BLUFtRIog&riu=http%3a%2f%2fcdn.luxuo.com%2f2016%2f08%2fWynn-Palace-Macau-suite-600x400.jpg&ehk=kCLqYaN3lrT%2fU%2brkWZx1JdaU71a7StyN5Nu3uEvibXo%3d&risl=&pid=ImgRaw&r=0','Phòng 301V',114,'Trống','VIP'),(25,'Phòng cao cấp ở tầng 3 ở giữa, rất là đẹp',3,'https://www.raivatproperties.com/wp-content/uploads/2020/02/Kalpataru-yashodhan-8.jpg','Phòng 302V',112,'Trống','VIP'),(26,'Phòng cao cấp ở tầng 3 ở giữa, rất là đẹp, có âm hưởng Châu Âu',3,'https://i.dailymail.co.uk/i/pix/2015/03/27/14/270CA43D00000578-0-image-a-3_1427467596325.jpg','Phòng 303V',113,'Trống','VIP'),(27,'Phòng cao cấp ở tầng 3 ở giữa, rất là đẹp, có âm hưởng Phương Đông',3,'https://www.idesignarch.com/wp-content/uploads/Palazzo-Versace-Luxury-Penthouse-Dubai_19-768x512.jpg','Phòng 304V',114,'Trống','VIP'),(100,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả, cho những người thích ở trên cao hóng mát, nội thất hơi cũ kỹ, phòng ở tầng 4 là gần cao nhất',4,'https://cidadedediu.in/img/rooms/3_c.jpg','Phòng 401T',11,'Trống','Thường'),(101,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả, cho những người thích ở trên cao hóng mát, nội thất hơi cũ kỹ, phòng ở tầng 4 là gần cao nhất, được thiết kế dành cho mọi người thích ồn à',4,'https://th.bing.com/th/id/OIP.1wUhoS3W3yCgZrs07aeRnAAAAA?rs=1&pid=ImgDetMain','Phòng 402T',12,'Trống','Thường'),(102,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả, cho những người thích ở trên cao hóng mát, nội thất hơi cũ kỹ, phòng ở tầng 4 là gần cao nhất, được thiết kế dành cho mọi người thích ồn à, có hành làng rộng rãi',4,'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0a/b3/80/c0/sreemangal-inn.jpg?w=700&h=-1&s=1','Phòng 403T',13,'Trống','Thường'),(103,'Phòng bình dân giá rẻ dành cho những người có kinh tế khá giả, cho những người thích ở trên cao hóng mát, nội thất hơi cũ kỹ, phòng ở tầng 4 là gần cao nhất, được thiết kế dành cho mọi người thích ồn à, có hành làng rộng rãi',4,'https://th.bing.com/th/id/OIP.k4DS0wgbkiv0R9cJyE4qugHaE-?rs=1&pid=ImgDetMain','Phòng 404T',14,'Trống','Thường'),(104,'Phòng cao cấp có vieư đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, nhiều tiện ích, thoải mái rộng rã, màu mè',4,'https://th.bing.com/th/id/OIP.5POVCnEj7U1kOcrSpUS3UgHaEc?rs=1&pid=ImgDetMain','Phòng 401V',111,'Trống','VIP'),(105,'Phòng cao cấp có vieư đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, nhiều tiện ích, thoải mái rộng rã, màu mè',4,'https://statics.vntrip.vn/data-v2/data-guide/img_content/1461751628_khu-du-l%E1%BB%8Bch-song-ray-3.jpeg','Phòng 402V',112,'Trống','VIP'),(106,'Phòng cao cấp có vieư đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, nhiều tiện ích, thoải mái rộng rã, màu mè',4,'https://blogdulichblog.files.wordpress.com/2016/07/vinpearl-luxury-nha-trang-3.jpg','Phòng 403V',113,'Trống','VIP'),(107,'Phòng cao cấp có vieư đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, nhiều tiện ích, thoải mái rộng rã, màu mè',4,'https://i.pinimg.com/originals/40/ba/c4/40bac4279374b0bfafdfd2d79e372f79.jpg','Phòng 404V',114,'Trống','VIP'),(108,'Phòng cao cấp có vieư đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, nhiều tiện ích, thoải mái rộng rã, màu mè, ở cao nhất tiện nghi thoải mái',5,'https://th.bing.com/th/id/OIP.TzBsHXxjrtDg4bcKTSFQYQHaE8?rs=1&pid=ImgDetMain','Phòng 501V',111,'Trống','VIP'),(109,'Phòng cao cấp có vieư đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, nhiều tiện ích, thoải mái rộng rã, màu mè, ở cao nhất tiện nghi thoải mái',5,'https://image-tc.galaxy.tf/wijpeg-5a36t6b25cg3d6mfyexvi8ma9/odalar-king-suite-oda-712.jpg?width=1920','Phòng 502V',112,'Trống','VIP'),(110,'Phòng cao cấp có view đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, nhiều tiện ích, thoải mái rộng rã, màu mè, ở cao nhất tiện nghi thoải mái, bạn ở cao nhất tòa nhà',5,'https://www.alsaqergroup.com/wp-content/uploads/2018/10/3-NEW.png','Phòng 503V',113,'Trống','VIP'),(111,'Phòng cao cấp có view đẹp, nội thất đầy đủ tiện nghi, thêm rất là nhiều tính năng, nhiều tiện ích, thoải mái rộng rã, màu mè, ở cao nhất tiện nghi thoải mái, bạn ở cao nhất tòa nhà',5,'https://www.bollywoodshaadis.com/img-scale/640/article-201841099340334443000.jpeg','Phòng 504V',114,'Trống','VIP'),(112,'Phòng bình dân hơi cũ kỹ nhưng mà được cái ở tầng 5, bạn thích làm ồn thế nào cũng được',5,'https://images.oyoroomscdn.com/uploads/hotel_image/61270/large/8058e53a18977534.jpg','Phòng 501T',11,'Trống','Thường'),(113,'Phòng bình dân hơi cũ kỹ nhưng mà được cái ở tầng 5, bạn thích làm ồn thế nào cũng được, hơi đơn sơ',5,'https://th.bing.com/th/id/OIP.lqMeygv2b1Q0wcPP7nn2WwHaE8?rs=1&pid=ImgDetMain','Phòng 502T',12,'Trống','Thường'),(114,'Phòng bình dân hơi cũ kỹ nhưng mà được cái ở tầng 5, bạn thích làm ồn thế nào cũng được, hơi đơn sơ, ở tầng 5 có cửa sổ rất to',5,'https://t-ec.bstatic.com/images/hotel/max1024x768/144/144554703.jpg','Phòng 503T',13,'Trống','Thường'),(118,'Phòng cao cấp ở tầng 5 ở giữa, rất là đẹp, có âm hưởng Phương Đông',5,'https://rentkh.com/thumbnail/large/uploads/201908/12ffbae77e8188adeb4c4c354de629eb.jpg','Phòng 504T',14,'Trống','Thường');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `fullname` varchar(255) DEFAULT NULL,
  `id_card` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `registered_at` datetime(6) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Nghệ An','huyquang880@gmail.com','G46-23-Nguyễn Huy Quang','','','0965555555','2023-11-21 22:38:40.808000','Khách hàng'),(2,'Làng Nhùng, Tam Quang, Tương Dương, Nghệ An','nguyenhuyquang880@gmail.com','Nguyễn Huy Quang','12','Cho một cái bát tô','21','2023-11-22 11:39:07.560000','Khách hàng');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-30  1:37:06
