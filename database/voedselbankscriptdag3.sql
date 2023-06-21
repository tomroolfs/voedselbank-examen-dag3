DROP DATABASE IF EXISTS `voedselbank3`;
CREATE DATABASE `voedselbank3`;
USE `voedselbank3`;

CREATE TABLE `eetwens`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `naam` VARCHAR(255) NOT NULL,
    `omschrijving` VARCHAR(255) NOT NULL,
    `is_active` TINYINT DEFAULT '1',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `voedselpakket`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `gezin_id` BIGINT NOT NULL,
    `pakketnummer` BIGINT NOT NULL,
    `datumsamengesteld` DATE NOT NULL,
    `datumuitgifte` DATE NULL,
    `status` VARCHAR(255) NOT NULL,
    `is_active` TINYINT DEFAULT '1',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `persoon`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `gezin_id` BIGINT NULL,
    `voornaam` VARCHAR(255) NOT NULL,
    `tussenvoegsel` VARCHAR(255) NULL,
    `achternaam` VARCHAR(255) NOT NULL,
    `geboortedatum` DATE NOT NULL,
    `typepersoon` VARCHAR(255) NOT NULL,
    `isvertegenwoordiger` TINYINT(1) NOT NULL,
    `is_active` TINYINT DEFAULT '1',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `eetwenspergezin`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `gezin_id` BIGINT NOT NULL,
    `eetwens_id` BIGINT NOT NULL
);
CREATE TABLE `productpervoedselpakket`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `voedselpakket_id` BIGINT NOT NULL,
    `product_id` BIGINT NOT NULL,
    `aantalproducteenheden` BIGINT NOT NULL,
    `is_active` TINYINT DEFAULT '1',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE `gezin`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `naam` VARCHAR(255) NOT NULL,
    `code` VARCHAR(25) NOT NULL,
    `omschrijving` VARCHAR(255) NOT NULL,
    `aantalvolwassenen` BIGINT NOT NULL,
    `aantalkinderen` BIGINT NOT NULL,
    `aantalbabys` BIGINT NOT NULL,
    `totaalaantalpersonen` BIGINT NOT NULL,
    `is_active` TINYINT DEFAULT '1',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
ALTER TABLE
    `eetwenspergezin` ADD CONSTRAINT `eetwenspergezin_gezin_id_foreign` FOREIGN KEY(`gezin_id`) REFERENCES `gezin`(`id`);
ALTER TABLE
    `persoon` ADD CONSTRAINT `persoon_gezin_id_foreign` FOREIGN KEY(`gezin_id`) REFERENCES `gezin`(`id`);
ALTER TABLE
    `productpervoedselpakket` ADD CONSTRAINT `productpervoedselpakket_id_foreign` FOREIGN KEY(`id`) REFERENCES `voedselpakket`(`id`);
ALTER TABLE
    `voedselpakket` ADD CONSTRAINT `voedselpakket_gezin_id_foreign` FOREIGN KEY(`gezin_id`) REFERENCES `gezin`(`id`);
ALTER TABLE
    `eetwenspergezin` ADD CONSTRAINT `eetwenspergezin_eetwens_id_foreign` FOREIGN KEY(`eetwens_id`) REFERENCES `eetwens`(`id`);
    
    INSERT INTO gezin (naam, code, omschrijving, aantalvolwassenen, aantalkinderen, aantalbabys, totaalaantalpersonen)
VALUES
    ('ZevenhuizenGezin','G0001','Bijstandsgezin','2','2','0','4'),
    ('BergkampGezin','G0002','Bijstandsgezin','2','1','1','4'),
    ('HeuvelkampGezin','G0003','Bijstandsgezin','2','0','0','2'),
    ('ScherderGezin','G0004','Bijstandsgezin','1','0','2','3'),
    ('DeJongGezin','G0005','Bijstandsgezin','1','1','0','2'),
    ('VanderBergGezin','G0006','AlleenGaande','1','0','0','1');
    
        INSERT INTO persoon (gezin_id, voornaam, tussenvoegsel, achternaam, geboortedatum, typepersoon, isvertegenwoordiger)
VALUES
    (NULL ,'Hans','van','Leeuwen','1958-02-12','Manager','0'),
    (NULL ,'Jan','van der','Sluijs','1993-04-30','Medewerker','0'),
    (NULL ,'Herman','den','Duiker','1989-08-30','Vrijwilliger','0'),
    ('1','Johan','van','Zevenhuizen','1990-05-20','Klant','1'),
    ('1','Sarah','den','Dolder','1985-03-23','Klant','0'),
    ('1','Theo','van','Zevenhuizen','2015-03-08','Klant','0'),
    ('1','Jantien','van','Zevenhuizen','2016-09-10','Klant','0'),
    ('2','Arjan','','Bergkamp','1968-07-12','Klant','1'),
    ('2','Janneke','','Sanders','1969-05-11','Klant','0'),
    ('2','Stein','','Bergkamp','2009-02-02','Klant','0'),
    ('2','Judith','','Bergkamp','2022-02-05','Klant','0'),
    ('3','Mazin','van','Vliet','1968-08-18','Klant','0'),
    ('3','Selma','van de','Heuvel','1965-09-05','Klant','1'),
    ('4','Eva','','Scherder','2000-04-07','Klant','1'),
    ('4','Felicia','','Scherder','2021-11-29','Klant','0'),
    ('4','Devin','','Scherder','2023-03-01','Klant','0'),
    ('5','Frieda','de','Jong','1980-09-04','Klant','1'),
    ('5','Simeon','de','Jong','2018-05-023','Klant','0'),
    ('6','Hanna','van der','Berg','1999-09-09','Klant','1');
    
        INSERT INTO eetwens (naam, omschrijving)
VALUES
    ('GeenVarken','Geen varkensvlees'),
    ('Veganistisch','Geen zuivelproducten en vlees'),
    ('Vegetarisch','Geen vlees'),
    ('Omnivoor','Geen beperkingen');
    
            INSERT INTO eetwenspergezin (gezin_id, eetwens_id)
VALUES
    ('1','2'),
    ('2','4'),
    ('3','4'),
    ('4','3'),
	('5','2');
    
                INSERT INTO voedselpakket (gezin_id, pakketnummer, datumsamengesteld, datumuitgifte, status)
VALUES
    ('1','1', '2023-04-06','2023-04-07', 'Uitgereikt'),
    ('1','2', '2023-04-13', NULL , 'NietUitgereikt'),
    ('1','3', '2023-04-20',NULL , 'NietUitgereikt'),
    ('2','4', '2023-04-06','2023-04-07', 'Uitgereikt'),
    ('2','5', '2023-04-13','2023-04-14', 'Uitgereikt'),
    ('2','6', '2023-04-20',NULL , 'NietUitgereikt');
    
                    INSERT INTO productpervoedselpakket (voedselpakket_id, product_id, aantalproducteenheden)
VALUES
    ('1','7', '1'),
    ('1','8', '2'),
    ('1','9', '1'),
    ('2','12', '1'),
    ('2','13', '2'),
    ('2','14', '1'),
    ('3','3', '1'),
    ('3','4', '1'),
    ('4','20', '1'),
    ('4','19', '1'),
    ('4','21', '1'),
    ('5','24', '1'),
    ('5','25', '1'),
    ('5','26', '1'),
    ('6','28', '1'),
    ('6','29', '1'),
    ('6','27', '1'),
    ('6','26', '1');