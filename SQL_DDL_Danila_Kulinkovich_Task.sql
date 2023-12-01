DROP TABLE IF EXISTS Mountains CASCADE;
CREATE TABLE Mountains (
    mountain_id SERIAL PRIMARY KEY,
    MountainName VARCHAR(32) Unique NOT NULL,
    Height INT NOT NULL CHECK (Height >= 0) DEFAULT 0,
	Country VARCHAR(32) NOT NULL,
    Area VARCHAR(32) NOT NULL
);

DROP TABLE IF EXISTS Climbs CASCADE;
CREATE TABLE Climbs (
    climb_id SERIAL PRIMARY KEY,
    StartDate DATE NOT NULL CHECK (StartDate > '2000-01-01') DEFAULT '2000-01-02',
    EndDate DATE NOT NULL CHECK (EndDate> '2000-01-01') DEFAULT '2000-01-02',
    mountain_id SERIAL,
    FOREIGN KEY (mountain_id) REFERENCES Mountains(mountain_id)
);

DROP TABLE IF EXISTS Climbers CASCADE;
CREATE TABLE Climbers (
    climber_id SERIAL PRIMARY KEY,
    FirstName VARCHAR(32) NOT NULL,
    LastName VARCHAR(32) NOT NULL,
    Address VARCHAR(32) NOT NULL,
	Birthday DATE NOT NULL
);

DROP TABLE IF EXISTS Climber_Climb CASCADE;
CREATE TABLE Climber_Climb (
    climberClimb_id SERIAL PRIMARY KEY,
    climber_id SERIAL,
    climb_id SERIAL,
    FOREIGN KEY (climber_id) REFERENCES Climbers(climber_id),
    FOREIGN KEY (climb_id) REFERENCES Climbs(climb_id)
);

DROP TABLE IF EXISTS Groupss CASCADE;
CREATE TABLE Groupss (
    groupe_id SERIAL,
    GroupeName VARCHAR(32) Unique NOT NULL
);

DROP TABLE IF EXISTS Group_Members CASCADE;
CREATE TABLE Group_Members (
    groupMember_id SERIAL PRIMARY KEY,
    groupe_id SERIAL,
	climber_id SERIAL,
    FOREIGN KEY (groupe_id) REFERENCES Groupss(groupe_id),
    FOREIGN KEY (climber_id) REFERENCES Climbers(climber_id)
);

DROP TABLE IF EXISTS Equipments CASCADE;
CREATE TABLE Equipments (
    equipment_id SERIAL PRIMARY KEY,
    EquipmentName VARCHAR(32) Unique NOT NULL
);

DROP TABLE IF EXISTS Gear_Rental CASCADE;
CREATE TABLE Gear_Rental (
    gearRental_id SERIAL,
    climb_id SERIAL,
	equipment_id SERIAL,
    FOREIGN KEY (climb_id) REFERENCES Climbs(climb_id),
    FOREIGN KEY (equipment_id) REFERENCES Equipments(equipment_id)
);

DROP TABLE IF EXISTS Difficulty_Level CASCADE;
CREATE TABLE Difficulty_Level (
    difficultyLevel_id SERIAL PRIMARY KEY,
    DifficultDescription VARCHAR(32) Unique NOT NULL
);

DROP TABLE IF EXISTS Climbe_Difficulty CASCADE;
CREATE TABLE Climbe_Difficulty (
    climbeDifficulty_id SERIAL,
    climb_id SERIAL,
    difficultyLevel_id SERIAL,
    FOREIGN KEY (climb_id) REFERENCES Climbs(climb_id),
    FOREIGN KEY (difficultyLevel_id) REFERENCES Difficulty_Level(difficultyLevel_id) 
);


INSERT INTO Mountains (MountainName, Height, Country, Area) VALUES
    ('Mont Blanc', 4808, 'France', 'Alps'),
    ('Kilimanjaro', 5895, 'Tanzania', 'Africa'),
    ('Mount Everest', 8848, 'Nepal', 'Himalayas');

INSERT INTO Climbs (StartDate, EndDate, mountain_id) VALUES
    ('2023-10-01', '2023-10-10', 1),
    ('2023-09-15', '2023-09-30', 2),
    ('2023-11-01', '2023-11-15', 3);

INSERT INTO Climbers (FirstName, LastName, Address, Birthday) VALUES
    ('John', 'Doe', 'New York', '1990-05-15'),
    ('Jane', 'Smith', 'Los Angeles', '1992-08-20'),
    ('Alice', 'Johnson', 'Chicago', '1995-02-28');

INSERT INTO Climber_Climb (climber_id, climb_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO Groupss (GroupName) VALUES
    ('Mountaineers'),
    ('Hikers'),
    ('Explorers');

INSERT INTO Group_Members (groupe_id, climber_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO Equipments (EquipmentName) VALUES
    ('Carabiner'),
    ('Helmet'),
    ('Rope');

INSERT INTO Gear_Rental (climb_id, equipment_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO Difficulty_Level (DifficultDescription) VALUES
    ('Intermediate'),
    ('Advanced'),
    ('Expert');

INSERT INTO Climbe_Difficulty (climb_id, difficultyLevel_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3);


ALTER TABLE Mountains
ADD COLUMN record_ts DATE DEFAULT current_date;

UPDATE Mountains
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Climbs
ADD COLUMN record_ts DATE DEFAULT current_date;

UPDATE Climbs
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Climbers
ADD COLUMN record_ts DATE DEFAULT current_date;

UPDATE Climbers
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Climber_Climb
ADD COLUMN record_ts DATE DEFAULT current_date;

UPDATE Climber_Climb
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Groupss
ADD COLUMN record_ts DATE DEFAULT current_date;

UPDATE Groupss
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Group_Members
ADD COLUMN record_ts DATE DEFAULT current_date;

UPDATE Group_Members
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Equipments
ADD COLUMN record_ts DATE DEFAULT current_date;

UPDATE Equipments
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Gear_Rental
ADD COLUMN record_ts DATE DEFAULT current_date;

UPDATE Gear_Rental
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Difficulty_Level
ADD COLUMN record_ts DATE DEFAULT current_date;

UPDATE Difficulty_Level
SET record_ts = current_date
WHERE record_ts IS NULL;

ALTER TABLE Climb_Difficulty
ADD COLUMN record_ts DATE DEFAULT current_date;

UPDATE Climb_Difficulty
SET record_ts = current_date
WHERE record_ts IS NULL;




