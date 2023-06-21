DROP DATABASE IF EXISTS `voedselbank`;
CREATE DATABASE `voedselbank`;
USE `voedselbank`;

CREATE TABLE `allergy` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT DEFAULT NULL,
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `name` (`name`)
);

CREATE TABLE `supplier` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `delivery` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `supplier_id` BIGINT NOT NULL,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`)
);

CREATE TABLE `address` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `supplier_id` BIGINT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `street` VARCHAR(255) NOT NULL,
  `zipcode` VARCHAR(255) NOT NULL,
  `city` VARCHAR(255) NOT NULL,
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON DELETE CASCADE
);


CREATE TABLE `customer` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `adults` BIGINT NOT NULL,
  `children` BIGINT NOT NULL,
  `babies` BIGINT NOT NULL,
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE `category` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255),
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `name` (`name`)
);

CREATE TABLE `product` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `ean` VARCHAR(13) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `stock` INT NOT NULL,
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `ean` (`ean`),
  UNIQUE KEY `name` (`name`)
);

CREATE TABLE `preference` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255),
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `name` (`name`)
);

CREATE TABLE `product_preferences` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT NOT NULL,
  `preference_id` BIGINT NOT NULL,
  KEY `product_id` (`product_id`),
  KEY `preference_id` (`preference_id`),
  CONSTRAINT `product_preferences_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_preferences_ibfk_2` FOREIGN KEY (`preference_id`) REFERENCES `preference` (`id`) ON DELETE CASCADE
);

CREATE TABLE `customer_preferences` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `preference_id` BIGINT NOT NULL,
  `customer_id` BIGINT NOT NULL,
  KEY `preference_id` (`preference_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_preferences_ibfk_1` FOREIGN KEY (`preference_id`) REFERENCES `preference` (`id`) ON DELETE CASCADE,
  CONSTRAINT `customer_preferences_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE
);


CREATE TABLE `delivery_products` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `delivery_id` BIGINT NOT NULL,
  `product_id` BIGINT NOT NULL,
  `amount` BIGINT NOT NULL,
  KEY `delivery_id` (`delivery_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `delivery_products_ibfk_1` FOREIGN KEY (`delivery_id`) REFERENCES `delivery` (`id`) ON DELETE CASCADE,
  CONSTRAINT `delivery_products_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
);


CREATE TABLE `product_allergies` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT NOT NULL,
  `allergy_id` BIGINT NOT NULL,
  KEY `product_id` (`product_id`),
  KEY `allergy_id` (`allergy_id`),
  CONSTRAINT `product_allergies_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_allergies_ibfk_2` FOREIGN KEY (`allergy_id`) REFERENCES `allergy` (`id`) ON DELETE CASCADE
);

CREATE TABLE `product_categories` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `product_id` BIGINT NOT NULL,
  `cetegory_id` BIGINT NOT NULL,
  KEY `product_id` (`product_id`),
  KEY `cetegory_id` (`cetegory_id`),
  CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_categories_ibfk_2` FOREIGN KEY (`cetegory_id`) REFERENCES `category` (`id`) ON DELETE CASCADE
);


CREATE TABLE `customer_allergies` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `allergy_id` BIGINT NOT NULL,
  `customer_id` BIGINT NOT NULL,
  KEY `allergy_id` (`allergy_id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `customer_allergies_ibfk_1` FOREIGN KEY (`allergy_id`) REFERENCES `allergy` (`id`) ON DELETE CASCADE,
  CONSTRAINT `customer_allergies_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE
);

CREATE TABLE `contact_details` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `supplier_id` BIGINT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `phone_number` VARCHAR(255) NOT NULL,
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `email` (`email`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `contact_details_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`id`) ON DELETE CASCADE
);


CREATE TABLE `food_package` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `customer_id` BIGINT NOT NULL,
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `food_package_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE
);

CREATE TABLE `food_package_products` (
  `id` BIGINT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  `food_package_id` BIGINT NOT NULL,
  `products_id` BIGINT NOT NULL,
  `amount` BIGINT NOT NULL,
  `is_active` TINYINT DEFAULT '1',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `food_package_id` (`food_package_id`),
  KEY `products_id` (`products_id`),
  CONSTRAINT `food_package_products_ibfk_1` FOREIGN KEY (`food_package_id`) REFERENCES `food_package` (`id`) ON DELETE CASCADE,
  CONSTRAINT `food_package_products_ibfk_2` FOREIGN KEY (`products_id`) REFERENCES `product` (`id`) ON DELETE CASCADE
);

INSERT INTO product (
    `ean`,
    `name`,
    `stock`
)
VALUES
    ('1234567890123', 'Appel', 20),
    ('9876543210987', 'Banaan', 20),
    ('4567890123456', 'Sinaasappel', 20),
    ('6543210987653', 'Wortel', 20),
    ('9876543210123', 'Broccoli', 20),
    ('3210987654321', 'Aardappel', 20),
    ('5432109876543', 'Komkommer', 20),
    ('8765432109876', 'Tomato', 20),
    ('2109876543210', 'Ui', 20),
    ('4321098765432', 'Paprika', 20),
    ('6543210123456', 'Perzik', 20),
    ('8765432101234', 'Meloen', 20),
    ('1098765432109', 'Druiven', 20),
    ('3210123456789', 'Ananas', 20),
    ('5432109873498', 'Kiwi', 20),
    ('7654321098765', 'Mango', 20),
    ('9876543210124', 'Peer', 20),
    ('1231241325211', 'Aardbei', 20),
    ('4321098365432', 'Kers', 20),
    ('6543210987654', 'Pruim', 20);

INSERT INTO category (
    `name`,
    `description`
)
VALUES
    ('Verse producten', 'Aardappelen, groente, fruit'),
    ('Delicatessen', 'Kaas, vleeswaren'),
    ('Zuivelalternatieven', 'Zuivel, plantaardig en eieren'),
    ('Bakkerijproducten', 'Bakkerij en banket'),
    ('Dranken', 'Frisdrank, sappen, koffie en thee'),
    ('Wereldkeuken', 'Pasta, rijst en wereldkeuken'),
    ('Smaakmakers', 'Soepen, sauzen, kruiden en olie'),
    ('Snacks', 'Snoep, koek, chips en chocolade'),
    ('Babyproducten', 'Baby, verzorging en hygiÃ«ne');

INSERT INTO preference (
    `name`
)
VALUES
    ('Varkens vlees'),
    ('Veganistisch'),
    ('Vegatarisch');

INSERT INTO `product_categories` (`product_id`, `cetegory_id`) VALUES
    (1, 1), -- Appel behoort tot de categorie "Verse producten"
    (2, 1), -- Banaan behoort tot de categorie "Verse producten"
    (3, 1), -- Sinaasappel behoort tot de categorie "Verse producten"
    (4, 1), -- Wortel behoort tot de categorie "Verse producten"
    (5, 1), -- Broccoli behoort tot de categorie "Verse producten"
    (6, 1), -- Aardappel behoort tot de categorie "Verse producten"
    (7, 1), -- Komkommer behoort tot de categorie "Verse producten"
    (8, 1), -- Tomato behoort tot de categorie "Verse producten"
    (9, 1), -- Ui behoort tot de categorie "Verse producten"
    (10, 1), -- Paprika behoort tot de categorie "Verse producten"
    (11, 1), -- Perzik behoort tot de categorie "Verse producten"
    (12, 1), -- Meloen behoort tot de categorie "Verse producten"
    (13, 1), -- Druiven behoort tot de categorie "Verse producten"
    (14, 1), -- Ananas behoort tot de categorie "Verse producten"
    (15, 1), -- Kiwi behoort tot de categorie "Verse producten"
    (16, 1), -- Mango behoort tot de categorie "Verse producten"
    (17, 1), -- Peer behoort tot de categorie "Verse producten"
    (18, 1), -- Aardbei behoort tot de categorie "Verse producten"
    (19, 1), -- Kers behoort tot de categorie "Verse producten"
    (20, 1); -- Pruim behoort tot de categorie "Verse producten"

INSERT INTO `allergy` (`name`, `description`) VALUES
    ('Gluten', 'Glutenallergie is een overgevoeligheidsreactie op gluten, een eiwit dat voorkomt in tarwe, gerst, rogge en spelt. Mensen met een glutenallergie moeten producten vermijden die deze granen bevatten.'),
    ('Lactose', 'Lactose-intolerantie treedt op wanneer het lichaam niet in staat is om lactose, een suiker die voorkomt in melk en zuivelproducten, af te breken. Mensen met lactose-intolerantie ervaren vaak spijsverteringsproblemen na het consumeren van lactose.'),
    ('Noten', 'Een notenallergie is een overgevoeligheidsreactie op noten, zoals amandelen, hazelnoten, walnoten, cashewnoten en pistachenoten. Het consumeren van noten kan ernstige allergische reacties veroorzaken, variÃ«rend van milde symptomen tot levensbedreigende reacties.'),
    ('Pinda', 'Een pinda-allergie is een allergische reactie op pindas, die eigenlijk peulvruchten zijn en geen noten. Pinda-allergieÃ«n kunnen ernstige allergische reacties veroorzaken, inclusief anafylaxie, een levensbedreigende reactie.'),
    ('Schaaldieren', 'Een allergie voor schaaldieren, zoals garnalen, krabben, kreeften en mosselen, kan allergische reacties veroorzaken die variÃ«ren van milde jeuk en zwelling tot ernstige ademhalingsproblemen en anafylaxie.'),
    ('Selderij', 'Selderij-allergie is een overgevoeligheidsreactie op selderij, een groente die veel voorkomt in salades, soepen en stoofschotels. Symptomen van een selderij-allergie kunnen variÃ«ren van jeuk en zwelling tot ademhalingsproblemen.'),
    ('Sesamzaad', 'Sesamzaad-allergie is een overgevoeligheidsreactie op sesamzaad, dat veel wordt gebruikt in brood, bagels, hummus en andere voedingsmiddelen. Een allergische reactie op sesamzaad kan variÃ«ren van milde symptomen tot ernstige anafylaxie.'),
    ('Soja', 'Soja-allergie is een allergische reactie op sojaproducten, zoals tofu, sojasaus, tempeh en sojamelk. Mensen met een soja-allergie kunnen symptomen ervaren variÃ«rend van milde huiduitslag en maagklachten tot ernstige ademhalingsproblemen.'),
    ('Vis', 'Een visallergie is een overgevoeligheidsreactie op vis, zoals zalm, tonijn, kabeljauw en forel. Blootstelling aan vis kan allergische symptomen veroorzaken, variÃ«rend van milde jeuk en zwelling tot ernstige ademhalingsproblemen.'),
    ('Weekdieren', 'Een allergie voor weekdieren, zoals oesters, mosselen, inktvissen en slakken, kan allergische reacties veroorzaken die variÃ«ren van milde symptomen zoals jeuk en zwelling tot ernstige ademhalingsproblemen.'),
    ('Zwaveldioxide en sulfiet', 'Een allergie voor zwaveldioxide en sulfiet kan optreden bij het consumeren van voedingsmiddelen en dranken die deze stoffen bevatten als conserveermiddelen. Symptomen kunnen variÃ«ren van huiduitslag en ademhalingsproblemen tot ernstige allergische reacties bij gevoelige individuen.');

INSERT INTO supplier (name, image) VALUES
  ('Albert Heijn', 'https://i.pinimg.com/originals/51/72/f7/5172f710fb2eb5589229f0e0945e008a.jpg'),
  ('C1000', 'https://upload.wikimedia.org/wikipedia/commons/a/ad/C1000_logo.jpg'),
  ('Jumbo', 'https://www.ovberghem.nl/uploads/media/leden/logos/jumbo.jpg'),
  ('Aldi', 'https://www.aldi.nl/etc/designs/aldi/web/frontend/aldi/images/app/app-icon.svg.res/1638343053258/app-icon.svg'),
  ('Lidl', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Lidl-Logo.svg/800px-Lidl-Logo.svg.png');

INSERT INTO address (supplier_id, name, street, zipcode, city) VALUES
  (1, 'Albert Heijn', 'Middenburcht 14', '3452 MT', 'Utrecht'),
  (2, 'C1000', 'Houtrakgracht 349', '3544 EB', 'Utrecht'),
  (3, 'Jumbo', 'Julianalaan 2', '3417 GK', 'Montfoort'),
  (4, 'Aldi', 'Lanxmeersestraat 17', '4103 XL', 'Culemborg'),
  (5, 'Lidl', 'Kauwenhof 1', '3435 SN', 'Nieuwegein');

INSERT INTO customer (adults, children, babies) VALUES 
  ('2', '0', '2'),
  ('1', '1', '0'),
  ('2', '2', '1'),
  ('1', '0', '1'),
  ('2', '2', '0');

INSERT INTO food_package (
  `customer_id`
)
VALUES
  (1),
  (2),
  (3),
  (4),
  (5);

INSERT INTO contact_details (supplier_id , name , email , phone_number)
VALUES
("1", "Walter White", "walterwhiteah@gmail.com", "0678541987"),
("2", "Gustavo Fring", "gustavofringc1000@gmail.com", "0678541258"),
("3", "Jesse Pinkman", "jessepinkmanjumbo@gmail.com", "0678437241"),
("4", "Hector Salamanca", "hectorsalamancaaldi@gmail.com", "061294521"),
("5", "Walt Jr White", "waltjrwhitelidl@gmail.com", "0645679321");


  -- stored procedures

DELIMITER //
CREATE PROCEDURE create_supplier(
  IN name VARCHAR(255),
  IN image VARCHAR(255),
  IN street VARCHAR(255),
  IN zipcode VARCHAR(255),
  IN city VARCHAR(255),
  IN contact_name VARCHAR(255),
  IN contact_email VARCHAR(255),
  IN contact_phone_number VARCHAR(255)
)
BEGIN
  DECLARE supplier_id BIGINT;
  DECLARE address_id BIGINT;
  DECLARE contact_details_id BIGINT;

  INSERT INTO supplier (name, image) VALUES (name, image);
  SET supplier_id = LAST_INSERT_ID();

  INSERT INTO address (supplier_id, name, street, zipcode, city) VALUES (supplier_id, name, street, zipcode, city);
  SET address_id = LAST_INSERT_ID();

  INSERT INTO contact_details (supplier_id, name, email, phone_number) VALUES (supplier_id, contact_name, contact_email, contact_phone_number);
  SET contact_details_id = LAST_INSERT_ID();

  SELECT supplier_id, address_id, contact_details_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `update_supplier`(
  IN supplierId INT,
  IN supplierName VARCHAR(255),
  IN supplierImage VARCHAR(255),
  IN addressName VARCHAR(255),
  IN street VARCHAR(255),
  IN zipcode VARCHAR(255),
  IN city VARCHAR(255),
  IN contactName VARCHAR(255),
  IN email VARCHAR(255),
  IN phoneNumber VARCHAR(255)
)
BEGIN
  START TRANSACTION;
  
  -- Update the supplier table
  UPDATE `supplier`
  SET `name` = supplierName, `image` = supplierImage
  WHERE `id` = supplierId;

  -- Update the address table
  UPDATE `address`
  SET `name` = addressName, `street` = street, `zipcode` = zipcode, `city` = city
  WHERE `supplier_id` = supplierId;

  -- Update the contact_details table
  UPDATE `contact_details`
  SET `name` = contactName, `email` = email, `phone_number` = phoneNumber
  WHERE `supplier_id` = supplierId;

  COMMIT;
END //
DELIMITER ;

