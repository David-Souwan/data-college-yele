

-- Ranking 1 : Classes par performance académique

-- Classer les classes selon la moyenne générale des élèves.

SELECT
    c.nom_classe,
    c.niveau,
    ROUND(AVG(r.moyenne), 2) AS moyenne_classe,
    RANK() OVER (ORDER BY AVG(r.moyenne) DESC) AS classement
FROM resultats r
JOIN inscriptions i ON r.eleve_id = i.eleve_id
JOIN classes c ON i.classe_id = c.classe_id
WHERE i.statut = 'confirmé'
GROUP BY c.nom_classe, c.niveau
ORDER BY classement;


-- Segmentation 1 : Élèves par comportement de paiement

/* Hypothèse :

≥ 200 000 FCFA → complet

100k–199k → partiel

< 100k → à risque
*/

SELECT
    eleve_id,
    SUM(montant) AS total_paye,
    CASE
        WHEN SUM(montant) >= 200000 THEN 'Paiement complet'
        WHEN SUM(montant) >= 100000 THEN 'Paiement partiel'
        ELSE 'Paiement à risque'
    END AS segment_paiement
FROM paiements
GROUP BY eleve_id;


-- Segmentation 2 : Élèves par performance scolaire

-- Segmenter selon la moyenne générale.

SELECT
    eleve_id,
    ROUND(AVG(moyenne), 2) AS moyenne_generale,
    CASE
        WHEN AVG(moyenne) >= 18 THEN 'Excellent'
        WHEN AVG(moyenne) BETWEEN 14 AND 18 THEN 'Bon'
        WHEN AVG(moyenne) BETWEEN 10 AND 14 THEN 'Moyen'
        ELSE 'En difficulté'
    END AS segment_academique
FROM resultats
GROUP BY eleve_id;


-- Segmentation 3 : Paiement × Performance

-- Identifier les élèves à risque stratégique : mauvais résultats ou mauvais paiement

WITH paiement AS (
    SELECT
        eleve_id,
        CASE
            WHEN SUM(montant) >= 200000 THEN 'Paiement complet'
            WHEN SUM(montant) >= 100000 THEN 'Paiement partiel'
            ELSE 'Paiement à risque'
        END AS segment_paiement
    FROM paiements
    GROUP BY eleve_id
),
performance AS (
    SELECT
        eleve_id,
        CASE
        WHEN AVG(moyenne) >= 18 THEN 'Excellent'
        WHEN AVG(moyenne) BETWEEN 14 AND 18 THEN 'Bon'
        WHEN AVG(moyenne) BETWEEN 10 AND 14 THEN 'Moyen'
        ELSE 'En difficulté'
        END AS segment_academique
    FROM resultats
    GROUP BY eleve_id
)
SELECT
    p.segment_paiement,
    f.segment_academique,
    COUNT(*) AS nb_eleves
FROM paiement p
JOIN performance f ON p.eleve_id = f.eleve_id
GROUP BY p.segment_paiement, f.segment_academique
ORDER BY nb_eleves DESC;