CREATE DATABASE IF NOT EXISTS gilmok_platform_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gilmok_platform_db;

CREATE TABLE IF NOT EXISTS `ai_recommendations` (
  `applied` bit(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `policy_id` bigint NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `event_policies` (
  `active` bit(1) NOT NULL,
  `allow_count` int NOT NULL,
  `max_concurrent_users` int NOT NULL,
  `rate_limit_per_second` int NOT NULL,
  `session_ttl_seconds` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `event_id` bigint NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `updated_at` datetime(6) NOT NULL,
  `algorithm` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_event_id` (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `policy_histories` (
  `changed_at` datetime(6) NOT NULL,
  `event_id` bigint NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `new_policy` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `previous_policy` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `reason` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `request_logs` (
  `count` bigint NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `request_minute` datetime(6) NOT NULL,
  `method` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uri` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
