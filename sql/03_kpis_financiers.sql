-- KPI 1 : Chiffre d'affaires total 

-- Somme de tous les paiements encaissés sur la période.: 108 010 000 FCFA

SELECT
    SUM(montant) AS chiffre_affaires_total
FROM paiements;


-- KPI 2 : Chiffre d'affaires par année scolaire

-- Comparer la performance financière année par année.

SELECT
    a.annee_scolaire,
    SUM(p.montant) AS chiffre_affaires
FROM paiements p
JOIN annees_scolaires a
    ON p.annee_id = a.annee_id
GROUP BY a.annee_scolaire
ORDER BY a.annee_scolaire;


-- KPI 3 : Nombre d'élèves payeurs par année

-- Base nécessaire pour calculer l’ARPU.

SELECT
    a.annee_scolaire,
    COUNT(DISTINCT p.eleve_id) AS nb_eleves_payeurs
FROM paiements p
JOIN annees_scolaires a
    ON p.annee_id = a.annee_id
GROUP BY a.annee_scolaire
ORDER BY a.annee_scolaire;


-- KPI 4 : ARPU par année scolaire

-- ARPU = CA / nombre d’élèves payeurs

SELECT
    a.annee_scolaire,
    ROUND(
        SUM(p.montant) * 1.0 / COUNT(DISTINCT p.eleve_id),
        0
    ) AS arpu_fcfa
FROM paiements p
JOIN annees_scolaires a
    ON p.annee_id = a.annee_id
GROUP BY a.annee_scolaire
ORDER BY a.annee_scolaire;


-- KPI 5 : Masse salariale annuelle enseignants : 25 555 990 FCFA

-- 10 mois payés par année scolaire

-- salaire fixe mensuel

SELECT
    SUM(salaire_mensuel * 10) AS masse_salariale_annuelle
FROM enseignants;


-- KPI 6 : Résultat net estimé par année scolaire

-- Résultat net = CA – masse salariale

WITH ca_par_annee AS (
    SELECT
        a.annee_scolaire,
        SUM(p.montant) AS chiffre_affaires
    FROM paiements p
    JOIN annees_scolaires a
        ON p.annee_id = a.annee_id
    GROUP BY a.annee_scolaire
),
masse_salariale AS (
    SELECT
        SUM(salaire_mensuel * 10) AS masse_salariale
    FROM enseignants
)
SELECT
    c.annee_scolaire,
    c.chiffre_affaires,
    m.masse_salariale,
    c.chiffre_affaires - m.masse_salariale AS resultat_net_estime
FROM ca_par_annee c
CROSS JOIN masse_salariale m
ORDER BY c.annee_scolaire;
