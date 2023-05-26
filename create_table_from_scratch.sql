CREATE TABLE IF NOT EXISTS example (
	id INT AUTO_INCREMENT,
    pokedex_number INT,
    pokemon_name VARCHAR(255),
    type1 VARCHAR(255),
    type2 VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    