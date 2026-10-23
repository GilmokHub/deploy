CREATE DATABASE IF NOT EXISTS demo_ticketing_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE demo_ticketing_db;

CREATE TABLE IF NOT EXISTS `users` (
  `created_at` datetime(6) NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `event` (
  `available_seats` int NOT NULL,
  `end_time` datetime(6) NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `start_time` datetime(6) NOT NULL,
  `total_seats` int NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `seat` (
  `price` decimal(38,2) NOT NULL,
  `event_id` bigint NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `version` bigint NOT NULL,
  `seat_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_seat_event` (`event_id`),
  CONSTRAINT `FK_seat_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `reservation` (
  `created_at` datetime(6) NOT NULL,
  `event_id` bigint NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `seat_id` bigint NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` bigint NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_reservation_event` (`event_id`),
  KEY `FK_reservation_seat` (`seat_id`),
  KEY `FK_reservation_user` (`user_id`),
  CONSTRAINT `FK_reservation_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`),
  CONSTRAINT `FK_reservation_seat` FOREIGN KEY (`seat_id`) REFERENCES `seat` (`id`),
  CONSTRAINT `FK_reservation_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `auth_sessions` (
  `created_at` datetime(6) NOT NULL,
  `expires_at` datetime(6) NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `refresh_token` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_auth_sessions_user` (`user_id`),
  CONSTRAINT `FK_auth_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
