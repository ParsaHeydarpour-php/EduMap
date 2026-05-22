-- ============================================================
-- MONSTER SCRIPT
-- 1. Drop old tables
-- 2. Drop & create new tables (t_ schema)
-- 3. Add foreign key constraints
-- ============================================================

SET foreign_key_checks = 0;

-- ------------------------------------------------------------
-- SECTION 1: Drop old tables (legacy schema, no t_ prefix)
-- ------------------------------------------------------------

DROP TABLE IF EXISTS Bestellung;
DROP TABLE IF EXISTS Kunde;
DROP TABLE IF EXISTS Abteilung;
DROP TABLE IF EXISTS Mitarbeiter;
DROP TABLE IF EXISTS Ort;

DROP TABLE IF EXISTS Bestellposten;
DROP TABLE IF EXISTS Sitzplatz;
DROP TABLE IF EXISTS Werbeartikel;
DROP TABLE IF EXISTS Artikel;
DROP TABLE IF EXISTS Veranstaltung;

-- ------------------------------------------------------------
-- SECTION 2: Create new tables (t_ schema)
-- ------------------------------------------------------------

DROP TABLE IF EXISTS t_ort;
CREATE TABLE t_ort (
   plz MEDIUMINT NOT NULL PRIMARY KEY,
   ort VARCHAR(30)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_kunde;
CREATE TABLE t_kunde (
   kundennummer SMALLINT NOT NULL PRIMARY KEY,
   name VARCHAR(30),
   vorname VARCHAR(30),
   geschlecht CHAR(1),
   strasse VARCHAR(50),
   hausnummer SMALLINT,
   plz MEDIUMINT,
   geburtsdatum DATE
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_artikel;
CREATE TABLE t_artikel (
   artikelnummer INTEGER NOT NULL PRIMARY KEY,
   bezeichnung VARCHAR(255)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_veranstaltung;
CREATE TABLE t_veranstaltung (
   vnummer INTEGER NOT NULL PRIMARY KEY,
   bezeichnung VARCHAR(250),
   autor VARCHAR(100),
   beschreibung LONGTEXT
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_spielstaette;
CREATE TABLE t_spielstaette (
    haus VARCHAR(30) NOT NULL PRIMARY KEY,
    strasse VARCHAR(50),
    hausnummer SMALLINT,
    plz MEDIUMINT,
    beschreibung LONGTEXT
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_kind;
CREATE TABLE t_kind (
   vorname VARCHAR(30) NOT NULL,
   geburtsdatum DATE,
   geschlecht CHAR(1),
   kundennummer SMALLINT NOT NULL,
   PRIMARY KEY(vorname, kundennummer)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_abteilung;
CREATE TABLE t_abteilung (
  ab VARCHAR(255) NOT NULL PRIMARY KEY,
  abteilungsnummer SMALLINT,
  pnal INTEGER
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_mitarbeiter;
CREATE TABLE t_mitarbeiter (
  personalnummer INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(30),
  vorname VARCHAR(30),
  geschlecht CHAR(1),
  strasse VARCHAR(50),
  hausnummer SMALLINT,
  plz MEDIUMINT,
  ab VARCHAR(250),
  nameEP VARCHAR(30),
  vornameEP VARCHAR(30),
  geburtsdatumEP DATE,
  geschlechtEP CHAR(1),
  gehalt FLOAT,
  vorgesetzter INTEGER
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_bestellung;
CREATE TABLE t_bestellung (
  bestellnummer INTEGER NOT NULL PRIMARY KEY,
  datum DATE,
  kundennummer SMALLINT,
  personalnummer INTEGER
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_bestellposten;
CREATE TABLE t_bestellposten (
  positionsnummer INTEGER NOT NULL,
  bestellnummer INTEGER NOT NULL,
  menge INT,
  artikelnummer INT,
  PRIMARY KEY(positionsnummer, bestellnummer)
 ) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_sitzplatz;
CREATE TABLE t_sitzplatz (
  bereich VARCHAR(30),
  reihe INTEGER,
  sitz INTEGER,
  preis FLOAT,
  zustand VARCHAR(30),
  artikelnummer INTEGER NOT NULL PRIMARY KEY,
  vorstellungsnummer INTEGER
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_werbeartikel;
CREATE TABLE t_werbeartikel (
  beschreibung LONGTEXT,
  preis FLOAT,
  lagerbestand INT,
  artikelnummer INTEGER NOT NULL PRIMARY KEY
) ENGINE=InnoDB;

DROP TABLE IF EXISTS t_vorstellung;
CREATE TABLE t_vorstellung (
  vorstellungsnummer INTEGER NOT NULL PRIMARY KEY,
  datum DATE,
  uhrzeit TIME,
  veranstaltungsnummer INT,
  haus VARCHAR(255)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- SECTION 3: Foreign key constraints (adapted for t_ schema)
-- ------------------------------------------------------------

ALTER TABLE t_mitarbeiter
ADD FOREIGN KEY (plz) REFERENCES t_ort(plz);

-- t_mitarbeiter.ab references the department name (primary key of t_abteilung)
ALTER TABLE t_mitarbeiter
ADD FOREIGN KEY (ab) REFERENCES t_abteilung(ab);

-- self-referencing: employee supervisor
ALTER TABLE t_mitarbeiter
ADD FOREIGN KEY (vorgesetzter) REFERENCES t_mitarbeiter(personalnummer);

-- t_abteilung.pnal references the department head employee
ALTER TABLE t_abteilung
ADD FOREIGN KEY (pnal) REFERENCES t_mitarbeiter(personalnummer);

ALTER TABLE t_kunde
ADD FOREIGN KEY (plz) REFERENCES t_ort(plz);

ALTER TABLE t_bestellung
ADD FOREIGN KEY (kundennummer) REFERENCES t_kunde(kundennummer);

ALTER TABLE t_bestellung
ADD FOREIGN KEY (personalnummer) REFERENCES t_mitarbeiter(personalnummer);

ALTER TABLE t_werbeartikel
ADD FOREIGN KEY (artikelnummer) REFERENCES t_artikel(artikelnummer);

ALTER TABLE t_sitzplatz
ADD FOREIGN KEY (artikelnummer) REFERENCES t_artikel(artikelnummer);

-- vorstellungsnummer in t_sitzplatz maps to the old Veranstaltungsnummer FK
ALTER TABLE t_sitzplatz
ADD FOREIGN KEY (vorstellungsnummer) REFERENCES t_vorstellung(vorstellungsnummer);

ALTER TABLE t_bestellposten
ADD FOREIGN KEY (artikelnummer) REFERENCES t_artikel(artikelnummer);

ALTER TABLE t_bestellposten
ADD FOREIGN KEY (bestellnummer) REFERENCES t_bestellung(bestellnummer);

SET foreign_key_checks = 1;
