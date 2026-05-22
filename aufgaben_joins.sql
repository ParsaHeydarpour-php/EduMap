-- ============================================================
-- Joins - Übungsaufgaben
-- Based on the t_ schema defined in monster_script.sql
-- ============================================================

-- (1) Namen aller Spielstätten + Ortsname, in dem sie sich befinden
SELECT s.haus,
       o.ort
FROM t_spielstaette s
JOIN t_ort o ON s.plz = o.plz;


-- (2) Spielstätten, in denen Veranstaltungen von Mozart stattfinden
SELECT DISTINCT s.haus
FROM t_spielstaette s
JOIN t_vorstellung v   ON s.haus = v.haus
JOIN t_veranstaltung va ON v.veranstaltungsnummer = va.vnummer
WHERE va.autor LIKE '%Mozart%';


-- (3) Namen der Kunden + Anzahl ihrer Bestellungen
SELECT k.name,
       k.vorname,
       COUNT(b.bestellnummer) AS anzahl_bestellungen
FROM t_kunde k
JOIN t_bestellung b ON k.kundennummer = b.kundennummer
GROUP BY k.kundennummer, k.name, k.vorname;


-- (4) Liste aller Bestellungen und deren Bestellposten
SELECT b.bestellnummer,
       b.datum,
       bp.positionsnummer,
       bp.artikelnummer,
       bp.menge
FROM t_bestellung b
JOIN t_bestellposten bp ON b.bestellnummer = bp.bestellnummer;


-- (5) Alle Vorstellungen mit Bezeichnung + Adresse der Spielstätte und Bezeichnung der Veranstaltung
SELECT v.vorstellungsnummer,
       v.datum,
       v.uhrzeit,
       s.haus,
       s.strasse,
       s.hausnummer,
       s.plz,
       va.bezeichnung AS veranstaltung
FROM t_vorstellung v
JOIN t_spielstaette s   ON v.haus = s.haus
JOIN t_veranstaltung va ON v.veranstaltungsnummer = va.vnummer;


-- (6) Spielstätten mit gleicher PLZ (verschiedene Häuser, Duplikat-Paare vermieden)
SELECT s1.haus  AS spielstaette1,
       s2.haus  AS spielstaette2,
       o.ort,
       s1.plz
FROM t_spielstaette s1
JOIN t_spielstaette s2 ON s1.plz = s2.plz AND s1.haus < s2.haus
JOIN t_ort o           ON s1.plz = o.plz;


-- (7) Freie Sitzplätze zur Veranstaltung "Phil Collins Live" am 21.07.2002
SELECT sp.bereich,
       sp.reihe,
       sp.sitz
FROM t_sitzplatz sp
JOIN t_vorstellung v    ON sp.vorstellungsnummer = v.vorstellungsnummer
JOIN t_veranstaltung va ON v.veranstaltungsnummer = va.vnummer
WHERE va.bezeichnung = 'Phil Collins Live'
  AND v.datum        = '2002-07-21'
  AND sp.zustand     = 'frei';


-- (8) Termine der Vorstellungen zur Veranstaltung "Don Giovanni"
SELECT DISTINCT v.datum
FROM t_vorstellung v
JOIN t_veranstaltung va ON v.veranstaltungsnummer = va.vnummer
WHERE va.bezeichnung = 'Don Giovanni';


-- (9) Kunden, die "Don Giovanni" gebucht haben: Termin + erhaltene Sitzplätze
SELECT k.name,
       k.vorname,
       v.datum,
       sp.bereich,
       sp.reihe,
       sp.sitz
FROM t_kunde k
JOIN t_bestellung   b  ON k.kundennummer          = b.kundennummer
JOIN t_bestellposten bp ON b.bestellnummer         = bp.bestellnummer
JOIN t_sitzplatz    sp  ON bp.artikelnummer        = sp.artikelnummer
JOIN t_vorstellung  v   ON sp.vorstellungsnummer   = v.vorstellungsnummer
JOIN t_veranstaltung va ON v.veranstaltungsnummer  = va.vnummer
WHERE va.bezeichnung = 'Don Giovanni';


-- (10) Spielstätten, in denen keine Vorstellungen stattfinden
SELECT s.haus
FROM t_spielstaette s
LEFT JOIN t_vorstellung v ON s.haus = v.haus
WHERE v.vorstellungsnummer IS NULL;


-- (11) Veranstaltungen, zu denen es zur Zeit keine Vorstellungen gibt
SELECT va.bezeichnung
FROM t_veranstaltung va
LEFT JOIN t_vorstellung v ON va.vnummer = v.veranstaltungsnummer
WHERE v.vorstellungsnummer IS NULL;


-- (12) Veranstaltungen mit Datum, Uhrzeit und Spielstätte der Vorstellungen
--      (auch Veranstaltungen ohne Vorstellungen werden ausgegeben)
SELECT va.bezeichnung  AS veranstaltung,
       v.datum,
       v.uhrzeit,
       v.haus
FROM t_veranstaltung va
LEFT JOIN t_vorstellung v ON va.vnummer = v.veranstaltungsnummer;
