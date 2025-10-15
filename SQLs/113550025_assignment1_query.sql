\encoding UTF8

-- Question 1:
SELECT set_num, name, num_parts FROM sets
WHERE year = 2011
ORDER BY num_parts DESC;

-- Question 2:
SELECT year, COUNT(DISTINCT set_num)
FROM sets
WHERE year >= 2001 AND year <= 2005
GROUP BY year;

-- Question 3:
SELECT 
    parent_s.name AS parent_set_name,
    included_s.name AS included_set_name
FROM 
    inventory_sets AS inv_s
INNER JOIN
    inventories AS inv ON inv_s.inventory_id = inv.id
INNER JOIN
    sets AS parent_s ON inv.set_num = parent_s.set_num
INNER JOIN
    sets AS included_s ON inv_s.set_num = included_s.set_num
ORDER BY
    parent_s.name, included_s.name;

-- Question 4:
SELECT 
    s.name AS set_name,
    s.year,
    ct.name AS child_theme,
    pt.name AS parent_theme
FROM 
    sets AS s
JOIN 
    themes AS ct ON s.theme_id = ct.id
LEFT JOIN 
    themes AS pt ON ct.parent_id = pt.id
WHERE 
    pt.name LIKE 'Star Wars%' OR ct.name LIKE 'Star Wars%';

-- Question 5:
SELECT 
    pc.name AS category_name,
    SUM(ip.quantity) AS total_quantity
FROM part_categories AS pc
JOIN parts AS p ON pc.id = p.part_cat_id
JOIN inventory_parts AS ip ON p.part_num = ip.part_num
GROUP BY pc.name
HAVING SUM(ip.quantity) > 50000;

-- Question 6:
WITH each_theme AS (
    SELECT
        t.id AS theme_id,
        COUNT(sets.set_num) AS set_count
    FROM
        themes AS t
    JOIN sets
      ON t.id = sets.theme_id
    GROUP BY
        t.id
)
SELECT
    ParentTheme.name AS theme_name,
    SUM(each_theme.set_count) AS total_sets
FROM
    each_theme
INNER JOIN themes AS ChildTheme
  ON each_theme.theme_id = ChildTheme.id    
INNER JOIN themes AS ParentTheme
  ON (
    CASE WHEN ChildTheme.parent_id IS NOT NULL THEN ChildTheme.parent_id
    ELSE ChildTheme.id
    END
  ) = ParentTheme.id
GROUP BY
    ParentTheme.name
ORDER BY
    total_sets DESC
LIMIT 1; 

-- Question 7:
SELECT
  s.set_num,
  s.name,
  s.year,
  s.num_parts
FROM
  sets s
WHERE
  s.year = (
    SELECT
      year
    FROM
      sets
    GROUP BY
      year
    ORDER BY
      AVG(num_parts) DESC
    LIMIT 1
  );

-- Question 8:
SELECT 
    t.name AS theme_name,
    t.id AS theme_id
FROM 
    themes AS t
LEFT JOIN 
    sets ON t.id = sets.theme_id
WHERE
    sets.theme_id IS NULL;

-- Question 9:
SELECT
  c.name AS color_name,
  c.rgb AS color_rgb,
  SUM(ip.quantity) AS total_quantity,
  COUNT(DISTINCT iset.set_num) AS set_count
FROM
  colors AS c
INNER JOIN
  inventory_parts AS ip ON c.id = ip.color_id
INNER JOIN
  inventory_sets AS iset ON ip.inventory_id = iset.inventory_id
GROUP BY
  c.id,
  c.name,
  c.rgb
ORDER BY
  total_quantity DESC
LIMIT 5;

-- Bonus 1:
SELECT name, year
FROM 
    sets 
WHERE 
    name LIKE '%Castle%'
    AND name LIKE '%Dragon%';

-- Bonus 2:
SELECT
  (
    SELECT
      COUNT(*)
    FROM
      sets
  ) AS total_number_of_sets,
  (
    SELECT
      COUNT(DISTINCT part_num)
    FROM
      parts
  ) AS total_number_of_unique_parts,
  (
    SELECT
      COUNT(*)
    FROM
      themes
  ) AS total_number_of_themes,
  (
    SELECT
      ROUND(AVG(num_parts), 0)
    FROM
      sets
  ) AS average_parts_per_set;