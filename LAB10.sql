use sakila;

-- No.1
SELECT name,
  CASE
    WHEN name IN ('English', 'Italian', 'French', 'German') THEN 'latin1'
    WHEN name IN ('Japanese', 'Mandarin') THEN 'utf8'
    ELSE 'Unknown'
  END AS character_set
FROM language;

-- No.2
SELECT
  SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) AS G,
  SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) AS PG,
  SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) AS PG_13,
  SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) AS R,
  SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) AS NC_17
FROM film;

-- No.3
SELECT
  table_name,
  index_name
FROM information_schema.statistics
WHERE table_schema = 'sakila'
GROUP BY table_name, index_name;

-- No.4
SELECT
  'ALTER TABLE sakila.customer ADD INDEX ' AS statement,
  index_name,
  GROUP_CONCAT(column_name ORDER BY seq_in_index SEPARATOR ', ') AS column_list
FROM information_schema.statistics
WHERE table_schema = 'sakila' AND table_name = 'customer'
GROUP BY index_name;