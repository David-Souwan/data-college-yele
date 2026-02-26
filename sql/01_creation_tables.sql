
--Nettoyage

DROP TABLE IF EXISTS resultats;
DROP TABLE IF EXISTS paiements;
DROP TABLE IF EXISTS inscriptions;
DROP TABLE IF EXISTS eleves;
DROP TABLE IF EXISTS enseignants;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS annees_scolaires;


-- Creation de la table annees_scolaires

CREATE TABLE annees_scolaires (
    annee_id INT PRIMARY KEY,
    annee_scolaire VARCHAR(9),
    date_debut DATE,
    date_fin DATE
);

-- Creation de la table classes

CREATE TABLE classes (
    classe_id INT PRIMARY KEY,
    nom_classe VARCHAR(10),
    niveau VARCHAR(5),
    capacite INT
);

-- Creation de la table eleves


CREATE TABLE eleves (
    eleve_id INT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    sexe CHAR(1),
    date_naissance DATE,
    date_inscription DATE,
    statut VARCHAR(15)
);


-- Creation de la table inscriptions

CREATE TABLE inscriptions (
    inscription_id INT PRIMARY KEY,
    eleve_id INT,
    classe_id INT,
    annee_id INT,
    date_inscription DATE,
    statut VARCHAR(15)
);

-- Creation de la table paiements

CREATE TABLE paiements (
    paiement_id INT PRIMARY KEY,
    eleve_id INT,
    annee_id INT,
    montant INT,
    date_paiement DATE,
    type_paiement VARCHAR(20)
    );

-- Creation de la table enseignants

CREATE TABLE enseignants (
    enseignant_id INT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    matiere VARCHAR(50),
    salaire_mensuel INT
);

-- Creation de la table resultats

CREATE TABLE resultats (
    resultat_id INT PRIMARY KEY,
    eleve_id INT,
    matiere VARCHAR(50),
    trimestre VARCHAR(2),
    moyenne NUMERIC(4,2) CHECK (moyenne BETWEEN 0 AND 20)
);


-- ## Index recommandés

CREATE INDEX idx_inscriptions_annee ON inscriptions(annee_id);
CREATE INDEX idx_inscriptions_classe ON inscriptions(classe_id);

CREATE INDEX idx_paiements_annee ON paiements(annee_id);
CREATE INDEX idx_paiements_eleve ON paiements(eleve_id);

CREATE INDEX idx_resultats_eleve ON resultats(eleve_id);

SELECT *
FROM paiements;
