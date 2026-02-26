
-- Cohorte d'inscription par élève

-- Base de TOUTES les analyses de cohortes.

WITH cohortes AS (
    SELECT
        eleve_id,
        MIN(annee_id) AS annee_cohorte
    FROM inscriptions
    WHERE statut = 'confirmé'
    GROUP BY eleve_id
)
SELECT *
FROM cohortes;


-- Taille des cohortes

-- Combien d’élèves par cohorte au départ.

WITH cohortes AS (
    SELECT
        eleve_id,
        MIN(annee_id) AS annee_cohorte
    FROM inscriptions
    WHERE statut = 'confirmé'
    GROUP BY eleve_id
)
SELECT
    annee_cohorte,
    COUNT(*) AS taille_cohorte
FROM cohortes
GROUP BY annee_cohorte
ORDER BY annee_cohorte;


-- Suivi des cohortes dans le temps

-- Voir combien d’élèves d’une cohorte sont encore là chaque année.

WITH cohortes AS (
    SELECT
        eleve_id,
        MIN(annee_id) AS annee_cohorte
    FROM inscriptions
    WHERE statut = 'confirmé'
    GROUP BY eleve_id
)
SELECT
    c.annee_cohorte,
    i.annee_id AS annee_suivi,
    COUNT(DISTINCT i.eleve_id) AS nb_eleves
FROM cohortes c
JOIN inscriptions i ON c.eleve_id = i.eleve_id
WHERE i.statut = 'confirmé'
GROUP BY c.annee_cohorte, i.annee_id
ORDER BY c.annee_cohorte, i.annee_id;


-- Taux de rétention N vers N+1



WITH cohortes AS (
    SELECT
        eleve_id,
        MIN(annee_id) AS annee_cohorte
    FROM inscriptions
    WHERE statut = 'confirmé'
    GROUP BY eleve_id
),
presence AS (
    SELECT
        c.annee_cohorte,
        i.annee_id,
        COUNT(DISTINCT i.eleve_id) AS nb_eleves
    FROM cohortes c
    JOIN inscriptions i ON c.eleve_id = i.eleve_id
    WHERE i.statut = 'confirmé'
    GROUP BY c.annee_cohorte, i.annee_id
)
SELECT
    p1.annee_cohorte,
    p1.annee_id AS annee_N,
    p2.annee_id AS annee_N_plus_1,
    p1.nb_eleves AS eleves_N,
    p2.nb_eleves AS eleves_N_plus_1,
    ROUND(p2.nb_eleves * 100.0 / p1.nb_eleves, 1) AS taux_retention_pct
FROM presence p1
JOIN presence p2
    ON p1.annee_cohorte = p2.annee_cohorte
   AND p2.annee_id = p1.annee_id + 1
ORDER BY p1.annee_cohorte, p1.annee_id;


-- Taux d'abandon par cohorte

-- Vision complémentaire de la rétention.

WITH cohortes AS (
    SELECT
        eleve_id,
        MIN(annee_id) AS annee_cohorte
    FROM inscriptions
    WHERE statut = 'confirmé'
    GROUP BY eleve_id
),
suivi AS (
    SELECT
        c.annee_cohorte,
        COUNT(DISTINCT c.eleve_id) AS total_cohorte,
        COUNT(DISTINCT i.eleve_id) AS encore_actifs
    FROM cohortes c
    LEFT JOIN inscriptions i
        ON c.eleve_id = i.eleve_id
       AND i.statut = 'confirmé'
    GROUP BY c.annee_cohorte
)
SELECT
    annee_cohorte,
    total_cohorte,
    encore_actifs,
    total_cohorte - encore_actifs AS abandons,
    ROUND(
        (total_cohorte - encore_actifs) * 100.0 / total_cohorte,
        1
    ) AS taux_abandon_pct
FROM suivi
ORDER BY annee_cohorte;


-- Performance académique des élèves abandonnés vs actifs


WITH performance AS (
    SELECT
        eleve_id,
        ROUND(AVG(moyenne),2) AS moyenne_generale
    FROM resultats
    GROUP BY eleve_id
)
SELECT
    e.statut,
    ROUND(AVG(p.moyenne_generale),2) AS moyenne_groupe
FROM eleves e
JOIN performance p ON e.eleve_id = p.eleve_id
GROUP BY e.statut;
