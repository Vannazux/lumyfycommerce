/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: bagisto
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-ubu2204

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
-- Table structure for table `admin_password_resets`
--

DROP TABLE IF EXISTS `admin_password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `admin_password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_password_resets`
--

LOCK TABLES `admin_password_resets` WRITE;
/*!40000 ALTER TABLE `admin_password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admins`
--

DROP TABLE IF EXISTS `admins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `admins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `api_token` varchar(80) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `role_id` int(10) unsigned NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`),
  UNIQUE KEY `admins_api_token_unique` (`api_token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admins`
--

LOCK TABLES `admins` WRITE;
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` VALUES
(1,'Admin Lumyfy','admin@lumyfy.com','$2y$12$n3G8cFfmLeCGoTZRq5EgN.ImPO0mYItAL2fL/ieeW1bLk0ZQSGY16',NULL,1,1,NULL,NULL,'2025-08-29 23:42:48','2025-08-29 23:42:48');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_families`
--

DROP TABLE IF EXISTS `attribute_families`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_families` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_families`
--

LOCK TABLES `attribute_families` WRITE;
/*!40000 ALTER TABLE `attribute_families` DISABLE KEYS */;
INSERT INTO `attribute_families` VALUES
(1,'default','Padrão',0,1);
/*!40000 ALTER TABLE `attribute_families` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_group_mappings`
--

DROP TABLE IF EXISTS `attribute_group_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_group_mappings` (
  `attribute_id` int(10) unsigned NOT NULL,
  `attribute_group_id` int(10) unsigned NOT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`attribute_id`,`attribute_group_id`),
  KEY `attribute_group_mappings_attribute_group_id_foreign` (`attribute_group_id`),
  CONSTRAINT `attribute_group_mappings_attribute_group_id_foreign` FOREIGN KEY (`attribute_group_id`) REFERENCES `attribute_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attribute_group_mappings_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_group_mappings`
--

LOCK TABLES `attribute_group_mappings` WRITE;
/*!40000 ALTER TABLE `attribute_group_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_group_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_groups`
--

DROP TABLE IF EXISTS `attribute_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_family_id` int(10) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `position` int(11) NOT NULL,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_groups_attribute_family_id_name_unique` (`attribute_family_id`,`name`),
  CONSTRAINT `attribute_groups_attribute_family_id_foreign` FOREIGN KEY (`attribute_family_id`) REFERENCES `attribute_families` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_groups`
--

LOCK TABLES `attribute_groups` WRITE;
/*!40000 ALTER TABLE `attribute_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_option_translations`
--

DROP TABLE IF EXISTS `attribute_option_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_option_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_option_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `label` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_option_locale_unique` (`attribute_option_id`,`locale`),
  CONSTRAINT `attribute_option_translations_attribute_option_id_foreign` FOREIGN KEY (`attribute_option_id`) REFERENCES `attribute_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_option_translations`
--

LOCK TABLES `attribute_option_translations` WRITE;
/*!40000 ALTER TABLE `attribute_option_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_option_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_options`
--

DROP TABLE IF EXISTS `attribute_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` int(10) unsigned NOT NULL,
  `admin_name` varchar(255) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `swatch_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attribute_options_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `attribute_options_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_options`
--

LOCK TABLES `attribute_options` WRITE;
/*!40000 ALTER TABLE `attribute_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attribute_translations`
--

DROP TABLE IF EXISTS `attribute_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attribute_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `attribute_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `name` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attribute_translations_attribute_id_locale_unique` (`attribute_id`,`locale`),
  CONSTRAINT `attribute_translations_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attribute_translations`
--

LOCK TABLES `attribute_translations` WRITE;
/*!40000 ALTER TABLE `attribute_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `attribute_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attributes`
--

DROP TABLE IF EXISTS `attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `attributes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `admin_name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `swatch_type` varchar(255) DEFAULT NULL,
  `validation` varchar(255) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `is_unique` tinyint(1) NOT NULL DEFAULT 0,
  `is_filterable` tinyint(1) NOT NULL DEFAULT 0,
  `is_comparable` tinyint(1) NOT NULL DEFAULT 0,
  `is_configurable` tinyint(1) NOT NULL DEFAULT 0,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT 1,
  `is_visible_on_front` tinyint(1) NOT NULL DEFAULT 0,
  `value_per_locale` tinyint(1) NOT NULL DEFAULT 0,
  `value_per_channel` tinyint(1) NOT NULL DEFAULT 0,
  `enable_wysiwyg` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `attributes_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attributes`
--

LOCK TABLES `attributes` WRITE;
/*!40000 ALTER TABLE `attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_appointment_slots`
--

DROP TABLE IF EXISTS `booking_product_appointment_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_product_appointment_slots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_id` int(10) unsigned NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `break_time` int(11) DEFAULT NULL,
  `same_slot_all_days` tinyint(1) DEFAULT NULL,
  `slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`slots`)),
  PRIMARY KEY (`id`),
  KEY `booking_product_appointment_slots_booking_product_id_foreign` (`booking_product_id`),
  CONSTRAINT `booking_product_appointment_slots_booking_product_id_foreign` FOREIGN KEY (`booking_product_id`) REFERENCES `booking_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_appointment_slots`
--

LOCK TABLES `booking_product_appointment_slots` WRITE;
/*!40000 ALTER TABLE `booking_product_appointment_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_appointment_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_default_slots`
--

DROP TABLE IF EXISTS `booking_product_default_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_product_default_slots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_id` int(10) unsigned NOT NULL,
  `booking_type` varchar(255) NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `break_time` int(11) DEFAULT NULL,
  `slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`slots`)),
  PRIMARY KEY (`id`),
  KEY `booking_product_default_slots_booking_product_id_foreign` (`booking_product_id`),
  CONSTRAINT `booking_product_default_slots_booking_product_id_foreign` FOREIGN KEY (`booking_product_id`) REFERENCES `booking_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_default_slots`
--

LOCK TABLES `booking_product_default_slots` WRITE;
/*!40000 ALTER TABLE `booking_product_default_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_default_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_event_tickets`
--

DROP TABLE IF EXISTS `booking_product_event_tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_product_event_tickets` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_id` int(10) unsigned NOT NULL,
  `price` decimal(12,4) DEFAULT 0.0000,
  `qty` int(11) DEFAULT 0,
  `special_price` decimal(12,4) DEFAULT NULL,
  `special_price_from` datetime DEFAULT NULL,
  `special_price_to` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_product_event_tickets_booking_product_id_foreign` (`booking_product_id`),
  CONSTRAINT `booking_product_event_tickets_booking_product_id_foreign` FOREIGN KEY (`booking_product_id`) REFERENCES `booking_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_event_tickets`
--

LOCK TABLES `booking_product_event_tickets` WRITE;
/*!40000 ALTER TABLE `booking_product_event_tickets` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_event_tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_rental_slots`
--

DROP TABLE IF EXISTS `booking_product_rental_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_product_rental_slots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_id` int(10) unsigned NOT NULL,
  `renting_type` varchar(255) NOT NULL,
  `daily_price` decimal(12,4) DEFAULT 0.0000,
  `hourly_price` decimal(12,4) DEFAULT 0.0000,
  `same_slot_all_days` tinyint(1) DEFAULT NULL,
  `slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`slots`)),
  PRIMARY KEY (`id`),
  KEY `booking_product_rental_slots_booking_product_id_foreign` (`booking_product_id`),
  CONSTRAINT `booking_product_rental_slots_booking_product_id_foreign` FOREIGN KEY (`booking_product_id`) REFERENCES `booking_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_rental_slots`
--

LOCK TABLES `booking_product_rental_slots` WRITE;
/*!40000 ALTER TABLE `booking_product_rental_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_rental_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_product_table_slots`
--

DROP TABLE IF EXISTS `booking_product_table_slots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_product_table_slots` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `booking_product_id` int(10) unsigned NOT NULL,
  `price_type` varchar(255) NOT NULL,
  `guest_limit` int(11) NOT NULL DEFAULT 0,
  `duration` int(11) NOT NULL,
  `break_time` int(11) NOT NULL,
  `prevent_scheduling_before` int(11) NOT NULL,
  `same_slot_all_days` tinyint(1) DEFAULT NULL,
  `slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`slots`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_product_table_slots_booking_product_id_foreign` (`booking_product_id`),
  CONSTRAINT `booking_product_table_slots_booking_product_id_foreign` FOREIGN KEY (`booking_product_id`) REFERENCES `booking_products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_product_table_slots`
--

LOCK TABLES `booking_product_table_slots` WRITE;
/*!40000 ALTER TABLE `booking_product_table_slots` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_product_table_slots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking_products`
--

DROP TABLE IF EXISTS `booking_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `qty` int(11) DEFAULT 0,
  `location` varchar(255) DEFAULT NULL,
  `show_location` tinyint(1) NOT NULL DEFAULT 0,
  `available_every_week` tinyint(1) DEFAULT NULL,
  `available_from` datetime DEFAULT NULL,
  `available_to` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_products_product_id_foreign` (`product_id`),
  CONSTRAINT `booking_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_products`
--

LOCK TABLES `booking_products` WRITE;
/*!40000 ALTER TABLE `booking_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_email` varchar(255) DEFAULT NULL,
  `customer_first_name` varchar(255) DEFAULT NULL,
  `customer_last_name` varchar(255) DEFAULT NULL,
  `shipping_method` varchar(255) DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `is_gift` tinyint(1) NOT NULL DEFAULT 0,
  `items_count` int(11) DEFAULT NULL,
  `items_qty` decimal(12,4) DEFAULT NULL,
  `exchange_rate` decimal(12,4) DEFAULT NULL,
  `global_currency_code` varchar(255) DEFAULT NULL,
  `base_currency_code` varchar(255) DEFAULT NULL,
  `channel_currency_code` varchar(255) DEFAULT NULL,
  `cart_currency_code` varchar(255) DEFAULT NULL,
  `grand_total` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total` decimal(12,4) DEFAULT 0.0000,
  `sub_total` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total` decimal(12,4) DEFAULT 0.0000,
  `tax_total` decimal(12,4) DEFAULT 0.0000,
  `base_tax_total` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `checkout_method` varchar(255) DEFAULT NULL,
  `is_guest` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `applied_cart_rule_ids` varchar(255) DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_customer_id_foreign` (`customer_id`),
  KEY `cart_channel_id_foreign` (`channel_id`),
  CONSTRAINT `cart_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item_inventories`
--

DROP TABLE IF EXISTS `cart_item_inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item_inventories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qty` int(10) unsigned NOT NULL DEFAULT 0,
  `inventory_source_id` int(10) unsigned DEFAULT NULL,
  `cart_item_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item_inventories`
--

LOCK TABLES `cart_item_inventories` WRITE;
/*!40000 ALTER TABLE `cart_item_inventories` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_item_inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_items`
--

DROP TABLE IF EXISTS `cart_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `sku` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `weight` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total_weight` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total_weight` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `price` decimal(12,4) NOT NULL DEFAULT 1.0000,
  `base_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `custom_price` decimal(12,4) DEFAULT NULL,
  `total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `tax_percent` decimal(12,4) DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_percent` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `cart_id` int(10) unsigned NOT NULL,
  `tax_category_id` int(10) unsigned DEFAULT NULL,
  `applied_cart_rule_ids` varchar(255) DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_items_parent_id_foreign` (`parent_id`),
  KEY `cart_items_product_id_foreign` (`product_id`),
  KEY `cart_items_cart_id_foreign` (`cart_id`),
  KEY `cart_items_tax_category_id_foreign` (`tax_category_id`),
  CONSTRAINT `cart_items_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `cart_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_items_tax_category_id_foreign` FOREIGN KEY (`tax_category_id`) REFERENCES `tax_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_items`
--

LOCK TABLES `cart_items` WRITE;
/*!40000 ALTER TABLE `cart_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_payment`
--

DROP TABLE IF EXISTS `cart_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `method` varchar(255) NOT NULL,
  `method_title` varchar(255) DEFAULT NULL,
  `cart_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_payment_cart_id_foreign` (`cart_id`),
  CONSTRAINT `cart_payment_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_payment`
--

LOCK TABLES `cart_payment` WRITE;
/*!40000 ALTER TABLE `cart_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_channels`
--

DROP TABLE IF EXISTS `cart_rule_channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_rule_channels` (
  `cart_rule_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cart_rule_id`,`channel_id`),
  KEY `cart_rule_channels_channel_id_foreign` (`channel_id`),
  CONSTRAINT `cart_rule_channels_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_channels_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_channels`
--

LOCK TABLES `cart_rule_channels` WRITE;
/*!40000 ALTER TABLE `cart_rule_channels` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_coupon_usage`
--

DROP TABLE IF EXISTS `cart_rule_coupon_usage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_rule_coupon_usage` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `times_used` int(11) NOT NULL DEFAULT 0,
  `cart_rule_coupon_id` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_rule_coupon_usage_cart_rule_coupon_id_foreign` (`cart_rule_coupon_id`),
  KEY `cart_rule_coupon_usage_customer_id_foreign` (`customer_id`),
  CONSTRAINT `cart_rule_coupon_usage_cart_rule_coupon_id_foreign` FOREIGN KEY (`cart_rule_coupon_id`) REFERENCES `cart_rule_coupons` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_coupon_usage_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_coupon_usage`
--

LOCK TABLES `cart_rule_coupon_usage` WRITE;
/*!40000 ALTER TABLE `cart_rule_coupon_usage` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_coupon_usage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_coupons`
--

DROP TABLE IF EXISTS `cart_rule_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_rule_coupons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `usage_limit` int(10) unsigned NOT NULL DEFAULT 0,
  `usage_per_customer` int(10) unsigned NOT NULL DEFAULT 0,
  `times_used` int(10) unsigned NOT NULL DEFAULT 0,
  `type` int(10) unsigned NOT NULL DEFAULT 0,
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `expired_at` date DEFAULT NULL,
  `cart_rule_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_rule_coupons_cart_rule_id_foreign` (`cart_rule_id`),
  CONSTRAINT `cart_rule_coupons_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_coupons`
--

LOCK TABLES `cart_rule_coupons` WRITE;
/*!40000 ALTER TABLE `cart_rule_coupons` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_coupons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_customer_groups`
--

DROP TABLE IF EXISTS `cart_rule_customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_rule_customer_groups` (
  `cart_rule_id` int(10) unsigned NOT NULL,
  `customer_group_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`cart_rule_id`,`customer_group_id`),
  KEY `cart_rule_customer_groups_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `cart_rule_customer_groups_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_customer_groups_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_customer_groups`
--

LOCK TABLES `cart_rule_customer_groups` WRITE;
/*!40000 ALTER TABLE `cart_rule_customer_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_customer_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_customers`
--

DROP TABLE IF EXISTS `cart_rule_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_rule_customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `times_used` bigint(20) unsigned NOT NULL DEFAULT 0,
  `customer_id` int(10) unsigned NOT NULL,
  `cart_rule_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cart_rule_customers_cart_rule_id_foreign` (`cart_rule_id`),
  KEY `cart_rule_customers_customer_id_foreign` (`customer_id`),
  CONSTRAINT `cart_rule_customers_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cart_rule_customers_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_customers`
--

LOCK TABLES `cart_rule_customers` WRITE;
/*!40000 ALTER TABLE `cart_rule_customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rule_translations`
--

DROP TABLE IF EXISTS `cart_rule_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_rule_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) NOT NULL,
  `label` text DEFAULT NULL,
  `cart_rule_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cart_rule_translations_cart_rule_id_locale_unique` (`cart_rule_id`,`locale`),
  CONSTRAINT `cart_rule_translations_cart_rule_id_foreign` FOREIGN KEY (`cart_rule_id`) REFERENCES `cart_rules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rule_translations`
--

LOCK TABLES `cart_rule_translations` WRITE;
/*!40000 ALTER TABLE `cart_rule_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rule_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_rules`
--

DROP TABLE IF EXISTS `cart_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `starts_from` datetime DEFAULT NULL,
  `ends_till` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `coupon_type` int(11) NOT NULL DEFAULT 1,
  `use_auto_generation` tinyint(1) NOT NULL DEFAULT 0,
  `usage_per_customer` int(11) NOT NULL DEFAULT 0,
  `uses_per_coupon` int(11) NOT NULL DEFAULT 0,
  `times_used` int(10) unsigned NOT NULL DEFAULT 0,
  `condition_type` tinyint(1) NOT NULL DEFAULT 1,
  `conditions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`conditions`)),
  `end_other_rules` tinyint(1) NOT NULL DEFAULT 0,
  `uses_attribute_conditions` tinyint(1) NOT NULL DEFAULT 0,
  `action_type` varchar(255) DEFAULT NULL,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `discount_quantity` int(11) NOT NULL DEFAULT 1,
  `discount_step` varchar(255) NOT NULL DEFAULT '1',
  `apply_to_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `free_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_rules`
--

LOCK TABLES `cart_rules` WRITE;
/*!40000 ALTER TABLE `cart_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_shipping_rates`
--

DROP TABLE IF EXISTS `cart_shipping_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_shipping_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `carrier` varchar(255) NOT NULL,
  `carrier_title` varchar(255) NOT NULL,
  `method` varchar(255) NOT NULL,
  `method_title` varchar(255) NOT NULL,
  `method_description` varchar(255) DEFAULT NULL,
  `price` double DEFAULT 0,
  `base_price` double DEFAULT 0,
  `discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `is_calculate_tax` tinyint(1) NOT NULL DEFAULT 1,
  `cart_address_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_shipping_rates`
--

LOCK TABLES `cart_shipping_rates` WRITE;
/*!40000 ALTER TABLE `cart_shipping_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_shipping_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `position` int(11) NOT NULL DEFAULT 0,
  `image` varchar(255) DEFAULT NULL,
  `category_banner` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `display_mode` varchar(255) DEFAULT 'products_and_description',
  `_lft` int(10) unsigned NOT NULL DEFAULT 0,
  `_rgt` int(10) unsigned NOT NULL DEFAULT 0,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories__lft__rgt_parent_id_index` (`_lft`,`_rgt`,`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_filterable_attributes`
--

DROP TABLE IF EXISTS `category_filterable_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_filterable_attributes` (
  `category_id` int(10) unsigned NOT NULL,
  `attribute_id` int(10) unsigned NOT NULL,
  KEY `category_filterable_attributes_category_id_foreign` (`category_id`),
  KEY `category_filterable_attributes_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `category_filterable_attributes_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_filterable_attributes_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_filterable_attributes`
--

LOCK TABLES `category_filterable_attributes` WRITE;
/*!40000 ALTER TABLE `category_filterable_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_filterable_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_translations`
--

DROP TABLE IF EXISTS `category_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `name` text NOT NULL,
  `slug` varchar(255) NOT NULL,
  `url_path` varchar(2048) NOT NULL,
  `description` text DEFAULT NULL,
  `meta_title` text DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `locale_id` int(10) unsigned DEFAULT NULL,
  `locale` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_translations_category_id_slug_locale_unique` (`category_id`,`slug`,`locale`),
  KEY `category_translations_locale_id_foreign` (`locale_id`),
  CONSTRAINT `category_translations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_translations_locale_id_foreign` FOREIGN KEY (`locale_id`) REFERENCES `locales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_translations`
--

LOCK TABLES `category_translations` WRITE;
/*!40000 ALTER TABLE `category_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_currencies`
--

DROP TABLE IF EXISTS `channel_currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_currencies` (
  `channel_id` int(10) unsigned NOT NULL,
  `currency_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`channel_id`,`currency_id`),
  KEY `channel_currencies_currency_id_foreign` (`currency_id`),
  CONSTRAINT `channel_currencies_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_currencies_currency_id_foreign` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_currencies`
--

LOCK TABLES `channel_currencies` WRITE;
/*!40000 ALTER TABLE `channel_currencies` DISABLE KEYS */;
/*!40000 ALTER TABLE `channel_currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_inventory_sources`
--

DROP TABLE IF EXISTS `channel_inventory_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_inventory_sources` (
  `channel_id` int(10) unsigned NOT NULL,
  `inventory_source_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `channel_inventory_source_unique` (`channel_id`,`inventory_source_id`),
  KEY `channel_inventory_sources_inventory_source_id_foreign` (`inventory_source_id`),
  CONSTRAINT `channel_inventory_sources_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_inventory_sources_inventory_source_id_foreign` FOREIGN KEY (`inventory_source_id`) REFERENCES `inventory_sources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_inventory_sources`
--

LOCK TABLES `channel_inventory_sources` WRITE;
/*!40000 ALTER TABLE `channel_inventory_sources` DISABLE KEYS */;
/*!40000 ALTER TABLE `channel_inventory_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channel_locales`
--

DROP TABLE IF EXISTS `channel_locales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `channel_locales` (
  `channel_id` int(10) unsigned NOT NULL,
  `locale_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`channel_id`,`locale_id`),
  KEY `channel_locales_locale_id_foreign` (`locale_id`),
  CONSTRAINT `channel_locales_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `channel_locales_locale_id_foreign` FOREIGN KEY (`locale_id`) REFERENCES `locales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channel_locales`
--

LOCK TABLES `channel_locales` WRITE;
/*!40000 ALTER TABLE `channel_locales` DISABLE KEYS */;
/*!40000 ALTER TABLE `channel_locales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `channels`
--

DROP TABLE IF EXISTS `channels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `channels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `theme` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `favicon` varchar(255) DEFAULT NULL,
  `home_seo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`home_seo`)),
  `is_maintenance_on` tinyint(1) NOT NULL DEFAULT 0,
  `allowed_ips` text DEFAULT NULL,
  `root_category_id` int(10) unsigned DEFAULT NULL,
  `default_locale_id` int(10) unsigned NOT NULL,
  `base_currency_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `channels_root_category_id_foreign` (`root_category_id`),
  KEY `channels_default_locale_id_foreign` (`default_locale_id`),
  KEY `channels_base_currency_id_foreign` (`base_currency_id`),
  CONSTRAINT `channels_base_currency_id_foreign` FOREIGN KEY (`base_currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `channels_default_locale_id_foreign` FOREIGN KEY (`default_locale_id`) REFERENCES `locales` (`id`),
  CONSTRAINT `channels_root_category_id_foreign` FOREIGN KEY (`root_category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channels`
--

LOCK TABLES `channels` WRITE;
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;
/*!40000 ALTER TABLE `channels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cms_pages`
--

DROP TABLE IF EXISTS `cms_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cms_pages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `layout` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cms_pages`
--

LOCK TABLES `cms_pages` WRITE;
/*!40000 ALTER TABLE `cms_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `cms_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `core_config`
--

DROP TABLE IF EXISTS `core_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `core_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `channel_code` varchar(255) DEFAULT NULL,
  `locale_code` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `core_config`
--

LOCK TABLES `core_config` WRITE;
/*!40000 ALTER TABLE `core_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `core_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_state_translations`
--

DROP TABLE IF EXISTS `country_state_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `country_state_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_state_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `default_name` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_state_translations_country_state_id_foreign` (`country_state_id`),
  CONSTRAINT `country_state_translations_country_state_id_foreign` FOREIGN KEY (`country_state_id`) REFERENCES `country_states` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_state_translations`
--

LOCK TABLES `country_state_translations` WRITE;
/*!40000 ALTER TABLE `country_state_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `country_state_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_states`
--

DROP TABLE IF EXISTS `country_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `country_states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(10) unsigned DEFAULT NULL,
  `country_code` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `default_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_states_country_id_foreign` (`country_id`),
  CONSTRAINT `country_states_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_states`
--

LOCK TABLES `country_states` WRITE;
/*!40000 ALTER TABLE `country_states` DISABLE KEYS */;
/*!40000 ALTER TABLE `country_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_translations`
--

DROP TABLE IF EXISTS `country_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `country_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `name` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_translations_country_id_foreign` (`country_id`),
  CONSTRAINT `country_translations_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_translations`
--

LOCK TABLES `country_translations` WRITE;
/*!40000 ALTER TABLE `country_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `country_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `symbol` varchar(255) DEFAULT NULL,
  `decimal` int(10) unsigned NOT NULL DEFAULT 2,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_exchange_rates`
--

DROP TABLE IF EXISTS `currency_exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency_exchange_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rate` decimal(24,12) NOT NULL,
  `target_currency` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `currency_exchange_rates_target_currency_unique` (`target_currency`),
  CONSTRAINT `currency_exchange_rates_target_currency_foreign` FOREIGN KEY (`target_currency`) REFERENCES `currencies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_exchange_rates`
--

LOCK TABLES `currency_exchange_rates` WRITE;
/*!40000 ALTER TABLE `currency_exchange_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `currency_exchange_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_groups`
--

DROP TABLE IF EXISTS `customer_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_groups` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_groups_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_groups`
--

LOCK TABLES `customer_groups` WRITE;
/*!40000 ALTER TABLE `customer_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_password_resets`
--

DROP TABLE IF EXISTS `customer_password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `customer_password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_password_resets`
--

LOCK TABLES `customer_password_resets` WRITE;
/*!40000 ALTER TABLE `customer_password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(50) DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `password` varchar(255) DEFAULT NULL,
  `api_token` varchar(80) DEFAULT NULL,
  `customer_group_id` int(10) unsigned DEFAULT NULL,
  `subscribed_to_news_letter` tinyint(1) NOT NULL DEFAULT 0,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `is_suspended` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `token` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customers_email_unique` (`email`),
  UNIQUE KEY `customers_phone_unique` (`phone`),
  UNIQUE KEY `customers_api_token_unique` (`api_token`),
  KEY `customers_customer_group_id_foreign` (`customer_group_id`),
  CONSTRAINT `customers_customer_group_id_foreign` FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `downloadable_link_purchased`
--

DROP TABLE IF EXISTS `downloadable_link_purchased`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `downloadable_link_purchased` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `download_bought` int(11) NOT NULL DEFAULT 0,
  `download_used` int(11) NOT NULL DEFAULT 0,
  `status` varchar(255) DEFAULT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `order_item_id` int(10) unsigned NOT NULL,
  `download_canceled` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `downloadable_link_purchased_customer_id_foreign` (`customer_id`),
  KEY `downloadable_link_purchased_order_id_foreign` (`order_id`),
  KEY `downloadable_link_purchased_order_item_id_foreign` (`order_item_id`),
  CONSTRAINT `downloadable_link_purchased_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `downloadable_link_purchased_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `downloadable_link_purchased_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `downloadable_link_purchased`
--

LOCK TABLES `downloadable_link_purchased` WRITE;
/*!40000 ALTER TABLE `downloadable_link_purchased` DISABLE KEYS */;
/*!40000 ALTER TABLE `downloadable_link_purchased` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_sources`
--

DROP TABLE IF EXISTS `inventory_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_sources` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `contact_name` varchar(255) NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `contact_number` varchar(255) NOT NULL,
  `contact_fax` varchar(255) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `street` varchar(255) NOT NULL,
  `postcode` varchar(255) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 0,
  `latitude` decimal(10,5) DEFAULT NULL,
  `longitude` decimal(10,5) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventory_sources_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_sources`
--

LOCK TABLES `inventory_sources` WRITE;
/*!40000 ALTER TABLE `inventory_sources` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_items`
--

DROP TABLE IF EXISTS `invoice_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_percent` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `product_id` int(10) unsigned DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `order_item_id` int(10) unsigned DEFAULT NULL,
  `invoice_id` int(10) unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_items_invoice_id_foreign` (`invoice_id`),
  KEY `invoice_items_parent_id_foreign` (`parent_id`),
  CONSTRAINT `invoice_items_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoice_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `invoice_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_items`
--

LOCK TABLES `invoice_items` WRITE;
/*!40000 ALTER TABLE `invoice_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `increment_id` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT 0,
  `total_qty` int(11) DEFAULT NULL,
  `base_currency_code` varchar(255) DEFAULT NULL,
  `channel_currency_code` varchar(255) DEFAULT NULL,
  `order_currency_code` varchar(255) DEFAULT NULL,
  `sub_total` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total` decimal(12,4) DEFAULT 0.0000,
  `grand_total` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total` decimal(12,4) DEFAULT 0.0000,
  `shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `order_id` int(10) unsigned DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `reminders` int(11) NOT NULL DEFAULT 0,
  `next_reminder_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoices_order_id_foreign` (`order_id`),
  CONSTRAINT `invoices_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locales`
--

DROP TABLE IF EXISTS `locales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `locales` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `direction` enum('ltr','rtl') NOT NULL DEFAULT 'ltr',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `locales_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locales`
--

LOCK TABLES `locales` WRITE;
/*!40000 ALTER TABLE `locales` DISABLE KEYS */;
/*!40000 ALTER TABLE `locales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_admin_password_resets_table',1),
(3,'2014_10_12_100000_create_password_resets_table',1),
(4,'2018_06_12_111907_create_admins_table',1),
(5,'2018_06_13_055341_create_roles_table',1),
(6,'2018_07_05_130148_create_attributes_table',1),
(7,'2018_07_05_132854_create_attribute_translations_table',1),
(8,'2018_07_05_135150_create_attribute_families_table',1),
(9,'2018_07_05_135152_create_attribute_groups_table',1),
(10,'2018_07_05_140832_create_attribute_options_table',1),
(11,'2018_07_05_140856_create_attribute_option_translations_table',1),
(12,'2018_07_05_142820_create_categories_table',1),
(13,'2018_07_10_055143_create_locales_table',1),
(14,'2018_07_20_054426_create_countries_table',1),
(15,'2018_07_20_054502_create_currencies_table',1),
(16,'2018_07_20_054542_create_currency_exchange_rates_table',1),
(17,'2018_07_20_064849_create_channels_table',1),
(18,'2018_07_21_142836_create_category_translations_table',1),
(19,'2018_07_23_110040_create_inventory_sources_table',1),
(20,'2018_07_24_082635_create_customer_groups_table',1),
(21,'2018_07_24_082930_create_customers_table',1),
(22,'2018_07_27_065727_create_products_table',1),
(23,'2018_07_27_070011_create_product_attribute_values_table',1),
(24,'2018_07_27_092623_create_product_reviews_table',1),
(25,'2018_07_27_113941_create_product_images_table',1),
(26,'2018_07_27_113956_create_product_inventories_table',1),
(27,'2018_08_30_064755_create_tax_categories_table',1),
(28,'2018_08_30_065042_create_tax_rates_table',1),
(29,'2018_08_30_065840_create_tax_mappings_table',1),
(30,'2018_09_05_150444_create_cart_table',1),
(31,'2018_09_05_150915_create_cart_items_table',1),
(32,'2018_09_11_064045_customer_password_resets',1),
(33,'2018_09_19_093453_create_cart_payment',1),
(34,'2018_09_19_093508_create_cart_shipping_rates_table',1),
(35,'2018_09_20_060658_create_core_config_table',1),
(36,'2018_09_27_113154_create_orders_table',1),
(37,'2018_09_27_113207_create_order_items_table',1),
(38,'2018_09_27_115022_create_shipments_table',1),
(39,'2018_09_27_115029_create_shipment_items_table',1),
(40,'2018_09_27_115135_create_invoices_table',1),
(41,'2018_09_27_115144_create_invoice_items_table',1),
(42,'2018_10_01_095504_create_order_payment_table',1),
(43,'2018_10_03_025230_create_wishlist_table',1),
(44,'2018_10_12_101803_create_country_translations_table',1),
(45,'2018_10_12_101913_create_country_states_table',1),
(46,'2018_10_12_101923_create_country_state_translations_table',1),
(47,'2018_11_16_173504_create_subscribers_list_table',1),
(48,'2018_11_21_144411_create_cart_item_inventories_table',1),
(49,'2018_12_06_185202_create_product_flat_table',1),
(50,'2018_12_24_123812_create_channel_inventory_sources_table',1),
(51,'2018_12_26_165327_create_product_ordered_inventories_table',1),
(52,'2019_05_13_024321_create_cart_rules_table',1),
(53,'2019_05_13_024322_create_cart_rule_channels_table',1),
(54,'2019_05_13_024323_create_cart_rule_customer_groups_table',1),
(55,'2019_05_13_024324_create_cart_rule_translations_table',1),
(56,'2019_05_13_024325_create_cart_rule_customers_table',1),
(57,'2019_05_13_024326_create_cart_rule_coupons_table',1),
(58,'2019_05_13_024327_create_cart_rule_coupon_usage_table',1),
(59,'2019_06_17_180258_create_product_downloadable_samples_table',1),
(60,'2019_06_17_180314_create_product_downloadable_sample_translations_table',1),
(61,'2019_06_17_180325_create_product_downloadable_links_table',1),
(62,'2019_06_17_180346_create_product_downloadable_link_translations_table',1),
(63,'2019_06_21_202249_create_downloadable_link_purchased_table',1),
(64,'2019_07_02_180307_create_booking_products_table',1),
(65,'2019_07_05_154415_create_booking_product_default_slots_table',1),
(66,'2019_07_05_154429_create_booking_product_appointment_slots_table',1),
(67,'2019_07_05_154440_create_booking_product_event_tickets_table',1),
(68,'2019_07_05_154451_create_booking_product_rental_slots_table',1),
(69,'2019_07_05_154502_create_booking_product_table_slots_table',1),
(70,'2019_07_30_153530_create_cms_pages_table',1),
(71,'2019_07_31_143339_create_category_filterable_attributes_table',1),
(72,'2019_08_02_105320_create_product_grouped_products_table',1),
(73,'2019_08_20_170510_create_product_bundle_options_table',1),
(74,'2019_08_20_170520_create_product_bundle_option_translations_table',1),
(75,'2019_08_20_170528_create_product_bundle_option_products_table',1),
(76,'2019_09_11_184511_create_refunds_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `weight` decimal(12,4) DEFAULT 0.0000,
  `total_weight` decimal(12,4) DEFAULT 0.0000,
  `qty_ordered` int(11) DEFAULT 0,
  `qty_shipped` int(11) DEFAULT 0,
  `qty_invoiced` int(11) DEFAULT 0,
  `qty_canceled` int(11) DEFAULT 0,
  `qty_refunded` int(11) DEFAULT 0,
  `price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total_invoiced` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total_invoiced` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `amount_refunded` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_amount_refunded` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `discount_percent` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_discount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `discount_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_discount_refunded` decimal(12,4) DEFAULT 0.0000,
  `tax_percent` decimal(12,4) DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `tax_amount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `tax_amount_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount_refunded` decimal(12,4) DEFAULT 0.0000,
  `product_id` int(10) unsigned DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `order_id` int(10) unsigned DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_items_order_id_foreign` (`order_id`),
  KEY `order_items_parent_id_foreign` (`parent_id`),
  CONSTRAINT `order_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_payment`
--

DROP TABLE IF EXISTS `order_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_payment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `method` varchar(255) NOT NULL,
  `method_title` varchar(255) DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_payment_order_id_foreign` (`order_id`),
  CONSTRAINT `order_payment_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_payment`
--

LOCK TABLES `order_payment` WRITE;
/*!40000 ALTER TABLE `order_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `increment_id` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `channel_name` varchar(255) DEFAULT NULL,
  `is_guest` tinyint(1) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `customer_first_name` varchar(255) DEFAULT NULL,
  `customer_last_name` varchar(255) DEFAULT NULL,
  `shipping_method` varchar(255) DEFAULT NULL,
  `shipping_title` varchar(255) DEFAULT NULL,
  `shipping_description` varchar(255) DEFAULT NULL,
  `coupon_code` varchar(255) DEFAULT NULL,
  `is_gift` tinyint(1) NOT NULL DEFAULT 0,
  `total_item_count` int(11) DEFAULT NULL,
  `total_qty_ordered` int(11) DEFAULT NULL,
  `base_currency_code` varchar(255) DEFAULT NULL,
  `channel_currency_code` varchar(255) DEFAULT NULL,
  `order_currency_code` varchar(255) DEFAULT NULL,
  `grand_total` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total` decimal(12,4) DEFAULT 0.0000,
  `grand_total_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total_invoiced` decimal(12,4) DEFAULT 0.0000,
  `grand_total_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total_refunded` decimal(12,4) DEFAULT 0.0000,
  `sub_total` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total` decimal(12,4) DEFAULT 0.0000,
  `sub_total_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total_invoiced` decimal(12,4) DEFAULT 0.0000,
  `sub_total_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total_refunded` decimal(12,4) DEFAULT 0.0000,
  `discount_percent` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_discount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `discount_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_discount_refunded` decimal(12,4) DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `tax_amount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount_invoiced` decimal(12,4) DEFAULT 0.0000,
  `tax_amount_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount_refunded` decimal(12,4) DEFAULT 0.0000,
  `shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `shipping_invoiced` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_invoiced` decimal(12,4) DEFAULT 0.0000,
  `shipping_refunded` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_refunded` decimal(12,4) DEFAULT 0.0000,
  `shipping_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `customer_type` varchar(255) DEFAULT NULL,
  `channel_id` int(10) unsigned DEFAULT NULL,
  `channel_type` varchar(255) DEFAULT NULL,
  `cart_id` int(11) DEFAULT NULL,
  `applied_cart_rule_ids` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_increment_id_unique` (`increment_id`),
  KEY `orders_customer_id_foreign` (`customer_id`),
  KEY `orders_channel_id_foreign` (`channel_id`),
  CONSTRAINT `orders_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE SET NULL,
  CONSTRAINT `orders_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_attribute_values`
--

DROP TABLE IF EXISTS `product_attribute_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_attribute_values` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) DEFAULT NULL,
  `channel` varchar(255) DEFAULT NULL,
  `text_value` text DEFAULT NULL,
  `boolean_value` tinyint(1) DEFAULT NULL,
  `integer_value` int(11) DEFAULT NULL,
  `float_value` decimal(12,4) DEFAULT NULL,
  `datetime_value` datetime DEFAULT NULL,
  `date_value` date DEFAULT NULL,
  `json_value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_value`)),
  `product_id` int(10) unsigned NOT NULL,
  `attribute_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chanel_locale_attribute_value_index_unique` (`channel`,`locale`,`attribute_id`,`product_id`),
  KEY `product_attribute_values_product_id_foreign` (`product_id`),
  KEY `product_attribute_values_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `product_attribute_values_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_attribute_values_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_attribute_values`
--

LOCK TABLES `product_attribute_values` WRITE;
/*!40000 ALTER TABLE `product_attribute_values` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_attribute_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_bundle_option_products`
--

DROP TABLE IF EXISTS `product_bundle_option_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_bundle_option_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `product_bundle_option_id` int(10) unsigned NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `is_user_defined` tinyint(1) NOT NULL DEFAULT 1,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `product_bundle_option_products_product_id_foreign` (`product_id`),
  KEY `product_bundle_option_id_foreign` (`product_bundle_option_id`),
  CONSTRAINT `product_bundle_option_id_foreign` FOREIGN KEY (`product_bundle_option_id`) REFERENCES `product_bundle_options` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_bundle_option_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_bundle_option_products`
--

LOCK TABLES `product_bundle_option_products` WRITE;
/*!40000 ALTER TABLE `product_bundle_option_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_bundle_option_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_bundle_option_translations`
--

DROP TABLE IF EXISTS `product_bundle_option_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_bundle_option_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) NOT NULL,
  `label` text DEFAULT NULL,
  `product_bundle_option_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_bundle_option_translations_option_id_locale_unique` (`product_bundle_option_id`,`locale`),
  CONSTRAINT `product_bundle_option_translations_option_id_foreign` FOREIGN KEY (`product_bundle_option_id`) REFERENCES `product_bundle_options` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_bundle_option_translations`
--

LOCK TABLES `product_bundle_option_translations` WRITE;
/*!40000 ALTER TABLE `product_bundle_option_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_bundle_option_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_bundle_options`
--

DROP TABLE IF EXISTS `product_bundle_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_bundle_options` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `is_required` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `product_bundle_options_product_id_foreign` (`product_id`),
  CONSTRAINT `product_bundle_options_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_bundle_options`
--

LOCK TABLES `product_bundle_options` WRITE;
/*!40000 ALTER TABLE `product_bundle_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_bundle_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_categories` (
  `product_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  KEY `product_categories_product_id_foreign` (`product_id`),
  KEY `product_categories_category_id_foreign` (`category_id`),
  CONSTRAINT `product_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_categories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_categories`
--

LOCK TABLES `product_categories` WRITE;
/*!40000 ALTER TABLE `product_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_cross_sells`
--

DROP TABLE IF EXISTS `product_cross_sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_cross_sells` (
  `parent_id` int(10) unsigned NOT NULL,
  `child_id` int(10) unsigned NOT NULL,
  KEY `product_cross_sells_parent_id_foreign` (`parent_id`),
  KEY `product_cross_sells_child_id_foreign` (`child_id`),
  CONSTRAINT `product_cross_sells_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_cross_sells_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_cross_sells`
--

LOCK TABLES `product_cross_sells` WRITE;
/*!40000 ALTER TABLE `product_cross_sells` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_cross_sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_downloadable_link_translations`
--

DROP TABLE IF EXISTS `product_downloadable_link_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_downloadable_link_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_downloadable_link_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `link_translations_link_id_foreign` (`product_downloadable_link_id`),
  CONSTRAINT `link_translations_link_id_foreign` FOREIGN KEY (`product_downloadable_link_id`) REFERENCES `product_downloadable_links` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_downloadable_link_translations`
--

LOCK TABLES `product_downloadable_link_translations` WRITE;
/*!40000 ALTER TABLE `product_downloadable_link_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_downloadable_link_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_downloadable_links`
--

DROP TABLE IF EXISTS `product_downloadable_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_downloadable_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `sample_url` varchar(255) DEFAULT NULL,
  `sample_file` varchar(255) DEFAULT NULL,
  `sample_file_name` varchar(255) DEFAULT NULL,
  `sample_type` varchar(255) DEFAULT NULL,
  `downloads` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_downloadable_links_product_id_foreign` (`product_id`),
  CONSTRAINT `product_downloadable_links_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_downloadable_links`
--

LOCK TABLES `product_downloadable_links` WRITE;
/*!40000 ALTER TABLE `product_downloadable_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_downloadable_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_downloadable_sample_translations`
--

DROP TABLE IF EXISTS `product_downloadable_sample_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_downloadable_sample_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_downloadable_sample_id` int(10) unsigned NOT NULL,
  `locale` varchar(255) NOT NULL,
  `title` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sample_translations_sample_id_foreign` (`product_downloadable_sample_id`),
  CONSTRAINT `sample_translations_sample_id_foreign` FOREIGN KEY (`product_downloadable_sample_id`) REFERENCES `product_downloadable_samples` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_downloadable_sample_translations`
--

LOCK TABLES `product_downloadable_sample_translations` WRITE;
/*!40000 ALTER TABLE `product_downloadable_sample_translations` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_downloadable_sample_translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_downloadable_samples`
--

DROP TABLE IF EXISTS `product_downloadable_samples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_downloadable_samples` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `url` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_downloadable_samples_product_id_foreign` (`product_id`),
  CONSTRAINT `product_downloadable_samples_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_downloadable_samples`
--

LOCK TABLES `product_downloadable_samples` WRITE;
/*!40000 ALTER TABLE `product_downloadable_samples` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_downloadable_samples` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_flat`
--

DROP TABLE IF EXISTS `product_flat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_flat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  `product_number` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `short_description` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `url_key` varchar(255) DEFAULT NULL,
  `new` tinyint(1) DEFAULT NULL,
  `featured` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `meta_title` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `price` decimal(12,4) DEFAULT NULL,
  `special_price` decimal(12,4) DEFAULT NULL,
  `special_price_from` date DEFAULT NULL,
  `special_price_to` date DEFAULT NULL,
  `weight` decimal(12,4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `locale` varchar(255) DEFAULT NULL,
  `channel` varchar(255) DEFAULT NULL,
  `attribute_family_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `visible_individually` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_flat_unique_index` (`product_id`,`channel`,`locale`),
  KEY `product_flat_attribute_family_id_foreign` (`attribute_family_id`),
  KEY `product_flat_parent_id_foreign` (`parent_id`),
  CONSTRAINT `product_flat_attribute_family_id_foreign` FOREIGN KEY (`attribute_family_id`) REFERENCES `attribute_families` (`id`),
  CONSTRAINT `product_flat_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `product_flat` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_flat_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_flat`
--

LOCK TABLES `product_flat` WRITE;
/*!40000 ALTER TABLE `product_flat` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_flat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_grouped_products`
--

DROP TABLE IF EXISTS `product_grouped_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_grouped_products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `associated_product_id` int(10) unsigned NOT NULL,
  `qty` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `product_grouped_products_product_id_foreign` (`product_id`),
  KEY `product_grouped_products_associated_product_id_foreign` (`associated_product_id`),
  CONSTRAINT `product_grouped_products_associated_product_id_foreign` FOREIGN KEY (`associated_product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_grouped_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_grouped_products`
--

LOCK TABLES `product_grouped_products` WRITE;
/*!40000 ALTER TABLE `product_grouped_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_grouped_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `position` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `product_images_product_id_foreign` (`product_id`),
  CONSTRAINT `product_images_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_inventories`
--

DROP TABLE IF EXISTS `product_inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_inventories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL DEFAULT 0,
  `product_id` int(10) unsigned NOT NULL,
  `vendor_id` int(11) NOT NULL DEFAULT 0,
  `inventory_source_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_source_vendor_index_unique` (`product_id`,`inventory_source_id`,`vendor_id`),
  KEY `product_inventories_inventory_source_id_foreign` (`inventory_source_id`),
  CONSTRAINT `product_inventories_inventory_source_id_foreign` FOREIGN KEY (`inventory_source_id`) REFERENCES `inventory_sources` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_inventories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_inventories`
--

LOCK TABLES `product_inventories` WRITE;
/*!40000 ALTER TABLE `product_inventories` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_ordered_inventories`
--

DROP TABLE IF EXISTS `product_ordered_inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_ordered_inventories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `qty` int(11) NOT NULL DEFAULT 0,
  `product_id` int(10) unsigned NOT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_ordered_inventories_product_id_channel_id_unique` (`product_id`,`channel_id`),
  KEY `product_ordered_inventories_channel_id_foreign` (`channel_id`),
  CONSTRAINT `product_ordered_inventories_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_ordered_inventories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_ordered_inventories`
--

LOCK TABLES `product_ordered_inventories` WRITE;
/*!40000 ALTER TABLE `product_ordered_inventories` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_ordered_inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_relations`
--

DROP TABLE IF EXISTS `product_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_relations` (
  `parent_id` int(10) unsigned NOT NULL,
  `child_id` int(10) unsigned NOT NULL,
  KEY `product_relations_parent_id_foreign` (`parent_id`),
  KEY `product_relations_child_id_foreign` (`child_id`),
  CONSTRAINT `product_relations_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_relations_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_relations`
--

LOCK TABLES `product_relations` WRITE;
/*!40000 ALTER TABLE `product_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_reviews`
--

DROP TABLE IF EXISTS `product_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_reviews` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `title` varchar(255) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_reviews_product_id_foreign` (`product_id`),
  CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_reviews`
--

LOCK TABLES `product_reviews` WRITE;
/*!40000 ALTER TABLE `product_reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_super_attributes`
--

DROP TABLE IF EXISTS `product_super_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_super_attributes` (
  `product_id` int(10) unsigned NOT NULL,
  `attribute_id` int(10) unsigned NOT NULL,
  KEY `product_super_attributes_product_id_foreign` (`product_id`),
  KEY `product_super_attributes_attribute_id_foreign` (`attribute_id`),
  CONSTRAINT `product_super_attributes_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`),
  CONSTRAINT `product_super_attributes_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_super_attributes`
--

LOCK TABLES `product_super_attributes` WRITE;
/*!40000 ALTER TABLE `product_super_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_super_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_up_sells`
--

DROP TABLE IF EXISTS `product_up_sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_up_sells` (
  `parent_id` int(10) unsigned NOT NULL,
  `child_id` int(10) unsigned NOT NULL,
  KEY `product_up_sells_parent_id_foreign` (`parent_id`),
  KEY `product_up_sells_child_id_foreign` (`child_id`),
  CONSTRAINT `product_up_sells_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_up_sells_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_up_sells`
--

LOCK TABLES `product_up_sells` WRITE;
/*!40000 ALTER TABLE `product_up_sells` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_up_sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `attribute_family_id` int(10) unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_sku_unique` (`sku`),
  KEY `products_attribute_family_id_foreign` (`attribute_family_id`),
  KEY `products_parent_id_foreign` (`parent_id`),
  CONSTRAINT `products_attribute_family_id_foreign` FOREIGN KEY (`attribute_family_id`) REFERENCES `attribute_families` (`id`),
  CONSTRAINT `products_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refund_items`
--

DROP TABLE IF EXISTS `refund_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `refund_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_price` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `base_total` decimal(12,4) NOT NULL DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_percent` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `product_id` int(10) unsigned DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `order_item_id` int(10) unsigned DEFAULT NULL,
  `refund_id` int(10) unsigned DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `refund_items_parent_id_foreign` (`parent_id`),
  KEY `refund_items_order_item_id_foreign` (`order_item_id`),
  CONSTRAINT `refund_items_order_item_id_foreign` FOREIGN KEY (`order_item_id`) REFERENCES `order_items` (`id`) ON DELETE CASCADE,
  CONSTRAINT `refund_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `refund_items` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refund_items`
--

LOCK TABLES `refund_items` WRITE;
/*!40000 ALTER TABLE `refund_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `refund_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refunds`
--

DROP TABLE IF EXISTS `refunds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `refunds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `increment_id` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT 0,
  `total_qty` int(11) DEFAULT NULL,
  `base_currency_code` varchar(255) DEFAULT NULL,
  `channel_currency_code` varchar(255) DEFAULT NULL,
  `order_currency_code` varchar(255) DEFAULT NULL,
  `adjustment_refund` decimal(12,4) DEFAULT 0.0000,
  `base_adjustment_refund` decimal(12,4) DEFAULT 0.0000,
  `adjustment_fee` decimal(12,4) DEFAULT 0.0000,
  `base_adjustment_fee` decimal(12,4) DEFAULT 0.0000,
  `sub_total` decimal(12,4) DEFAULT 0.0000,
  `base_sub_total` decimal(12,4) DEFAULT 0.0000,
  `grand_total` decimal(12,4) DEFAULT 0.0000,
  `base_grand_total` decimal(12,4) DEFAULT 0.0000,
  `shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `base_shipping_amount` decimal(12,4) DEFAULT 0.0000,
  `tax_amount` decimal(12,4) DEFAULT 0.0000,
  `base_tax_amount` decimal(12,4) DEFAULT 0.0000,
  `discount_percent` decimal(12,4) DEFAULT 0.0000,
  `discount_amount` decimal(12,4) DEFAULT 0.0000,
  `base_discount_amount` decimal(12,4) DEFAULT 0.0000,
  `order_id` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `refunds_order_id_foreign` (`order_id`),
  CONSTRAINT `refunds_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refunds`
--

LOCK TABLES `refunds` WRITE;
/*!40000 ALTER TABLE `refunds` DISABLE KEYS */;
/*!40000 ALTER TABLE `refunds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `permission_type` varchar(255) NOT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment_items`
--

DROP TABLE IF EXISTS `shipment_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipment_items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `sku` varchar(255) DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `price` decimal(12,4) DEFAULT 0.0000,
  `base_price` decimal(12,4) DEFAULT 0.0000,
  `total` decimal(12,4) DEFAULT 0.0000,
  `base_total` decimal(12,4) DEFAULT 0.0000,
  `product_id` int(10) unsigned DEFAULT NULL,
  `product_type` varchar(255) DEFAULT NULL,
  `order_item_id` int(10) unsigned DEFAULT NULL,
  `shipment_id` int(10) unsigned NOT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipment_items_shipment_id_foreign` (`shipment_id`),
  CONSTRAINT `shipment_items_shipment_id_foreign` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment_items`
--

LOCK TABLES `shipment_items` WRITE;
/*!40000 ALTER TABLE `shipment_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipment_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(255) DEFAULT NULL,
  `total_qty` int(11) DEFAULT NULL,
  `total_weight` int(11) DEFAULT NULL,
  `carrier_code` varchar(255) DEFAULT NULL,
  `carrier_title` varchar(255) DEFAULT NULL,
  `track_number` text DEFAULT NULL,
  `email_sent` tinyint(1) NOT NULL DEFAULT 0,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `customer_type` varchar(255) DEFAULT NULL,
  `order_id` int(10) unsigned NOT NULL,
  `order_address_id` int(10) unsigned DEFAULT NULL,
  `inventory_source_id` int(10) unsigned DEFAULT NULL,
  `inventory_source_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shipments_order_id_foreign` (`order_id`),
  KEY `shipments_inventory_source_id_foreign` (`inventory_source_id`),
  CONSTRAINT `shipments_inventory_source_id_foreign` FOREIGN KEY (`inventory_source_id`) REFERENCES `inventory_sources` (`id`) ON DELETE SET NULL,
  CONSTRAINT `shipments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscribers_list`
--

DROP TABLE IF EXISTS `subscribers_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscribers_list` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `is_subscribed` tinyint(1) NOT NULL DEFAULT 0,
  `token` varchar(255) DEFAULT NULL,
  `customer_id` int(10) unsigned DEFAULT NULL,
  `channel_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscribers_list_customer_id_foreign` (`customer_id`),
  KEY `subscribers_list_channel_id_foreign` (`channel_id`),
  CONSTRAINT `subscribers_list_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscribers_list_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscribers_list`
--

LOCK TABLES `subscribers_list` WRITE;
/*!40000 ALTER TABLE `subscribers_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscribers_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_categories`
--

DROP TABLE IF EXISTS `tax_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tax_categories_code_unique` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_categories`
--

LOCK TABLES `tax_categories` WRITE;
/*!40000 ALTER TABLE `tax_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_categories_tax_rates`
--

DROP TABLE IF EXISTS `tax_categories_tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_categories_tax_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tax_category_id` int(10) unsigned NOT NULL,
  `tax_rate_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tax_map_index_unique` (`tax_category_id`,`tax_rate_id`),
  KEY `tax_categories_tax_rates_tax_rate_id_foreign` (`tax_rate_id`),
  CONSTRAINT `tax_categories_tax_rates_tax_category_id_foreign` FOREIGN KEY (`tax_category_id`) REFERENCES `tax_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tax_categories_tax_rates_tax_rate_id_foreign` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_categories_tax_rates`
--

LOCK TABLES `tax_categories_tax_rates` WRITE;
/*!40000 ALTER TABLE `tax_categories_tax_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_categories_tax_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tax_rates`
--

DROP TABLE IF EXISTS `tax_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `tax_rates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `is_zip` tinyint(1) NOT NULL DEFAULT 0,
  `zip_code` varchar(255) DEFAULT NULL,
  `zip_from` varchar(255) DEFAULT NULL,
  `zip_to` varchar(255) DEFAULT NULL,
  `state` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `tax_rate` decimal(12,4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tax_rates_identifier_unique` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tax_rates`
--

LOCK TABLES `tax_rates` WRITE;
/*!40000 ALTER TABLE `tax_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `tax_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wishlist`
--

DROP TABLE IF EXISTS `wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `wishlist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  `item_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`item_options`)),
  `moved_to_cart` date DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `time_of_moving` date DEFAULT NULL,
  `additional` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `wishlist_channel_id_foreign` (`channel_id`),
  KEY `wishlist_product_id_foreign` (`product_id`),
  KEY `wishlist_customer_id_foreign` (`customer_id`),
  CONSTRAINT `wishlist_channel_id_foreign` FOREIGN KEY (`channel_id`) REFERENCES `channels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wishlist`
--

LOCK TABLES `wishlist` WRITE;
/*!40000 ALTER TABLE `wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wishlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-30  2:58:49
