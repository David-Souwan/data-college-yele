
-- KPI Volume 1 : Effectif total d'élèves uniques : 779

-- Combien d’élèves différents ont fréquenté le collège sur la période.

SELECT
    COUNT(DISTINCT eleve_id) AS effectif_total
FROM inscriptions
WHERE statut = 'confirmé';


-- KPI Volume 2 : Effectif par année scolaire

-- Base des analyses de croissance / décroissance.

SELECT
    a.annee_scolaire,
    COUNT(DISTINCT i.eleve_id) AS effectif
FROM inscriptions i
JOIN annees_scolaires a
    ON i.annee_id = a.annee_id
WHERE i.statut = 'confirmé'
GROUP BY a.annee_scolaire
ORDER BY a.annee_scolaire;


-- KPI Volume 3 : Effectif par niveau et par année

--Identifier les niveaux : surchargés ou sous-exploités

SELECT
    a.annee_scolaire,
    c.niveau,
    COUNT(DISTINCT i.eleve_id) AS effectif
FROM inscriptions i
JOIN classes c ON i.classe_id = c.classe_id
JOIN annees_scolaires a ON i.annee_id = a.annee_id
WHERE i.statut = 'confirmé'
GROUP BY a.annee_scolaire, c.niveau
ORDER BY a.annee_scolaire, c.niveau;