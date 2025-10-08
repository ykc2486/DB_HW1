\set ON_ERROR_STOP on
\set ON_ERROR_ROLLBACK on

BEGIN;

-- 1. themes
\copy themes FROM './archive/themes.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 2. part_categories
\copy part_categories FROM './archive/part_categories.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 3. colors
\copy colors FROM './archive/colors.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 4. sets
\copy sets FROM './archive/sets.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 5. parts
\copy parts FROM './archive/parts.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 6. inventories
\copy inventories FROM './archive/inventories.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

-- 7. inventory_parts

\copy inventory_parts FROM './archive/inventory_parts.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');


-- 8. inventory_sets
\copy inventory_sets FROM './archive/inventory_sets.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COMMIT;

\set ON_ERROR_STOP off
\set ON_ERROR_ROLLBACK off
