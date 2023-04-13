1-Quelles sont les commandes du fournisseur n°9120 ?
SELECT numcom, obscom, datcom
FROM entcom
INNER JOIN fournis ON entcom.numfou = fournis.numfou
WHERE fournis.numfou = 9120;
Cette requête sélectionne les colonnes numcom, obscom, et datcom de la table entcom, 
ainsi que les informations du fournisseur associé à chaque commande à partir de la table fournis. 
Elle utilise une jointure interne (INNER JOIN) pour lier les deux tables sur la colonne numfou. 
Enfin, la clause WHERE permet de filtrer les résultats pour récupérer seulement les commandes du fournisseur n°9120.

2-Afficher le code des fournisseurs pour lesquels des commandes ont été passées.
SELECT DISTINCT fourn.numfou
FROM fourn, entcom
WHERE fourn.numfou = entcom.numfou;
Dans cette requête, nous sélectionnons les valeurs distinctes de la colonne numfou 
de la table fournis (fourn) où la valeur de numfou dans la table entcom correspond à la valeur de numfou dans la table fournis.
------------------- Autre possibilité:
SELECT DISTINCT fourn.numfou
FROM fourn
INNER JOIN entcom
ON fourn.numfou = entcom.numfou;

3-Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés.
SELECT COUNT(DISTINCT numcom) AS "Nombre de commandes", COUNT(DISTINCT numfou) AS "Nombre de fournisseurs"
FROM entcom
JOIN fournis ON entcom.numfou = fournis.numfou;
La clause DISTINCT est utilisée pour ne pas compter plusieurs fois les commandes ou les fournisseurs qui apparaissent plusieurs fois dans les tables.

4-Extraire les produits ayant un stock inférieur ou égal au stock d'alerte, et dont la quantité annuelle est inférieure à 1000.
Informations à fournir : n° produit, libellé produit, stock actuel, stock d'alerte, quantité annuelle)
SELECT codart, libart, stkale, stkphy, qteann 
FROM produit 
WHERE stkphy <= stkale AND qteann < 1000;
Explication : Nous utilisons la clause SELECT pour sélectionner les colonnes nécessaires de la table produit. 
Nous utilisons la clause FROM pour spécifier la table à partir de laquelle nous souhaitons sélectionner des données. 
Nous utilisons la clause WHERE pour filtrer les résultats. La condition stipule que le stkphy (stock physique) 
doit être inférieur ou égal au stkale (stock d'alerte) ET que qteann (quantité annuelle) doit être inférieure à 1000. 
Cela nous donne les produits ayant un stock inférieur ou égal au stock d'alerte et une quantité annuelle inférieure à 1000.

5-Quels sont les fournisseurs situés dans les départements 75, 78, 92, 77 ?
L’affichage (département, nom fournisseur) sera effectué par département décroissant, puis par ordre alphabétique.
SELECT posfou AS departement, nomfou AS fournisseur
FROM fournis
JOIN entcom ON fournis.numfou = entcom.numfou
WHERE posfou IN ('75', '78', '92', '77')
ORDER BY posfou DESC, nomfou ASC;
Cette requête sélectionne les colonnes posfou et nomfou de la table fournis. 
La clause JOIN est utilisée pour joindre la table entcom sur la clé étrangère numfou. 
La clause WHERE filtre les résultats en sélectionnant les fournisseurs dont le département (posfou) est 75, 78, 92 ou 77. 
Enfin, la clause ORDER BY trie les résultats par département décroissant (posfou DESC) et par ordre alphabétique du nom du fournisseur (nomfou ASC).

6-Quelles sont les commandes passées en mars et en avril ?
SELECT entcom.numcom, entcom.datcom
FROM entcom
INNER JOIN produit ON entcom.numcom = produit.numcom
WHERE entcom.datcom BETWEEN '2018-03-01' AND '2018-04-30'
Explication :
La clause INNER JOIN permet de combiner les enregistrements de la table entcom avec ceux de la table produit sur la base de leur clé primaire numcom.
La condition WHERE permet de filtrer les enregistrements pour ne conserver que ceux ayant une date de commande comprise entre le 1er mars et le 30 avril.
La requête ne retourne que les numéros de commande (numcom) et les dates de commande (datcom). 

7-Quelles sont les commandes du jour qui ont des observations particulières ?
Afficher numéro de commande et date de commande.
SELECT numcom, datcom
FROM entcom
WHERE DATE(datcom) = CURDATE() AND obscom IS NOT NULL;
Explications :
La fonction CURDATE() retourne la date courante.
DATE(datcom) extrait la date de la colonne datcom qui contient à la fois la date et l'heure de la commande.
WHERE DATE(datcom) = CURDATE() filtre les commandes dont la date est égale à la date courante.
AND obscom IS NOT NULL filtre les commandes qui ont une observation non nulle.
SELECT numcom, datcom sélectionne le numéro de commande et la date de commande pour les commandes qui satisfont les deux conditions du WHERE.
Note : CURDATE() est une fonction MySQL qui renvoie la date actuelle, ce qui signifie que la requête renverra les commandes du jour en cours. 

8-Lister le total de chaque commande par total décroissant.
Afficher numéro de commande et total.
SELECT numcom, SUM(prix*qtecom) AS total
FROM entcom
JOIN ligcom ON entcom.numcom = ligcom.numcom
GROUP BY numcom
ORDER BY total DESC;
Explication de la requête :
SELECT numcom, SUM(prix*qtecom) AS total: On sélectionne les numéros de commande (numcom) et la somme des prix de chaque produit 
commandé multiplié par la quantité (prix*qtecom), qui est renommé total pour plus de clarté.
FROM entcom: On sélectionne les données dans la table entcom.
JOIN ligcom ON entcom.numcom = ligcom.numcom: On fait une jointure entre les tables entcom et ligcom en utilisant le numéro de commande comme clé de jointure.
GROUP BY numcom: On regroupe les résultats par numéro de commande.
ORDER BY total DESC: On trie les résultats par ordre décroissant de la somme des prix (total).
Cette requête permet de lister le total de chaque commande par total décroissant, avec le numéro de commande et le total.

9-Lister les commandes dont le total est supérieur à 10000€ ; on exclura dans le calcul du total les articles commandés en quantité supérieure ou égale à 1000.
Afficher numéro de commande et total.
SELECT numcom, SUM(prixunite*qtecom) AS total
FROM ligcom 
WHERE qtecom < 1000
GROUP BY numcom
HAVING total > 10000;
Explications :

La requête commence par sélectionner les colonnes numcom, prixunite et qtecom de la table ligcom, qui contient les lignes de commande.
Ensuite, elle exclut les lignes de commande qui ont une quantité supérieure ou égale à 1000 en ajoutant la condition WHERE qtecom < 1000.
La requête utilise ensuite la fonction d'agrégation SUM pour calculer le total pour chaque commande en multipliant le prix unitaire de chaque 
article par la quantité commandée et en ajoutant le tout. Le résultat est renommé total avec AS total.
Les résultats sont ensuite regroupés par numcom en utilisant la clause GROUP BY numcom.
Enfin, la clause HAVING est utilisée pour exclure les commandes dont le total est inférieur ou égal à 10000€.

10-Lister les commandes par nom de fournisseur.
Afficher nom du fournisseur, numéro de commande et date
SELECT fourn.nomfou, entcom.numcom, entcom.datcom
FROM entcom
JOIN fournis ON entcom.numfou = fournis.numfou
ORDER BY fourn.nomfou;
Explications:
SELECT fourn.nomfou, entcom.numcom, entcom.datcom: sélectionne les colonnes nomfou de la table fournis, numcom et datcom de la table entcom.
FROM entcom: spécifie que nous voulons récupérer des données à partir de la table entcom.
JOIN fournis ON entcom.numfou = fournis.numfou: joint la table fournis avec la table entcom en utilisant la clé étrangère numfou.
ORDER BY fourn.nomfou: tri les résultats par ordre alphabétique du nom du fournisseur, qui est la colonne nomfou de la table fournis.

11-Sortir les produits des commandes ayant le mot "urgent' en observation.
Afficher numéro de commande, nom du fournisseur, libellé du produit et sous total (= quantité commandée * prix unitaire)
SELECT e.numcom, f.nomfou, p.libart, e.qtecom * e.pucom AS sous_total
FROM entcom e
JOIN fournis f ON e.numfou = f.numfou
JOIN produit p ON e.codart = p.codart
WHERE e.obscom LIKE '%urgent%';
Explications:

Nous sélectionnons les colonnes numcom de entcom, nomfou de fournis, libart de produit, ainsi que le sous-total calculé comme le produit 
de la quantité commandée qtecom et le prix unitaire pucom de entcom.
Nous utilisons une jointure interne pour combiner les tables entcom, fournis et produit sur les colonnes numfou et codart correspondantes.
La clause WHERE est utilisée pour filtrer les commandes ayant le mot "urgent" dans le champ obscom de la table entcom. 
Nous utilisons la fonction LIKE avec le caractère joker % pour correspondre à toutes les occurrences de "urgent" dans la chaîne.

12-Coder de 2 manières différentes la requête suivante : Lister le nom des fournisseurs susceptibles de livrer au moins un article.
Utiliser une jointure entre la table fournis et la table entcom, pour récupérer les fournisseurs ayant passé une commande. 
Ensuite, utiliser une autre jointure avec la table produit pour récupérer les fournisseurs qui peuvent livrer au moins un article. 
Enfin, sélectionner le nom de chaque fournisseur distinct.
SQL
Copy code
SELECT DISTINCT nomfou
FROM fournis
INNER JOIN entcom ON fournis.numfou = entcom.numfou
INNER JOIN produit ON produit.unimes = entcom.numcom OR produit.unimes = 'unite'
-----ou
Utiliser une sous-requête pour récupérer les fournisseurs ayant livré un produit, puis faire une jointure avec la table fournis pour récupérer leur nom.
SQL
Copy code
SELECT DISTINCT nomfou
FROM fournisseur
INNER JOIN (
  SELECT DISTINCT numfou
  FROM entcom
  INNER JOIN produit ON produit.unimes = entcom.numcom OR produit.unimes = 'unite'
) AS livraisons ON fournisseur.numfou = livraisons.numfou

13-Coder de 2 manières différentes la requête suivante : Lister les commandes dont le fournisseur est celui de la commande n°70210.
Afficher numéro de commande et date.
SELECT numcom, datcom
FROM entcom
WHERE numfou = (SELECT numfou FROM entcom WHERE numcom=70210);
Explications :
On sélectionne les colonnes "numcom" et "datcom" de la table "entcom".
On utilise une clause "WHERE" pour filtrer les commandes en fonction du numéro du fournisseur.
La condition de filtrage est définie à l'aide d'une sous-requête qui récupère le numéro de fournisseur de la commande dont le numéro est 70210.
--------ou
Deuxième façon de lister les commandes dont le fournisseur est celui de la commande n°70210 :
SELECT e.numcom, e.datcom
FROM entcom e
JOIN entcom e2 ON e2.numfou = e.numfou
WHERE e2.numcom = 70210;
Explications :
On sélectionne les colonnes "numcom" et "datcom" de la table "entcom".
On utilise une jointure interne pour relier la table "entcom" à elle-même, en associant chaque commande à une autre commande passée par le même fournisseur.
On utilise une clause "WHERE" pour filtrer les commandes en fonction du numéro de la commande (70210) passée par le fournisseur en question.

14-Dans les articles susceptibles d’être vendus, lister les articles moins chers (basés sur Prix1) que le moins cher des rubans 
(article dont le premier caractère commence par R).
Afficher libellé de l’article et prix1
SELECT libart, prix1
FROM produit
WHERE stkphy > 0 AND codart NOT LIKE 'R%'
AND prix1 < (
  SELECT MIN(prix1)
  FROM produit
  WHERE codart LIKE 'R%'
)
ORDER BY prix1 ASC;
Explications:
La première étape consiste à sélectionner les articles qui sont susceptibles d'être vendus. 
Nous allons donc utiliser la table "produit" et y sélectionner toutes les colonnes pour lesquelles "stkphy" est supérieur à 0.
Ensuite, nous allons déterminer le prix le plus bas pour tous les articles commençant par la lettre "R" en utilisant la fonction MIN. 
Nous allons filtrer les résultats en utilisant la clause WHERE pour ne prendre que les articles dont le code commence par "R".
Enfin, nous allons sélectionner les articles pour lesquels le prix 1 est inférieur au prix le plus bas de la rubrique "R". 
Nous allons trier les résultats par ordre croissant de prix 1.

15-Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte.
La liste sera triée par produit puis fournisseur
SELECT fourn.nomfou, produit.libart, produit.stkale, produit.stkphy
FROM fournis AS fourn
INNER JOIN entcom ON fourn.numfou = entcom.numfou
INNER JOIN ligcom ON entcom.numcom = ligcom.numcom
INNER JOIN produit ON ligcom.codart = produit.codart
WHERE produit.stkphy <= 1.5 * produit.stkale
ORDER BY produit.libart, fourn.nomfou;
Explications :
La clause SELECT sélectionne les colonnes que nous souhaitons afficher dans notre résultat, à savoir : le nom du fournisseur (nomfou), 
le nom du produit (libart), le stock d'alerte (stkale) et le stock physique (stkphy).
Nous utilisons la clause FROM pour spécifier les tables sur lesquelles nous voulons effectuer notre requête. 
Ici, nous avons besoin de quatre tables : fourn, entcom, ligcom et produit.
Nous utilisons la clause INNER JOIN pour joindre les tables. 
La première jointure relie la table fourn à la table entcom sur le numéro de fournisseur (numfou). 
La deuxième jointure relie la table entcom à la table ligcom sur le numéro de commande (numcom). 
La troisième jointure relie la table ligcom à la table produit sur le code article (codart).
Nous utilisons la clause WHERE pour spécifier les critères de filtrage de notre requête. 
Nous voulons sélectionner les produits dont le stock physique est inférieur ou égal à 150 % du stock d'alerte. 
Nous calculons cette valeur en multipliant le stock d'alerte (stkale) par 1.5 et en comparant le résultat au stock physique (stkphy).
Nous utilisons la clause ORDER BY pour trier les résultats de notre requête. 
Nous voulons trier d'abord par nom de produit (libart), puis par nom de fournisseur (nomfou). Le tri se fait par ordre croissant par défaut.

16-Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte, et un délai de livraison d'au maximum 30 jours.
La liste sera triée par fournisseur puis produit
SELECT f.nomfou, p.libart
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN ligcom l ON e.numcom = l.numcom
JOIN produit p ON l.codart = p.codart
WHERE p.stkphy <= 1.5 * p.stkale
AND l.delai <= 30
ORDER BY f.nomfou, p.libart;
Explications :
La requête utilise les tables fournis, entcom, ligcom, et produit de la base de données.
La clause JOIN est utilisée pour joindre les tables fournis, entcom, ligcom, et produit.
Les colonnes nomfou et libart sont sélectionnées dans les tables fournis et produit respectivement.
La clause WHERE est utilisée pour spécifier les conditions suivantes :
le stock physique (stkphy) du produit est inférieur ou égal à 150% du stock d'alerte (stkale) du produit.
le délai de livraison (delai) du produit est d'au maximum 30 jours.
La clause ORDER BY est utilisée pour trier les résultats par fournisseur (nomfou) puis par produit (libart).

17-Avec le même type de sélection que ci-dessus, sortir un total des stocks par fournisseur, triés par total décroissant.
SELECT f.numfou, f.nomfou, SUM(p.stkphy) AS total_stocks
FROM fournis f
JOIN entcom e ON f.numfou = e.numfou
JOIN produit p ON e.numcom = p.codart
GROUP BY f.numfou
ORDER BY total_stocks DESC;
La première ligne de la requête sélectionne les colonnes que nous voulons afficher, c'est-à-dire le numéro et le nom du fournisseur, 
ainsi que la somme des stocks physiques des produits achetés. Nous utilisons également la fonction "SUM" pour agréger les stocks par fournisseur.
Ensuite, nous effectuons une jointure entre les tables "fournis", "entcom" et "produit" en utilisant les clauses "JOIN". 
Nous spécifions que nous voulons faire correspondre les numéros de fournisseur de la table "fournis" avec les numéros de fournisseur de la table "entcom", 
puis faire correspondre les numéros de commande de la table "entcom" avec les codes d'article de la table "produit".
Nous utilisons la clause "GROUP BY" pour regrouper les résultats par numéro de fournisseur, 
de sorte que nous obtenions la somme des stocks par fournisseur plutôt que la somme de tous les stocks.
Enfin, nous utilisons la clause "ORDER BY" pour trier les résultats par ordre décroissant de la somme des stocks. 
Cela signifie que les fournisseurs avec le plus grand total de stocks apparaîtront en premier.

18-En fin d'année, sortir la liste des produits dont la quantité réellement commandée dépasse 90% de la quantité annuelle prévue.
SELECT p.codart, p.libart, SUM(l.qtecom) AS qte_commandee, p.qteann, SUM(l.qtecom) / p.qteann AS proportion
FROM produit p
JOIN ligcom l ON p.codart = l.codart
JOIN entcom e ON l.numcom = e.numcom
WHERE YEAR(e.datcom) = YEAR(NOW())
GROUP BY p.codart
HAVING proportion > 0.9;
Notez que nous avons également joint la table ligcom pour obtenir la quantité commandée pour chaque produit. 
La clause HAVING est utilisée pour filtrer les résultats après l'agrégation et la clause WHERE est utilisée pour filtrer les résultats avant l'agrégation.

19-Calculer le chiffre d'affaire par fournisseur pour l'année 2018, sachant que les prix indiqués sont hors taxes et que le taux de TVA est 20%.
SELECT entcom.numfou, fournisseurs.nomfou, SUM(produit.qteann * produit.stkale * (1 + 0.20)) AS 'CA 2018'
FROM entcom
JOIN fournisseurs ON entcom.numfou = fournisseurs.numfou
JOIN ligcom ON entcom.numcom = ligcom.numcom
JOIN produit ON ligne.codart = produit.codart
WHERE YEAR(entcom.datcom) = 2018
GROUP BY entcom.numfou, fournisseurs.nomfou;
Explications :

Nous sélectionnons trois colonnes : numfou de la table entcom, nomfou de la table fournis, et la somme du chiffre d'affaires pour chaque fournisseur pour l'année 2018.
Nous utilisons les clauses JOIN pour joindre les tables entcom, fournis, ligcom et produit.
Nous utilisons la fonction YEAR() pour extraire l'année de la colonne datcom de la table entcom, et nous la comparons à 2018 à l'aide de la clause WHERE.
Nous utilisons la fonction SUM() pour calculer la somme du chiffre d'affaires pour chaque fournisseur.
Nous utilisons la formule qteann * stkale * (1 + 0.20) pour calculer le montant total de la commande, en tenant compte de la TVA de 20%.
