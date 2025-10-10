\encoding UTF8

-- Question 1:
SELECT COUNT(*) FROM sets WHERE year = 2011;

SELECT set_num, name, num_parts FROM sets
WHERE year = 2011
ORDER BY num_parts DESC
LIMIT 20;

-- Question 2:
SELECT year, COUNT(DISTINCT set_num)
FROM sets
WHERE year >= 2001 AND year <= 2005
GROUP BY year;

-- Question 3:
SELECT 
    COUNT(*) AS total_relationships
FROM 
    inventory_sets AS inv_s
INNER JOIN
    inventories AS inv ON inv_s.inventory_id = inv.id
INNER JOIN
    sets AS parent_s ON inv.set_num = parent_s.set_num
INNER JOIN
    sets AS included_s ON inv_s.set_num = included_s.set_num;

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
    parent_s.name, included_s.name
LIMIT 20;

-- Question 4:
SELECT 
    s.name AS set_name,
    s.year,
    ct.name AS child_theme,
    pt.name AS parent_theme,
       (SELECT COUNT(*)
        FROM sets AS s2
        JOIN themes AS ct2 ON s2.theme_id = ct2.id
        LEFT JOIN themes AS pt2 ON ct2.parent_id = pt2.id
        WHERE pt2.name LIKE 'Star Wars%' OR ct2.name LIKE 'Star Wars%') AS total_count
FROM 
    sets AS s
JOIN 
    themes AS ct ON s.theme_id = ct.id
LEFT JOIN 
    themes AS pt ON ct.parent_id = pt.id
WHERE 
    pt.name LIKE 'Star Wars%' OR ct.name LIKE 'Star Wars%'
LIMIT 20;
