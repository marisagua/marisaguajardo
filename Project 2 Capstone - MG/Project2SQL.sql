
# Splitting fact_film table into 3 JSON files for stream data
SELECT COUNT(*)/3 FROM sakila.fact_film;

SELECT * FROM sakila.fact_film
WHERE fact_film_key BETWEEN 1 AND 462;

SELECT * FROM sakila.fact_film
WHERE fact_film_key BETWEEN 463 AND 924;

SELECT * FROM sakila.fact_film
WHERE fact_film_key BETWEEN 925 AND 1386;

# Selecting dimension tables to export to batch 
SELECT * FROM sakila.dim_actor; # saved as JSON file

SELECT * FROM sakila.dim_category; #saved as CSV file

SELECT * FROM sakila.dim_date; # Not sure if this needs to be put here.. 
# lab 06 did not have dim_date in batch... pulled right from SQL

# Creating the dim_film table, still titled as film table
USE sakila;

CREATE TABLE `dim_film` (
  `film_key` smallint unsigned NOT NULL AUTO_INCREMENT,
  `film_id` smallint unsigned NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` text,
  `release_year` year DEFAULT NULL,
  `language_id` tinyint unsigned NOT NULL,
  `original_language_id` tinyint unsigned DEFAULT NULL,
  `rental_duration` tinyint unsigned NOT NULL DEFAULT '3',
  `rental_rate` decimal(4,2) NOT NULL DEFAULT '4.99',
  `length` smallint unsigned DEFAULT NULL,
  `replacement_cost` decimal(5,2) NOT NULL DEFAULT '19.99',
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT 'G',
  `special_features` set('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`film_key`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# Populate 
INSERT INTO `sakila`.`dim_film`
(`film_id`,
  `title`,
  `description`,
  `release_year`,
  `language_id`,
  `original_language_id`,
  `rental_duration`,
  `rental_rate`,
  `length`,
  `replacement_cost`,
  `rating`,
  `special_features`,
  `last_update`)
	SELECT `film_id`,
	`title`,
    `description`,
	`release_year`,
    `language_id`,
    `original_language_id`,
	`rental_duration`,
	`rental_rate`,
	`length`,
	`replacement_cost`,
	`rating`,
    `special_features`,
    `last_update`
FROM sakila.film;    
SELECT * FROM sakila.dim_film; 
