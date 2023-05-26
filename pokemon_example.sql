DROP TABLE IF EXISTS main.example;

CREATE TABLE IF NOT EXISTS main.example (
	id INT AUTO_INCREMENT PRIMARY KEY,
    pokedex_number INT,
    pokemon_name VARCHAR(255),
    type1 VARCHAR(255),
    type2 VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
    INSERT INTO 
		main.example( pokedex_number,pokemon_name,type1,type2)
        VALUES
			(1,'Bulbasaur','grass','poison'),
            (2, 'Ivysaur','grass','poison'),
            (3, 'Venosaur','grass','poison'),
            (4, 'Charmander','fire',NULL);
        
        ;
        
        SELECT * FROM main.example;