-- MySQL Script generated by MySQL Workbench
-- Wed Sep 29 17:34:55 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema concert.ua
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema concert.ua
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `concert.ua` DEFAULT CHARACTER SET utf8 ;
USE `concert.ua` ;

-- -----------------------------------------------------
-- Table `concert.ua`.`type_of_event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `concert.ua`.`type_of_event`;
CREATE TABLE `concert.ua`.`type_of_event` (
                                              `id` INT NOT NULL AUTO_INCREMENT,
                                              `name` VARCHAR(20) NOT NULL,
                                              `type_of_event_description` VARCHAR(150) NULL,
                                              PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `concert.ua`.`artist_or_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `concert.ua`.`artist_or_group`;
CREATE TABLE`concert.ua`.`artist_or_group` (
                                               `id` INT NOT NULL AUTO_INCREMENT,
                                               `name` VARCHAR(45) NOT NULL,
                                               `artist_description` VARCHAR(45) NULL,
                                               PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `concert.ua`.`event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `concert.ua`.`event`;
CREATE TABLE `concert.ua`.`event` (
                                      `id` INT NOT NULL AUTO_INCREMENT,
                                      `type_of_event_id` INT NOT NULL,
                                      `artist_or_group_id` INT NULL,
                                      `data` DATETIME NOT NULL,
                                      `duration` VARCHAR(10) NOT NULL,
                                      `description` VARCHAR(45) NULL,
                                      `max_seats_available` INT NOT NULL,
                                      PRIMARY KEY (`id`),
                                      INDEX `fk_event_type_of_event1_idx` (`type_of_event_id` ASC) VISIBLE,
                                      INDEX `fk_event_artist_or_group1_idx` (`artist_or_group_id` ASC) VISIBLE,
                                      CONSTRAINT `fk_event_type_of_event1`
                                          FOREIGN KEY (`type_of_event_id`)
                                              REFERENCES `concert.ua`.`type_of_event` (`id`)
                                              ON DELETE NO ACTION
                                              ON UPDATE NO ACTION,
                                      CONSTRAINT `fk_event_artist_or_group1`
                                          FOREIGN KEY (`artist_or_group_id`)
                                              REFERENCES `concert.ua`.`artist_or_group` (`id`)
                                              ON DELETE NO ACTION
                                              ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `concert.ua`.`transaction`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `concert.ua`.`transaction`;
CREATE TABLE `concert.ua`.`transaction` (
                                            `id` INT NOT NULL AUTO_INCREMENT,
                                            `data_of_transaction` DATETIME NOT NULL,
                                            `sum` INT NOT NULL,
                                            `discount_in_percent` INT NULL,
                                            `status_of_transaction` VARCHAR(20) NOT NULL,
                                            PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `concert.ua`.`destination_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `concert.ua`.`destination_address`;
CREATE TABLE`concert.ua`.`destination_address` (
                                                   `id` INT NOT NULL AUTO_INCREMENT,
                                                   `region` VARCHAR(45) NOT NULL,
                                                   `city_village` VARCHAR(45) NOT NULL,
                                                   `street` VARCHAR(45) NULL,
                                                   `building` VARCHAR(45) NULL,
                                                   `flat` VARCHAR(45) NULL,
                                                   PRIMARY KEY (`id`))
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `concert.ua`.`type_of_delivery`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `concert.ua`.`type_of_delivery`;
CREATE TABLE `concert.ua`.`type_of_delivery` (
                                                 `id` INT NOT NULL AUTO_INCREMENT,
                                                 `type` VARCHAR(45) NOT NULL,
                                                 `delivery_description` VARCHAR(45) NULL,
                                                 PRIMARY KEY (`id`),
                                                 INDEX `type`(`type`ASC) VISIBLE,
                                                 INDEX `delivery_description`(`delivery_description`ASC) VISIBLE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `concert.ua`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `concert.ua`.`order`;
CREATE TABLE `concert.ua`.`order` (
                                      `id` INT NOT NULL AUTO_INCREMENT,
                                      `destination_address_id` INT NOT NULL,
                                      `type_of_delivery_id` INT NOT NULL,
                                      PRIMARY KEY (`id`),
                                      INDEX `fk_order_destination_address1_idx` (`destination_address_id` ASC) VISIBLE,
                                      INDEX `fk_order_type_of_delivery1_idx` (`type_of_delivery_id` ASC) VISIBLE,
                                      CONSTRAINT `fk_order_destination_address1`
                                          FOREIGN KEY (`destination_address_id`)
                                              REFERENCES `concert.ua`.`destination_address` (`id`)
                                              ON DELETE NO ACTION
                                              ON UPDATE NO ACTION,
                                      CONSTRAINT `fk_order_type_of_delivery1`
                                          FOREIGN KEY (`type_of_delivery_id`)
                                              REFERENCES `concert.ua`.`type_of_delivery` (`id`)
                                              ON DELETE NO ACTION
                                              ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `concert.ua`.`ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `concert.ua`.`ticket`;
CREATE TABLE `concert.ua`.`ticket` (
                                       `id` INT NOT NULL AUTO_INCREMENT,
                                       `event_id` INT NOT NULL,
                                       `order_id` INT NOT NULL,
                                       `transaction_id` INT NOT NULL,
                                       PRIMARY KEY (`id`),
                                       INDEX `fk_ticket_event1_idx` (`event_id` ASC) VISIBLE,
                                       INDEX `fk_ticket_transaction1_idx` (`transaction_id` ASC) VISIBLE,
                                       INDEX `fk_ticket_order1_idx` (`order_id` ASC) VISIBLE,
                                       UNIQUE INDEX `event_id_UNIQUE` (`event_id` ASC) VISIBLE,
                                       UNIQUE INDEX `transaction_id_UNIQUE` (`transaction_id` ASC) VISIBLE,
                                       UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
                                       CONSTRAINT `fk_ticket_event1`
                                           FOREIGN KEY (`event_id`)
                                               REFERENCES `concert.ua`.`event` (`id`)
                                               ON DELETE NO ACTION
                                               ON UPDATE NO ACTION,
                                       CONSTRAINT `fk_ticket_transaction1`
                                           FOREIGN KEY (`transaction_id`)
                                               REFERENCES `concert.ua`.`transaction` (`id`)
                                               ON DELETE NO ACTION
                                               ON UPDATE NO ACTION,
                                       CONSTRAINT `fk_ticket_order1`
                                           FOREIGN KEY (`order_id`)
                                               REFERENCES `concert.ua`.`order` (`id`)
                                               ON DELETE NO ACTION
                                               ON UPDATE NO ACTION)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Population script
-- -----------------------------------------------------
-- artist_or_group

INSERT INTO `concert.ua`.artist_or_group (`id`,`name`,`artist_description`) VALUES (1,'Kanye West','Rapper');
INSERT INTO `concert.ua`.artist_or_group (`id`,`name`,`artist_description`) VALUES (2,'Justin Bieber','Singer');
INSERT INTO `concert.ua`.artist_or_group (`id`,`name`,`artist_description`) VALUES (3,'Eminem','Rapper');
INSERT INTO `concert.ua`.artist_or_group (`id`,`name`,`artist_description`) VALUES (4,'The Weeknd','Singer');
INSERT INTO `concert.ua`.artist_or_group (`id`,`name`,`artist_description`) VALUES (5,'Nirvana','Rock-group');
INSERT INTO `concert.ua`.artist_or_group (`id`,`name`,`artist_description`) VALUES (6,'Queen','Rock-group');
INSERT INTO `concert.ua`.artist_or_group (`id`,`name`,`artist_description`) VALUES (7,'Travis Scott','Rapper');
INSERT INTO `concert.ua`.artist_or_group (`id`,`name`,`artist_description`) VALUES (8,'Coldplay','Rock-group');
INSERT INTO `concert.ua`.artist_or_group (`id`,`name`,`artist_description`) VALUES (9,'David Guetta','DJ');
INSERT INTO `concert.ua`.artist_or_group (`id`,`name`,`artist_description`) VALUES (10,'Post Malone','Rapper');


-- destination_address

INSERT INTO `concert.ua`.destination_address (`id`,`region`,`city_village`,`street`,`building`,`flat`) VALUES (1,'Lviv','Lviv','Stryyska','144','67');
INSERT INTO `concert.ua`.destination_address (`id`,`region`,`city_village`,`street`,`building`,`flat`) VALUES (2,'Lviv','Lviv','Skoryny','7','3');
INSERT INTO `concert.ua`.destination_address (`id`,`region`,`city_village`,`street`,`building`,`flat`) VALUES (3,'Lviv','Lviv','Rubchaka','2','18');
INSERT INTO `concert.ua`.destination_address (`id`,`region`,`city_village`,`street`,`building`,`flat`) VALUES (4,'Lviv','Lviv','Zamarstynivska','3a','140');
INSERT INTO `concert.ua`.destination_address (`id`,`region`,`city_village`,`street`,`building`,`flat`) VALUES (5,'Kyiv','Kyiv','Antonovycha','19','4');
INSERT INTO `concert.ua`.destination_address (`id`,`region`,`city_village`,`street`,`building`,`flat`) VALUES (6,'Lviv','Lviv','Lubinska','15','72');
INSERT INTO `concert.ua`.destination_address (`id`,`region`,`city_village`,`street`,`building`,`flat`) VALUES (7,'Lviv','Lviv','Zelena','1','90');
INSERT INTO `concert.ua`.destination_address (`id`,`region`,`city_village`,`street`,`building`,`flat`) VALUES (8,'Lviv','Lviv','Franka','24','25');
INSERT INTO `concert.ua`.destination_address (`id`,`region`,`city_village`,`street`,`building`,`flat`) VALUES (9,'Lviv','Lviv','Naukova','20','17');
INSERT INTO `concert.ua`.destination_address (`id`,`region`,`city_village`,`street`,`building`,`flat`) VALUES (10,'Odessa','Odessa','Lvivska','12','35');

-- type_of_event

INSERT INTO `concert.ua`.type_of_event (`id`,`name`,`type_of_event_description`) VALUES (1,'Festival','An event ordinarily celebrated by a community and centering on some characteristic aspect of that community and its religion or cultures');
INSERT INTO `concert.ua`.type_of_event (`id`,`name`,`type_of_event_description`) VALUES (2,'Concert','Live music performance in front of an audience');
INSERT INTO `concert.ua`.type_of_event (`id`,`name`,`type_of_event_description`) VALUES (3,'Theatre play','A work of drama, usually consisting mostly of dialogue between characters and intended for theatrical performance rather than just reading');
INSERT INTO `concert.ua`.type_of_event (`id`,`name`,`type_of_event_description`) VALUES (4,'Performance for kids',NULL);

-- type_of_delivery

INSERT INTO `concert.ua`.type_of_delivery (`id`,`type`,`delivery_description`) VALUES (1,'Post','Nova Poshta');
INSERT INTO `concert.ua`.type_of_delivery (`id`,`type`,`delivery_description`) VALUES (2,'Courier',NULL);
INSERT INTO `concert.ua`.type_of_delivery (`id`,`type`,`delivery_description`) VALUES (3,'Self-pickup','You take your ticket by yourself');

-- event

INSERT INTO `concert.ua`.event (`id`,`type_of_event_id`,`artist_or_group_id`,`data`,`duration`,`description`,`max_seats_available`) VALUES (1,1,5,'2030-10-20 21:00:00','6 hours','Shiged rock-festival',30000);
INSERT INTO `concert.ua`.event (`id`,`type_of_event_id`,`artist_or_group_id`,`data`,`duration`,`description`,`max_seats_available`) VALUES (2,2,1,'2022-05-11 17:30:00','3 hours','Concert in the Wembley',70000);
INSERT INTO `concert.ua`.event (`id`,`type_of_event_id`,`artist_or_group_id`,`data`,`duration`,`description`,`max_seats_available`) VALUES (3,2,2,'2025-06-18 14:00:00','2 hours','Solo concert in Malevich',4000);
INSERT INTO `concert.ua`.event (`id`,`type_of_event_id`,`artist_or_group_id`,`data`,`duration`,`description`,`max_seats_available`) VALUES (4,3,NULL,'2025-06-18 16:00:00','3 hours','Theatre play in Lviv Opera',2000);
INSERT INTO `concert.ua`.event (`id`,`type_of_event_id`,`artist_or_group_id`,`data`,`duration`,`description`,`max_seats_available`) VALUES (5,4,NULL,'2023-01-01 18:00:00','1 hour','Performance for kids in Theatre of Zankovecka',1000);
INSERT INTO `concert.ua`.event (`id`,`type_of_event_id`,`artist_or_group_id`,`data`,`duration`,`description`,`max_seats_available`) VALUES (6,1,6,'2027-08-22 20:00:00','4 hours','Festival of rock',30000);
INSERT INTO `concert.ua`.event (`id`,`type_of_event_id`,`artist_or_group_id`,`data`,`duration`,`description`,`max_seats_available`) VALUES (7,2,4,'2024-11-12 13:00:00','2 hours','Concert in Chicago stadium',40000);
INSERT INTO `concert.ua`.event (`id`,`type_of_event_id`,`artist_or_group_id`,`data`,`duration`,`description`,`max_seats_available`) VALUES (8,3,NULL,'2028-05-01 11:00:00','1 hours','Theatre play Solomia Krushelnytska Theatre',1500);
INSERT INTO `concert.ua`.event (`id`,`type_of_event_id`,`artist_or_group_id`,`data`,`duration`,`description`,`max_seats_available`) VALUES (9,2,10,'2026-12-13 15:30:00','3 hours','Concert in Arena Lviv',35000);
INSERT INTO `concert.ua`.event (`id`,`type_of_event_id`,`artist_or_group_id`,`data`,`duration`,`description`,`max_seats_available`) VALUES (10,2,9,'2023-04-17 19:00:00','3 hours','Concert in Ibiza night club',20000);

-- order

INSERT INTO `concert.ua`.order (`id`,`type_of_delivery_id`,`destination_address_id`) VALUES (1,1,1);
INSERT INTO `concert.ua`.order (`id`,`type_of_delivery_id`,`destination_address_id`) VALUES (2,2,2);
INSERT INTO `concert.ua`.order (`id`,`type_of_delivery_id`,`destination_address_id`) VALUES (3,3,3);
INSERT INTO `concert.ua`.order (`id`,`type_of_delivery_id`,`destination_address_id`) VALUES (4,1,4);
INSERT INTO `concert.ua`.order (`id`,`type_of_delivery_id`,`destination_address_id`) VALUES (5,2,5);
INSERT INTO `concert.ua`.order (`id`,`type_of_delivery_id`,`destination_address_id`) VALUES (6,3,6);
INSERT INTO `concert.ua`.order (`id`,`type_of_delivery_id`,`destination_address_id`) VALUES (7,1,7);
INSERT INTO `concert.ua`.order (`id`,`type_of_delivery_id`,`destination_address_id`) VALUES (8,2,8);
INSERT INTO `concert.ua`.order (`id`,`type_of_delivery_id`,`destination_address_id`) VALUES (9,3,9);
INSERT INTO `concert.ua`.order (`id`,`type_of_delivery_id`,`destination_address_id`) VALUES (10,1,10);


-- transaction

INSERT INTO `concert.ua`.transaction (`id`,`data_of_transaction`,`sum`,`discount_in_percent`,`status_of_transaction`) VALUES (1,'2019-11-12 13:53:11',1500,15,'Done');
INSERT INTO `concert.ua`.transaction (`id`,`data_of_transaction`,`sum`,`discount_in_percent`,`status_of_transaction`) VALUES (2,'2020-11-12 03:07:58',4000,NULL,'In progress');
INSERT INTO `concert.ua`.transaction (`id`,`data_of_transaction`,`sum`,`discount_in_percent`,`status_of_transaction`) VALUES (3,'2021-11-12 18:13:32',5000,NULL,'Not Started');
INSERT INTO `concert.ua`.transaction (`id`,`data_of_transaction`,`sum`,`discount_in_percent`,`status_of_transaction`) VALUES (4,'2018-11-12 13:30:20',400,NULL,'Done');
INSERT INTO `concert.ua`.transaction (`id`,`data_of_transaction`,`sum`,`discount_in_percent`,`status_of_transaction`) VALUES (5,'2019-11-12 22:16:13',600,NULL,'Done');
INSERT INTO `concert.ua`.transaction (`id`,`data_of_transaction`,`sum`,`discount_in_percent`,`status_of_transaction`) VALUES (6,'2020-11-12 14:45:48',1200,25,'Done');
INSERT INTO `concert.ua`.transaction (`id`,`data_of_transaction`,`sum`,`discount_in_percent`,`status_of_transaction`) VALUES (7,'2020-11-12 07:49:23',700,NULL,'Not Started');
INSERT INTO `concert.ua`.transaction (`id`,`data_of_transaction`,`sum`,`discount_in_percent`,`status_of_transaction`) VALUES (8,'2021-11-12 11:56:17',900,10,'Done');
INSERT INTO `concert.ua`.transaction (`id`,`data_of_transaction`,`sum`,`discount_in_percent`,`status_of_transaction`) VALUES (9,'2020-11-12 17:14:46',750,NULL,'In progress');
INSERT INTO `concert.ua`.transaction (`id`,`data_of_transaction`,`sum`,`discount_in_percent`,`status_of_transaction`) VALUES (10,'2021-11-12 10:17:24',650,NULL,'Done');

-- ticket

INSERT INTO `concert.ua`.ticket (`id`,`event_id`,`order_id`,`transaction_id`) VALUES (NULL,1,5,10);
INSERT INTO `concert.ua`.ticket (`id`,`event_id`,`order_id`,`transaction_id`) VALUES (NULL,2,4,9);
INSERT INTO `concert.ua`.ticket (`id`,`event_id`,`order_id`,`transaction_id`) VALUES (NULL,3,3,8);
INSERT INTO `concert.ua`.ticket (`id`,`event_id`,`order_id`,`transaction_id`) VALUES (NULL,4,2,7);
INSERT INTO `concert.ua`.ticket (`id`,`event_id`,`order_id`,`transaction_id`) VALUES (NULL,5,1,6);
INSERT INTO `concert.ua`.ticket (`id`,`event_id`,`order_id`,`transaction_id`) VALUES (NULL,6,10,5);
INSERT INTO `concert.ua`.ticket (`id`,`event_id`,`order_id`,`transaction_id`) VALUES (NULL,7,9,4);
INSERT INTO `concert.ua`.ticket (`id`,`event_id`,`order_id`,`transaction_id`) VALUES (NULL,8,8,3);
INSERT INTO `concert.ua`.ticket (`id`,`event_id`,`order_id`,`transaction_id`) VALUES (NULL,9,7,2);
INSERT INTO `concert.ua`.ticket (`id`,`event_id`,`order_id`,`transaction_id`) VALUES (NULL,10,6,1);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;