-- ============================================================
--  Undercover Pop Culture — Base de données personnages
--  MariaDB / MySQL
-- ============================================================

CREATE DATABASE IF NOT EXISTS undercover CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE undercover;

-- ------------------------------------------------------------
-- TABLE: characters
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS characters (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  name       VARCHAR(100)  NOT NULL,
  emoji      VARCHAR(10)   NOT NULL DEFAULT '❓',
  universe   VARCHAR(100)  NOT NULL,
  role       ENUM('hero','villain','neutral') NOT NULL DEFAULT 'hero',
  created_at TIMESTAMP     DEFAULT CURRENT_TIMESTAMP
);

-- ------------------------------------------------------------
-- TABLE: tags  (caractéristiques / attributs)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS tags (
  id   INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(60) NOT NULL UNIQUE
);

-- ------------------------------------------------------------
-- TABLE: character_tags  (liaison N-N)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS character_tags (
  character_id INT NOT NULL,
  tag_id       INT NOT NULL,
  PRIMARY KEY (character_id, tag_id),
  FOREIGN KEY (character_id) REFERENCES characters(id) ON DELETE CASCADE,
  FOREIGN KEY (tag_id)       REFERENCES tags(id)       ON DELETE CASCADE
);

-- ============================================================
-- TAGS
-- ============================================================
INSERT INTO tags (name) VALUES
  ('super-héros'),
  ('super-vilain'),
  ('magie'),
  ('sorcier'),
  ('guerrier'),
  ('espion'),
  ('détective'),
  ('science'),
  ('robot'),
  ('espace'),
  ('médiéval'),
  ('animation'),
  ('manga'),
  ('jeu-vidéo'),
  ('comics'),
  ('cinéma'),
  ('série-tv'),
  ('littérature'),
  ('franco-belge'),
  ('historique'),
  ('nature'),
  ('animal'),
  ('pirate'),
  ('ninja'),
  ('chevalier'),
  ('sombre'),
  ('humour'),
  ('enfant'),
  ('princesse'),
  ('monstre'),
  ('vampire'),
  ('alien'),
  ('cyberpunk'),
  ('post-apocalyptique'),
  ('western'),
  ('sportif'),
  ('musicien'),
  ('scientifique'),
  ('roi-reine'),
  ('anti-héros');

-- ============================================================
-- PERSONNAGES
-- ============================================================
INSERT INTO characters (name, emoji, universe, role) VALUES

-- ── DC Comics ────────────────────────────────────────────────
  ('Batman',           '🦇', 'DC Comics',              'hero'),
  ('Superman',         '🦸', 'DC Comics',              'hero'),
  ('Wonder Woman',     '⚡', 'DC Comics',              'hero'),
  ('Le Joker',         '🃏', 'DC Comics',              'villain'),
  ('Lex Luthor',       '💼', 'DC Comics',              'villain'),
  ('Harley Quinn',     '🔨', 'DC Comics',              'villain'),
  ('Catwoman',         '🐱', 'DC Comics',              'neutral'),
  ('The Flash',        '💨', 'DC Comics',              'hero'),
  ('Green Lantern',    '💚', 'DC Comics',              'hero'),
  ('Aquaman',          '🔱', 'DC Comics',              'hero'),
  ('Bane',             '💪', 'DC Comics',              'villain'),
  ('Ra''s al Ghul',    '🐉', 'DC Comics',              'villain'),

-- ── Marvel ───────────────────────────────────────────────────
  ('Spider-Man',       '🕷️', 'Marvel',                 'hero'),
  ('Iron Man',         '🤖', 'Marvel',                 'hero'),
  ('Captain America',  '🛡️', 'Marvel',                 'hero'),
  ('Thor',             '⚡', 'Marvel',                 'hero'),
  ('Wolverine',        '🐺', 'Marvel',                 'hero'),
  ('Deadpool',         '🗡️', 'Marvel',                 'neutral'),
  ('Black Widow',      '🕸️', 'Marvel',                 'hero'),
  ('Hulk',             '💚', 'Marvel',                 'hero'),
  ('Loki',             '🐍', 'Marvel',                 'villain'),
  ('Thanos',           '💜', 'Marvel',                 'villain'),
  ('Magneto',          '🧲', 'Marvel',                 'villain'),
  ('Venom',            '🖤', 'Marvel',                 'villain'),
  ('Doctor Strange',   '🌀', 'Marvel',                 'hero'),

-- ── Star Wars ────────────────────────────────────────────────
  ('Darth Vader',      '⚔️', 'Star Wars',              'villain'),
  ('Luke Skywalker',   '🌟', 'Star Wars',              'hero'),
  ('Yoda',             '🟢', 'Star Wars',              'hero'),
  ('Rey',              '🔦', 'Star Wars',              'hero'),
  ('Obi-Wan Kenobi',   '🧙', 'Star Wars',              'hero'),
  ('Emperor Palpatine','👹', 'Star Wars',              'villain'),
  ('Han Solo',         '🚀', 'Star Wars',              'hero'),
  ('Kylo Ren',         '🌑', 'Star Wars',              'villain'),
  ('Mandalorian',      '🪖', 'Star Wars',              'hero'),

-- ── Harry Potter ─────────────────────────────────────────────
  ('Harry Potter',     '⚡', 'Harry Potter',           'hero'),
  ('Hermione Granger', '📚', 'Harry Potter',           'hero'),
  ('Voldemort',        '🐍', 'Harry Potter',           'villain'),
  ('Dumbledore',       '🦅', 'Harry Potter',           'hero'),
  ('Severus Rogue',    '🖤', 'Harry Potter',           'neutral'),
  ('Dobby',            '🧦', 'Harry Potter',           'hero'),
  ('Bellatrix Lestrange','🌑','Harry Potter',          'villain'),
  ('Drago Malefoy',    '🐉', 'Harry Potter',           'villain'),

-- ── Seigneur des Anneaux ─────────────────────────────────────
  ('Gandalf',          '🧙', 'Le Seigneur des Anneaux','hero'),
  ('Frodon Sacquet',   '💍', 'Le Seigneur des Anneaux','hero'),
  ('Legolas',          '🏹', 'Le Seigneur des Anneaux','hero'),
  ('Aragorn',          '👑', 'Le Seigneur des Anneaux','hero'),
  ('Gollum',           '😰', 'Le Seigneur des Anneaux','neutral'),
  ('Saroumane',        '🌑', 'Le Seigneur des Anneaux','villain'),
  ('Sauron',           '👁️', 'Le Seigneur des Anneaux','villain'),

-- ── Disney / Pixar ───────────────────────────────────────────
  ('Simba',            '🦁', 'Disney — Le Roi Lion',   'hero'),
  ('Bambi',            '🦌', 'Disney — Bambi',         'hero'),
  ('Elsa',             '❄️', 'Disney — La Reine des Neiges','hero'),
  ('Rapunzel',         '🌸', 'Disney — Raiponce',      'hero'),
  ('Mulan',            '⚔️', 'Disney — Mulan',         'hero'),
  ('Moana',            '🌊', 'Disney — Vaiana',        'hero'),
  ('Stitch',           '💙', 'Disney — Lilo & Stitch', 'hero'),
  ('Woody',            '🤠', 'Disney Pixar — Toy Story','hero'),
  ('Buzz l''Éclair',   '🚀', 'Disney Pixar — Toy Story','hero'),
  ('WALL-E',           '🤖', 'Disney Pixar — WALL-E',  'hero'),
  ('Shrek',            '🧅', 'DreamWorks — Shrek',     'hero'),
  ('Maléfique',        '🧙', 'Disney — La Belle au Bois','villain'),
  ('Ursula',           '🐙', 'Disney — La Petite Sirène','villain'),
  ('Scar',             '🦁', 'Disney — Le Roi Lion',   'villain'),
  ('Gaston',           '🏹', 'Disney — La Belle et la Bête','villain'),

-- ── Jeux Vidéo — Héros ───────────────────────────────────────
  ('Mario',            '🍄', 'Nintendo — Mario',       'hero'),
  ('Link',             '🗡️', 'Nintendo — Zelda',       'hero'),
  ('Samus Aran',       '🔫', 'Nintendo — Metroid',     'hero'),
  ('Kirby',            '🌸', 'Nintendo — Kirby',       'hero'),
  ('Sonic',            '💨', 'Sega — Sonic',           'hero'),
  ('Mega Man',         '🤖', 'Capcom — Mega Man',      'hero'),
  ('Lara Croft',       '💎', 'Eidos — Tomb Raider',    'hero'),
  ('Master Chief',     '🪖', 'Xbox — Halo',            'hero'),
  ('Kratos',           '⚡', 'PlayStation — God of War','hero'),
  ('Geralt de Riv',    '⚔️', 'CD Projekt — The Witcher','hero'),
  ('Aloy',             '🏹', 'PlayStation — Horizon',  'hero'),
  ('Cloud Strife',     '⚔️', 'Square Enix — FF VII',   'hero'),
  ('Tifa Lockhart',    '👊', 'Square Enix — FF VII',   'hero'),
  ('Joel',             '👨‍🦱', 'Naughty Dog — The Last of Us','hero'),
  ('Ellie',            '🔪', 'Naughty Dog — The Last of Us','hero'),
  ('2B',               '⚔️', 'PlatinumGames — NieR: Automata','hero'),
  ('V (Cyberpunk)',     '🦾', 'CD Projekt — Cyberpunk 2077','hero'),
  ('Commander Shepard','🚀', 'BioWare — Mass Effect',  'hero'),
  ('Arthur Morgan',    '🤠', 'Rockstar — Red Dead 2',  'hero'),
  ('Solid Snake',      '🐍', 'Konami — Metal Gear Solid','hero'),
  ('Tracer',           '⏱️', 'Blizzard — Overwatch',   'hero'),
  ('Nathan Drake',     '🧗', 'Naughty Dog — Uncharted','hero'),
  ('Ezio Auditore',    '🦅', 'Ubisoft — Assassin''s Creed','hero'),

-- ── Jeux Vidéo — Vilains ─────────────────────────────────────
  ('Ganondorf',        '👑', 'Nintendo — Zelda',       'villain'),
  ('Bowser',           '🐢', 'Nintendo — Mario',       'villain'),
  ('Sephiroth',        '🌑', 'Square Enix — FF VII',   'villain'),
  ('GLaDOS',           '🧠', 'Valve — Portal',         'villain'),
  ('Andrew Ryan',      '🏙️', 'Irrational — BioShock', 'villain'),
  ('Handsome Jack',    '😈', '2K — Borderlands 2',     'villain'),
  ('Vaas Montenegro',  '🔥', 'Ubisoft — Far Cry 3',    'villain'),
  ('Vergil',           '🗡️', 'Capcom — Devil May Cry', 'villain'),
  ('M. Bison',         '👊', 'Capcom — Street Fighter','villain'),
  ('Kefka Palazzo',    '🤡', 'Square Enix — FF VI',    'villain'),
  ('Ardyn Izunia',     '🃏', 'Square Enix — FF XV',    'villain'),
  ('The Illusive Man', '🕴️', 'BioWare — Mass Effect',  'villain'),
  ('Skull Face',       '💀', 'Konami — Metal Gear V',  'villain'),
  ('Micah Bell',       '🤬', 'Rockstar — Red Dead 2',  'villain'),
  ('Albert Wesker',    '🕶️', 'Capcom — Resident Evil', 'villain'),
  ('Flowey',           '🌻', 'Toby Fox — Undertale',   'villain'),
  ('Rodrigo Borgia',   '🍎', 'Ubisoft — Assassin''s Creed II','villain'),
  ('Pagan Min',        '👑', 'Ubisoft — Far Cry 4',    'villain'),
  ('The Lich King',    '☠️', 'Blizzard — World of Warcraft','villain'),
  ('Shao Kahn',        '🏛️', 'WB — Mortal Kombat',    'villain'),
  ('Baldur',           '⚡', 'PlayStation — God of War','villain'),

-- ── Manga & Anime ─────────────────────────────────────────────
  ('Son Goku',         '🔥', 'Dragon Ball',            'hero'),
  ('Vegeta',           '👑', 'Dragon Ball',            'hero'),
  ('Frieza',           '👾', 'Dragon Ball',            'villain'),
  ('Naruto Uzumaki',   '🍥', 'Naruto',                 'hero'),
  ('Kakashi Hatake',   '👁️', 'Naruto',                 'hero'),
  ('Madara Uchiha',    '🌀', 'Naruto',                 'villain'),
  ('Sasuke Uchiha',    '⚡', 'Naruto',                 'neutral'),
  ('Monkey D. Luffy',  '🏴‍☠️', 'One Piece',            'hero'),
  ('Zoro',             '⚔️', 'One Piece',              'hero'),
  ('Ichigo Kurosaki',  '🌙', 'Bleach',                 'hero'),
  ('Aizen Sōsuke',     '🕶️', 'Bleach',                 'villain'),
  ('Levi Ackerman',    '⚔️', 'Attack on Titan',        'hero'),
  ('Eren Yeager',      '🌊', 'Attack on Titan',        'neutral'),
  ('Tanjiro Kamado',   '🗡️', 'Demon Slayer',           'hero'),
  ('Muzan Kibutsuji',  '🌹', 'Demon Slayer',           'villain'),
  ('Griffith',         '🌙', 'Berserk',                'villain'),
  ('Guts',             '⚔️', 'Berserk',                'hero'),
  ('Dio Brando',       '🧛', 'JoJo''s Bizarre Adventure','villain'),
  ('Light Yagami',     '📓', 'Death Note',             'villain'),
  ('L Lawliet',        '🍬', 'Death Note',             'hero'),
  ('Edward Elric',     '⚗️', 'Fullmetal Alchemist',    'hero'),
  ('Spike Spiegel',    '🚀', 'Cowboy Bebop',           'hero'),

-- ── Cinéma ───────────────────────────────────────────────────
  ('Indiana Jones',    '🤠', 'Indiana Jones',          'hero'),
  ('James Bond',       '🔫', 'James Bond',             'hero'),
  ('Ethan Hunt',       '💣', 'Mission Impossible',     'hero'),
  ('John Wick',        '🐶', 'John Wick',              'hero'),
  ('Ellen Ripley',     '👽', 'Alien',                  'hero'),
  ('Sarah Connor',     '🤖', 'Terminator',             'hero'),
  ('Neo',              '💊', 'Matrix',                 'hero'),
  ('Katniss Everdeen', '🏹', 'Hunger Games',           'hero'),
  ('Jack Sparrow',     '🏴‍☠️', 'Pirates des Caraïbes', 'hero'),
  ('Terminator T-800', '🦾', 'Terminator',             'villain'),
  ('Hannibal Lecter',  '🍷', 'Hannibal',               'villain'),
  ('Anton Chigurh',    '🔫', 'No Country for Old Men', 'villain'),
  ('Amy Dunne',        '💀', 'Gone Girl',              'villain'),
  ('Patrick Bateman',  '🪓', 'American Psycho',        'villain'),
  ('Alex DeLarge',     '🎩', 'Orange Mécanique',       'villain'),
  ('Nurse Ratched',    '💉', 'Vol au-dessus d''un nid de coucou','villain'),
  ('Thanos (MCU)',     '💜', 'Marvel Cinematic Universe','villain'),

-- ── Séries TV ────────────────────────────────────────────────
  ('Walter White',     '🧪', 'Breaking Bad',           'villain'),
  ('Eleven',           '🌀', 'Stranger Things',        'hero'),
  ('Sherlock Holmes',  '🔍', 'Sherlock (BBC)',          'hero'),
  ('Daenerys Targaryen','🐉','Game of Thrones',        'hero'),
  ('Cersei Lannister', '👸', 'Game of Thrones',        'villain'),
  ('Tyrion Lannister', '🍷', 'Game of Thrones',        'hero'),
  ('Jon Snow',         '❄️', 'Game of Thrones',        'hero'),
  ('Ramsay Bolton',    '❄️', 'Game of Thrones',        'villain'),
  ('Gus Fring',        '🍗', 'Breaking Bad',           'villain'),
  ('Tony Soprano',     '🍝', 'Les Sopranos',           'villain'),
  ('Don Draper',       '🥃', 'Mad Men',                'neutral'),
  ('Hercule Poirot',   '🧐', 'Agatha Christie',        'hero'),
  ('Dexter Morgan',    '🔬', 'Dexter',                 'neutral'),

-- ── Littérature ──────────────────────────────────────────────
  ('Atticus Finch',    '⚖️', 'To Kill a Mockingbird',  'hero'),
  ('Elizabeth Bennet', '📖', 'Orgueil et Préjugés',    'hero'),
  ('Sherlock Holmes (Doyle)','🔍','Arthur Conan Doyle', 'hero'),
  ('Dracula',          '🧛', 'Bram Stoker',            'villain'),
  ('Frankenstein',     '⚡', 'Mary Shelley',           'neutral'),
  ('Long John Silver', '🦜', 'L''Île au Trésor',       'villain'),
  ('d''Artagnan',      '⚔️', 'Les Trois Mousquetaires','hero'),
  ('Arsène Lupin',     '🎩', 'Maurice Leblanc',        'hero'),
  ('Fantômas',         '🎭', 'Fantômas',               'villain'),
  ('Edmond Dantès',    '💎', 'Le Comte de Monte-Cristo','hero'),
  ('Captain Ahab',     '🐋', 'Moby Dick',              'neutral'),

-- ── Franco-Belge (BD) ─────────────────────────────────────────
  ('Astérix',          '🪖', 'Astérix & Obélix',       'hero'),
  ('Obélix',           '🪨', 'Astérix & Obélix',       'hero'),
  ('Tintin',           '🐕', 'Les Aventures de Tintin','hero'),
  ('Milou',            '🐶', 'Les Aventures de Tintin','hero'),
  ('Capitaine Haddock','⚓', 'Les Aventures de Tintin','hero'),
  ('Le Petit Prince',  '🌹', 'Le Petit Prince',        'hero'),
  ('Spirou',           '🃏', 'Spirou & Fantasio',      'hero'),
  ('Lucky Luke',       '🤠', 'Lucky Luke',             'hero'),
  ('Gaston Lagaffe',   '😴', 'Gaston',                 'hero'),
  ('Iznogoud',         '😤', 'Iznogoud',               'villain'),
  ('Les Daltons',      '👊', 'Lucky Luke',             'villain'),
  ('Le Fantôme de l''Opéra','🎭','Gaston Leroux',      'villain'),
  ('Marsupilami',      '🌿', 'Spirou / Marsupilami',   'hero'),
  ('Thorgal',          '⚔️', 'Thorgal',                'hero'),
  ('Corto Maltese',    '⛵', 'Hugo Pratt',             'hero'),
  ('Le Scrameustache', '🐱', 'Le Scrameustache',       'hero'),

-- ── Personnages Historiques (fictionalisés) ───────────────────
  ('Napoléon Bonaparte','👑','Histoire de France',     'neutral'),
  ('Cléopâtre',        '🐍', 'Égypte Antique',         'hero'),
  ('Léonard de Vinci', '🎨', 'Renaissance',            'hero'),
  ('Albert Einstein',  '🧪', 'Science Moderne',        'hero'),
  ('Nikola Tesla',     '⚡', 'Science Moderne',        'hero'),
  ('Marie Curie',      '☢️', 'Science Moderne',        'hero'),
  ('Jeanne d''Arc',    '⚔️', 'Histoire de France',     'hero'),
  ('Alexandre le Grand','🏛️','Antiquité Grecque',      'hero'),
  ('Vlad l''Empaleur', '🧛', 'Histoire Médiévale',     'villain'),
  ('Jules César',      '🦅', 'Rome Antique',           'hero'),
  ('Attila',           '🏇', 'Histoire Médiévale',     'villain'),
  ('Sun Tzu',          '📜', 'Chine Ancienne',         'hero'),

-- ── Personnages Gaming Complémentaires ───────────────────────
  ('Pikachu',          '⚡', 'Nintendo — Pokémon',     'hero'),
  ('Sora',             '🔑', 'Square Enix — Kingdom Hearts','hero'),
  ('Ryu',              '👊', 'Capcom — Street Fighter','hero'),
  ('Dante',            '🔥', 'Capcom — Devil May Cry', 'hero'),
  ('Crash Bandicoot',  '🌀', 'PlayStation — Crash Bandicoot','hero'),
  ('Spyro le Dragon',  '🐉', 'PlayStation — Spyro',   'hero'),
  ('Gordon Freeman',   '🔧', 'Valve — Half-Life',      'hero'),
  ('Chell',            '🔵', 'Valve — Portal',         'hero'),
  ('Big Boss',         '🐍', 'Konami — Metal Gear',    'neutral'),
  ('Pyramid Head',     '🔺', 'Konami — Silent Hill',   'villain'),
  ('Nemesis',          '🧟', 'Capcom — Resident Evil 3','villain'),
  ('Sans',             '💀', 'Toby Fox — Undertale',   'neutral');

-- ============================================================
-- LIENS CHARACTER ↔ TAGS
-- ============================================================
-- Helper: on référence par name pour la lisibilité
-- Adaptez les IDs selon votre séquence AUTO_INCREMENT

-- Macro-attribution par univers (exemples complets)
INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%DC Comics%'       AND t.name IN ('super-héros','comics','cinéma');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%Marvel%'          AND t.name IN ('super-héros','comics','cinéma');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%Star Wars%'       AND t.name IN ('espace','science','cinéma','guerrier');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%Harry Potter%'    AND t.name IN ('magie','sorcier','littérature');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%Seigneur%'        AND t.name IN ('magie','médiéval','guerrier','littérature');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%Disney%'          AND t.name IN ('animation','enfant');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%Nintendo%'        AND t.name IN ('jeu-vidéo','animation');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%PlayStation%'     AND t.name IN ('jeu-vidéo');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%manga%' OR c.universe IN
  ('Dragon Ball','Naruto','One Piece','Bleach','Attack on Titan','Demon Slayer',
   'Berserk','JoJo''s Bizarre Adventure','Death Note','Fullmetal Alchemist','Cowboy Bebop')
AND t.name IN ('manga','animation');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%Astérix%' OR c.universe LIKE '%Tintin%'
   OR c.universe LIKE '%Lucky Luke%' OR c.universe LIKE '%Spirou%'
   OR c.universe LIKE '%Gaston%' OR c.universe LIKE '%Iznogoud%'
   OR c.universe LIKE '%Marsupilami%' OR c.universe LIKE '%Thorgal%'
   OR c.universe LIKE '%Hugo Pratt%' OR c.universe LIKE '%Le Petit Prince%'
AND t.name IN ('franco-belge','littérature');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.universe LIKE '%Histoire%' OR c.universe LIKE '%Antique%'
   OR c.universe LIKE '%Médiévale%' OR c.universe LIKE '%Rome%'
   OR c.universe LIKE '%Chine%' OR c.universe LIKE '%Renaissance%'
   OR c.universe LIKE '%Science Moderne%'
AND t.name IN ('historique');

-- Role-based tags
INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.role = 'villain' AND t.name = 'super-vilain'
  AND c.universe LIKE '%Comics%';

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.role = 'villain' AND t.name = 'sombre'
  AND c.universe IN ('Berserk','Death Note','Naruto','Attack on Titan');

INSERT INTO character_tags (character_id, tag_id)
SELECT c.id, t.id FROM characters c, tags t
WHERE c.name IN ('Deadpool','Catwoman','Gollum','Dexter Morgan',
                 'Don Draper','Big Boss','Sans','Frankenstein',
                 'Captain Ahab','Walter White','Eren Yeager')
AND t.name = 'anti-héros';

-- ============================================================
-- VUE UTILE : personnages avec leurs tags concaténés
-- ============================================================
CREATE OR REPLACE VIEW v_characters_tags AS
SELECT
  c.id,
  c.name,
  c.emoji,
  c.universe,
  c.role,
  GROUP_CONCAT(t.name ORDER BY t.name SEPARATOR ', ') AS tags
FROM characters c
LEFT JOIN character_tags ct ON ct.character_id = c.id
LEFT JOIN tags            t  ON t.id = ct.tag_id
GROUP BY c.id, c.name, c.emoji, c.universe, c.role;

-- ============================================================
-- STATISTIQUES RAPIDES
-- ============================================================
-- Nombre de personnages par rôle
-- SELECT role, COUNT(*) FROM characters GROUP BY role;

-- Nombre de personnages par univers
-- SELECT universe, COUNT(*) FROM characters GROUP BY universe ORDER BY COUNT(*) DESC;

