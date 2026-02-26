--- CONTRÔLES POST-IMPORT

-- Vérification des volumes

SELECT 'eleves' AS table, COUNT(*) FROM eleves
UNION ALL
SELECT 'classes', COUNT(*) FROM classes
UNION ALL
SELECT 'enseignants', COUNT(*) FROM enseignants
UNION ALL
SELECT 'inscriptions', COUNT(*) FROM inscriptions
UNION ALL
SELECT 'paiements', COUNT(*) FROM paiements
UNION ALL
SELECT 'resultats', COUNT(*) FROM resultats;

-- Vérifier les clés étrangères

SELECT COUNT(*)
FROM eleves e
LEFT JOIN inscriptions i ON e.eleve_id = i.eleve_id
WHERE i.eleve_id IS NULL;

-- Paiements orphelins

SELECT COUNT(*)
FROM paiements p
LEFT JOIN eleves e ON p.eleve_id = e.eleve_id
WHERE e.eleve_id IS NULL;

-- Vérifier les valeurs métier

SELECT *
FROM resultats
WHERE moyenne < 0 OR moyenne > 20;


-- Montants incohérents

SELECT *
FROM paiements
WHERE montant <= 0;

-- Vérifier la cohérence temporelle

SELECT *
FROM paiements
WHERE date_paiement < '2020-09-01'
   OR date_paiement > '2025-06-30';

