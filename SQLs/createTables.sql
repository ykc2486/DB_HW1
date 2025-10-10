CREATE TABLE themes (
    id INT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    parent_id INT
);

CREATE TABLE part_categories (
    id INT PRIMARY KEY,
    name VARCHAR(64) NOT NULL
);

CREATE TABLE colors (
    id INT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    rgb VARCHAR(6) NOT NULL,
    is_trans BOOLEAN NOT NULL
);

CREATE TABLE sets (
    set_num VARCHAR(32) PRIMARY KEY,
    name VARCHAR(128) NOT NULL,
    year INT NOT NULL,
    theme_id INT NOT NULL,
    num_parts INT NOT NULL,
    FOREIGN KEY (theme_id) REFERENCES themes(id)
);

CREATE TABLE parts (
    part_num VARCHAR(32) PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    part_cat_id INT NOT NULL,
    FOREIGN KEY (part_cat_id) REFERENCES part_categories(id)
);

CREATE TABLE inventories (
    id INT PRIMARY KEY,
    version INT NOT NULL,
    set_num VARCHAR(32) NOT NULL,
    FOREIGN KEY (set_num) REFERENCES sets(set_num)
);

CREATE TABLE inventory_parts (
    inventory_id INT NOT NULL,
    part_num VARCHAR(32) NOT NULL,  
    color_id INT NOT NULL,
    quantity INT NOT NULL,
    is_spare BOOLEAN NOT NULL,
    FOREIGN KEY (inventory_id) REFERENCES inventories(id),
    FOREIGN KEY (color_id) REFERENCES colors(id)
);

CREATE TABLE inventory_sets (
    inventory_id INT NOT NULL,
    set_num VARCHAR(32) NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (inventory_id, set_num),
    FOREIGN KEY (inventory_id) REFERENCES inventories(id),
    FOREIGN KEY (set_num) REFERENCES sets(set_num)
);