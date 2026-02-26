# 📊 Data Analyst SQL — Pilotage & Rétention d’un Collège Privé

##  Résumé pour recruteurs freelance (TL;DR)

Ce projet démontre ma capacité à intervenir comme **Data Analyst freelance** sur une mission complète, de la **structuration des données** jusqu’aux **recommandations business actionnables**.

 Mission simulée :  
Analyser les données d’un **collège privé** afin de :
- comprendre les **pertes d’élèves**,
- mesurer la **performance financière**,
- améliorer la **rétention** grâce aux données.

 **Valeur livrée au client** :  
Des **KPIs clairs**, une **analyse de cohortes**, et des **recommandations concrètes** pour piloter l’établissement.

---

##  Contexte client (mission simulée)

- **Type de client** : Collège privé
- **Localisation** : Yélé – Boundiali (Côte d’Ivoire)
- **Période analysée** : Septembre 2020 – Mai 2025
- **Problèmes business identifiés** :
  - Abandon d’élèves après la première année
  - Manque de visibilité sur les revenus réels
  - Décisions pédagogiques non pilotées par la donnée

---

##  Objectifs de la mission (vision client)

- Mettre en place des **KPIs financiers et opérationnels**
- Suivre l’évolution des **effectifs élèves**
- Analyser la **rétention et l’abandon**
- Identifier les **segments à risque**
- Fournir des **insights exploitables par la direction**

---

##  Données & périmètre

### Données analysées
- Élèves
- Classes & niveaux
- Inscriptions annuelles
- Paiements (frais scolaires)
- Résultats académiques
- Enseignants
- Années scolaires

 **+500 lignes par table**  
 Données multi-annuelles, réalistes (pas de toy dataset)


##  Compétences démontrées

### SQL avancé
- CTE (`WITH`)
- `JOIN` multi-tables
- `CASE WHEN`
- Fonctions analytiques (`RANK`)
- Agrégations complexes
- Analyse temporelle

### Analyse business
- KPIs financiers & volume
- Segmentation & ranking
- Analyse de cohortes
- Rétention / abandon (churn)
- Corrélation performance ↔ abandon
- Recommandations stratégiques


## KPIs livrés au client

### KPIs Financiers
- Chiffre d’affaires annuel
- Revenu moyen par élève
- Taux de paiement effectif
- Retards de paiement

### KPIs Volume
- Effectifs par classe et niveau
- Évolution annuelle des inscriptions
- Croissance / décroissance

### Segmentation & Ranking
- Classes les plus rentables
- Niveaux les plus stables
- Segments à fort risque d’abandon

### Cohortes & Rétention
- Taille des cohortes
- Rétention N → N+1
- Taux d’abandon par cohorte


## Insights clés générés

-  Abandon élevé après la **classe de 6e**
-  Les élèves avec **faible performance académique** abandonnent davantage
-  Les niveaux **5e et 4e** sont les plus stables
-  Forte dépendance aux **frais scolaires** comme source unique de revenus

---

##  Recommandations proposées au client

- Programme d’accompagnement ciblé pour les élèves de 6e
- Système d’alerte pour détecter les élèves à risque
- Facilités de paiement conditionnées à l’assiduité
- Diversification des revenus (soutien scolaire, activités)
- Pilotage annuel via tableaux de bord cohortes

 **Impact attendu** :
- Amélioration de la rétention
- Stabilisation financière
- Meilleure prise de décision pédagogique

---

##  Stack & outils

- **PostgreSQL**
- **SQL avancé**
- **VS Code**
- **Git / GitHub**


##  Structure du projet

/data
├── eleves.csv
├── classes.csv
├── inscriptions.csv
├── paiements.csv
├── resultats.csv

/sql
├── 01_creation_tables.sql
├── 02_kpis_financiers.sql
├── 03_kpis_volume.sql
├── 04_segmentation_ranking.sql
├── 05_cohortes_retention.sql
├── 06_insights.sql

README.md

##  Cas d’usage freelance

Ce projet reflète des missions telles que :
- Audit et structuration de bases de données
- Mise en place de KPIs de pilotage
- Analyse de rétention / churn
- Support à la décision stratégique
- Préparation de dashboards BI


##  Auteur

**David SOUWAN**  
Data Analyst Freelance  
 SQL • KPI • Analyse Business • Rétention  
 Disponible pour missions freelance



