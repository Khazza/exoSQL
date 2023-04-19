    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -----Exercices
    -----Cas Papyrus (extraction de données)
-- 1-Quelles sont les commandes du fournisseur n°9120 ?
  SELECT numcom, obscom, datcom
  FROM entcom
  INNER JOIN fournis ON entcom.numfou = fournis.numfou
  WHERE fournis.numfou = 9120;
    -- Explications :
    -- Cette requête sélectionne les colonnes numcom, obscom, et datcom de la table entcom, 
    -- ainsi que les informations du fournisseur associé à chaque commande à partir de la table fournis. 
    -- Elle utilise une jointure interne pour lier les deux tables sur la colonne numfou. 
    -- Enfin, la clause WHERE permet de filtrer les résultats pour récupérer seulement les commandes du fournisseur n°9120.


-- 2-Afficher le code des fournisseurs pour lesquels des commandes ont été passées.
  SELECT DISTINCT fournis.numfou
  FROM fournis, entcom
  WHERE fournis.numfou = entcom.numfou;
    -- Explications :
    -- Dans cette requête, nous sélectionnons les valeurs distinctes de la colonne numfou 
    -- de la table fournis où la valeur de numfou dans la table entcom correspond à la valeur de numfou dans la table fournis.
------------------- Autre possibilité:
  SELECT DISTINCT fournis.numfou
  FROM fournis
  INNER JOIN entcom ON fournis.numfou = entcom.numfou;


-- 3-Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés.
  SELECT COUNT(DISTINCT entcom.numcom) AS "Nombre de commandes", COUNT(DISTINCT fournis.numfou) AS "Nombre de fournisseurs"
  FROM entcom
  JOIN fournis ON entcom.numfou = fournis.numfou;
    -- Explications :
    -- La clause DISTINCT est utilisée pour ne pas compter plusieurs fois les commandes ou les fournisseurs qui apparaissent plusieurs fois dans les tables.


-- 4-Extraire les produits ayant un stock inférieur ou égal au stock d'alerte, et dont la quantité annuelle est inférieure à 1000.
-- Informations à fournir : n° produit, libellé produit, stock actuel, stock d'alerte, quantité annuelle)
  SELECT codart, libart, stkale, stkphy, qteann 
  FROM produit 
  WHERE stkphy <= stkale AND qteann < 1000;
    -- Explications : 
    -- On prend la clause SELECT pour sélectionner les colonnes nécessaires de la table produit. 
    -- Ensuite la clause FROM pour spécifier la table à partir de laquelle nous souhaitons sélectionner des données. 
    -- Puis la clause WHERE pour filtrer les résultats. La condition stipule que le stkphy
    -- doit être inférieur ou égal au stkale ET que qteann doit être inférieure à 1000.
    -- Cela nous donne les produits ayant un stock inférieur ou égal au stock d'alerte et une quantité annuelle inférieure à 1000.


-- 5-Quels sont les fournisseurs situés dans les départements 75, 78, 92, 77 ?
-- L’affichage (département, nom fournisseur) sera effectué par département décroissant, puis par ordre alphabétique.
  SELECT posfou AS département, nomfou AS nom_fournisseur
  FROM fournis
  WHERE posfou LIKE '75___' OR posfou LIKE '78___' OR posfou LIKE '92___' OR posfou LIKE '77__'
  ORDER BY posfou DESC, nomfou ASC; 
    -- Explications :
    -- On prend les colones posfou (code postale fournisseur) et nomfou (nom fournisseur) de la table fournis.
    -- On filtre les resultats pour n'affichjer que les fournisseurs dont le code postal est l'un des codes postaux demandés, 75,78,92,77.
    -- On classe les resultarts par département, de manière décroissante puis par ordre alphabétique croissant des noms des fournisseurs.
    -- Cela signifie que les fournisseurs du département 92 apparaitront en premier, puis 78, puis 77 (aucun présent dans la table fournie), et enfin 75.
    -- Et que les fournisseurs seront par ordre alphabétique croissant dans chaque département.


-- 6-Quelles sont les commandes passées en mars et en avril ?
  SELECT *
  FROM entcom
  WHERE MONTH(datcom) IN (3,4)
    -- Explications :
    -- La clause SELECT * sélectionne toutes les colonnes de la table entcom.
    -- La clause FROM entcom spécifie la table à partir de laquelle les données doivent etre récupérées.
    -- La clause WHERE  est utilisée pour filtrer les enregistrements qui doivent être renvoyés en fonction de la condition donnée.
    -- Dans ce cas, on filtre les commandes en fonction du mois de la colonne datcom qui est un timestamp. On prend la fonction MONTH pour 
    -- extraire le mois de la date et nous vérifions que le mois est soit 3 pour mars, soit 4 pour avril.
    -- On peut aussi utiliser YEAR(datecom) = 2020 pour ne prendre que les commandes de l'année 2020.


-- 7-Quelles sont les commandes du jour qui ont des observations particulières ?
-- Afficher numéro de commande et date de commande.
  SELECT numcom, datcom
  FROM entcom
  WHERE DATE(datcom) = CURDATE() AND obscom IS NOT NULL;
  WHERE obscom IS NOT NULL;
    -- Explications :
    -- La fonction CURDATE() retourne la date courante.
    -- DATE(datcom) extrait la date de la colonne datcom qui contient à la fois la date et l'heure de la commande.
    -- WHERE DATE(datcom) = CURDATE() filtre les commandes dont la date est égale à la date courante.
    -- AND obscom IS NOT NULL filtre les commandes qui ont une observation non nulle.
    -- SELECT numcom, datcom sélectionne le numéro de commande et la date de commande.
    -- ***** Note : CURDATE() renvoie la date actuelle, ce qui signifie que la requête renverra les commandes du jour en cours. 
    ------Autre possibilité pour voir les commande en fonction du jour:
  SELECT numcom, datcom
  FROM entcom
  WHERE obscom IS NOT NULL;
    -- Explications :
    -- SELECT numcom, datcom sélectionne le numéro de commande et la date de commande.
    -- WHERE obscom IS NOT NULL filtre les commandes ayant une observation non nulle.


-- 8-Lister le total de chaque commande par total décroissant.
-- Afficher numéro de commande et total.
  SELECT entcom.numcom, SUM(ligcom.qtecde * ligcom.priuni) AS total
  FROM entcom
  JOIN ligcom ON entcom.numcom = ligcom.numcom
  JOIN produit ON ligcom.codart = produit.codart
  GROUP BY entcom.numcom
  ORDER BY total DESC; 
    -- Explications :
    -- La clause SELECT sélectionnne les colonnes numcom de la table entcom et le total calculé.
    -- La clause FROM spécifie les tables impliquées dans la requete : entcom, ligcom et produit.
    -- Les clauses JOIN sont utilisées pour joindre les tables entcom, ligcom, et produit selon les colonnes appropriées. 
    -- Le premier JOIN relie les tables entcom et ligcom sur la colonne numcom, le second JOIN relie les tables ligcom et produit sur la colonne codart.
    -- La clause GROUP BY regroupe les lignes de commande par numéro de commande (numcom)
    -- SUM calcule le total de chaque commande en multipliant la quantité de chaque produit (qtecde) par le prix unitaire (priuni)
    -- ORDER BY tri les commandes par total décroissant (DESC)


-- 9-Lister les commandes dont le total est supérieur à 10000€ ; on exclura dans le calcul du total les articles commandés en quantité supérieure ou égale à 1000.
-- Afficher numéro de commande et total.
  SELECT ligcom.numcom, SUM(ligcom.priuni*ligcom.qtecde) AS total
  FROM ligcom
  WHERE qtecde >= 1000
  GROUP BY numcom
  HAVING total > 10000;
    -- Explication :
    -- Avec SELECT on affiche: numcom pour le numéro de commande et SUM(priuni*qtecde) pour le total de chaque commande.
    -- On filtre les lignes de commande avec une quantité inférieure à 1000 en utilisant la condition WHERE qtecom < 1000.
    -- On groupe les résultats par numéro de commande en utilisant GROUP BY numcom.
    -- On filtre les commandes dont le total est supérieur à 10000€ en utilisant HAVING total > 10000.


 -- 10-Lister les commandes par nom de fournisseur.
-- Afficher nom du fournisseur, numéro de commande et date
  SELECT fournis.nomfou, entcom.numcom, entcom.datcom
  FROM entcom
  JOIN fournis ON entcom.numfou = fournis.numfou
  ORDER BY fournis.nomfou;
    -- Explications:
    -- SELECT fourn.nomfou, entcom.numcom, entcom.datcom: sélectionne les colonnes nomfou de la table fournis, numcom et datcom de la table entcom.
    -- FROM entcom: spécifie que nous voulons récupérer des données à partir de la table entcom.
    -- JOIN fournis ON entcom.numfou = fournis.numfou: joint la table fournis avec la table entcom en utilisant la clé étrangère numfou.
    -- ORDER BY fourn.nomfou: tri les résultats par ordre alphabétique du nom du fournisseur, qui est la colonne nomfou de la table fournis.


-- 11-Sortir les produits des commandes ayant le mot "urgent' en observation.
-- Afficher numéro de commande, nom du fournisseur, libellé du produit et sous total (= quantité commandée * prix unitaire)
  SELECT e.numcom, f.nomfou, p.libart, (l.qtecde * l.priuni) AS sous_total
  FROM entcom e
  JOIN fournis f ON e.numfou = f.numfou
  JOIN ligcom l ON e.numcom = l.numcom
  JOIN produit p ON l.codart = p.codart
  WHERE e.obscom LIKE '%urgent%';
    -- Explications :
    -- SELECT prend les colonnes numcom, nomfou, libart.
    -- Depuis les tables entcom, fournis, detcom et produit avec des JOIN pour avoir accès aux informations nécessaires dans chaque table.
    -- La colonne sous_total est calculée en multipliant la quantité commandée qtecde et le prix unitaire.
    -- La condition WHERE spécifie que la colonne obscom de la table entcom doit contenir le mot "urgent".
    -- Le symbole % est utilisé comme caractère générique pour trouver tous les mots contenant "urgent".
    -- Les résultats sont triés par numéro de commande en utilisant l'ordre croissant.


-- 12-Coder de 2 manières différentes la requête suivante : Lister le nom des fournisseurs susceptibles de livrer au moins un article.
  SELECT DISTINCT nomfou
  FROM fournis
  JOIN entcom ON fournis.numfou = entcom.numfou
  JOIN ligcom ON entcom.numcom = ligcom.numcom
  JOIN produit ON ligcom.codart = produit.codart;
    -- Utiliser une jointure entre la table fournis et la table entcom, pour récupérer les fournisseurs ayant passé une commande. 
    -- Ensuite, utiliser une autre jointure avec la table produit pour récupérer les fournisseurs qui peuvent livrer au moins un article. 
    -- Enfin, sélectionner le nom de chaque fournisseur distinct.
-----AUTRE TENTATIVE
  SELECT DISTINCT nomfou
  FROM fournis
  INNER JOIN (
    SELECT DISTINCT numfou
    FROM entcom
    INNER JOIN ligcom ON ligcom.numcom = entcom.numcom 
    INNER JOIN produit ON produit.codart = ligcom.codart
  ) AS livraisons ON fournis.numfou = livraisons.numfou
    -- Utiliser une sous-requête pour récupérer les fournisseurs ayant livré un produit, 
    -- puis faire une jointure avec la table fournis pour récupérer leur nom.


-- 13-Coder de 2 manières différentes la requête suivante : Lister les commandes dont le fournisseur est celui de la commande n°70210.
-- Afficher numéro de commande et date.
  SELECT numcom, datcom
  FROM entcom
  WHERE numfou = (SELECT numfou FROM entcom WHERE numcom=70210);
    -- Explications :
    -- On sélectionne les colonnes "numcom" et "datcom" de la table "entcom".
    -- On utilise une clause "WHERE" pour filtrer les commandes en fonction du numéro du fournisseur.
    -- La condition de filtrage est définie à l'aide d'une sous-requête qui récupère le numéro de fournisseur de la commande dont le numéro est 70210.
--------AU POSSIBILITE:
-- Deuxième façon de lister les commandes dont le fournisseur est celui de la commande n°70210 :
  SELECT e.numcom, e.datcom
  FROM entcom e
  JOIN entcom e2 ON e2.numfou = e.numfou
  WHERE e2.numcom = 70210;
    -- Explications :
    -- On sélectionne les colonnes "numcom" et "datcom" de la table "entcom".
    -- On utilise une jointure interne pour relier la table "entcom" à elle-même, en associant chaque commande à une autre commande passée par le même fournisseur.
    -- On utilise une clause "WHERE" pour filtrer les commandes en fonction du numéro de la commande (70210) passée par le fournisseur en question.


-- 14-Dans les articles susceptibles d’être vendus, lister les articles moins chers (basés sur Prix1) que le moins cher des rubans  
-- (article dont le premier caractère commence par R).
-- Afficher libellé de l’article et prix1
  SELECT libart, prix1
  FROM produit
  JOIN vente ON produit.codart = vente.codart
  WHERE prix1 < (SELECT MIN(prix1) FROM vente WHERE codart LIKE 'R%')
    -- Explications :
    -- Cette requête utilise une sous-requête pour sélectionner le prix minimum des rubans. La clause WHERE de la requête principale sélectionne 
    -- les articles avec un prix1 inférieur à ce prix minimum. 
    -- Le résultat renvoie le libellé et le prix1 de chaque article répondant à ces critères.
    -- La syntaxe de la requête suppose que la table article a été créée dans la base de données papyrus et contient les colonnes suivantes : codart, libart, prix1.


-- 15-Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte.
-- La liste sera triée par produit puis fournisseur
  SELECT fourn.nomfou, produit.libart, produit.stkale, produit.stkphy
  FROM fournis AS fourn
  INNER JOIN entcom ON fourn.numfou = entcom.numfou
  INNER JOIN ligcom ON entcom.numcom = ligcom.numcom
  INNER JOIN produit ON ligcom.codart = produit.codart
  WHERE produit.stkphy <= 1.5 * produit.stkale
  ORDER BY produit.libart, fourn.nomfou;
    -- Explications :
    -- La clause SELECT sélectionne le nom du fournisseur, le nom du produit, le stock d'alerte et le stock physique.
    -- On utilise la clause FROM pour spécifier les tables sur lesquelles nous voulons effectuer notre requête. 
    -- On a besoin de quatre tables : fourn, entcom, ligcom et produit.
    -- On relie les tables fournis à la table entcom sur le numéro de fournisseur, la table entcom à la table ligcom sur le numéro de commande, 
    -- et le table ligcom à la table produit sur le code article.
    -- On utilise la clause WHERE pour spécifier les critères, quand le stock est inférieur ou égal à 150 % du stock d'alerte . 
    -- Ensuite la clause ORDER BY pour trier les résultats de notre requête. 
    -- Et enfin on tri d'abord par nom de produit, puis par nom de fournisseur. Le tri se fait par ordre croissant.
    
    
-- 16-Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte, 
-- et un délai de livraison d'au maximum 30 jours.
-- La liste sera triée par fournisseur puis produit
  SELECT fournis.numfou, fournis.nomfou, produit.codart, produit.libart 
  FROM fournis
  JOIN vente ON fournis.numfou = vente.numfou 
  JOIN produit ON produit.codart = vente.codart
  WHERE produit.stkphy <= 1.5 * produit.stkale 
    AND EXISTS (
      SELECT * FROM entcom 
      WHERE entcom.numfou = fournis.numfou 
        AND DATEDIFF(entcom.datcom, NOW()) <= 30
    )
  ORDER BY fournis.nomfou, produit.libart;
    -- Explications :
    -- On utilise SELECT pour afficher les colonnes numfou et nomfou de la table fournis ainsi que les colonnes codart et libart de la table produit.
    -- On relie avec JOIN les tables fournis et produit et vente.
    -- La clause WHERE filtre les résultats pour les produits dont le stock physique est inférieur ou égal à 150 % du stock d'alerte 
    -- et qui ont été commandés auprès des fournisseurs dans les 30 derniers jours.
    -- Avec une sous-requête on recherche les commandes passées auprès des fournisseurs dans les 30 derniers jours.
    -- La clause ORDER BY trie les résultats par nom de fournisseur et par nom de produit.


-- 17-Avec le même type de sélection que ci-dessus, sortir un total des stocks par fournisseur, triés par total décroissant.
  SELECT fournis.numfou, fournis.nomfou, SUM(produit.stkphy) AS total_stock
  FROM fournis
  JOIN vente ON fournis.numfou = vente.numfou 
  JOIN produit ON produit.codart = vente.codart
  WHERE produit.stkphy <= 1.5 * produit.stkale 
    AND EXISTS (
      SELECT * FROM entcom 
      WHERE entcom.numfou = fournis.numfou 
        AND DATEDIFF(entcom.datcom, NOW()) <= 30
    )
  GROUP BY fournis.numfou, fournis.nomfou
  ORDER BY total_stock DESC;
    -- Même principe que la selection précédente, mais on utilise (SUM) pour calculer le total des stocks par fournisseur. 
    -- La clause GROUP BY regroupe les résultats par fournisseur, 
    -- et la clause ORDER BY trie les résultats par total de stock décroissant.


-- 18-En fin d'année, sortir la liste des produits dont la quantité réellement commandée dépasse 90% de la quantité annuelle prévue.
  SELECT *
  FROM produit
  WHERE (SELECT SUM(qtecde) FROM ligcom WHERE ligcom.codart = produit.codart)/produit.qteann >= 0.9
    -- Explications :
    -- On prend toutes les colonnes de la table produit ou la quantité commandée réelle pour un produit donné, obtenue en faisant la somme de toutes
    -- les quantités commandées de ce produit dans la table ligcom, est supérieur ou égale à 90% de lka quantité annuelle.
    -- On utilise une sous-requete pour calculer la somme de toutes les quantités commandées de chaque produit dans la table ligcom
    -- et en divisant cette somme par la quantité annuelle prévue pour ce produit. Si cette division est supérieur ou égale a 0.9 alors 
    -- la clause WHERE est vérifiée pour ce produit et il est retourné dans le résultat de la requête.


-- 19-Calculer le chiffre d'affaire par fournisseur pour l'année 2018, sachant que les prix indiqués sont hors taxes et que le taux de TVA est 20%.
  SELECT entcom.numfou, fournis.nomfou, SUM(produit.qteann * produit.stkale * (1 + 0.20)) AS 'CA 2018'
  FROM entcom
  JOIN fournis ON entcom.numfou = fournis.numfou
  JOIN ligcom ON entcom.numcom = ligcom.numcom
  JOIN produit ON ligcom.codart = produit.codart
  WHERE YEAR(entcom.datcom) = 2018
  GROUP BY entcom.numfou, fournis.nomfou;
    --Explications : 
    -- On selectionne trois colonnes : numfou de la table entcom, nomfou de la table fournis, et la somme du chiffre d'affaires pour chaque fournisseur pour l'année 2018.
    -- On utilise les clauses JOIN pour joindre les tables entcom, fournis, ligcom et produit.
    -- Ensuite la fonction YEAR() pour extraire l'année de la colonne datcom de la table entcom, et nous la comparons à 2018 à l'aide de la clause WHERE.
    -- Puis la fonction SUM() pour calculer la somme du chiffre d'affaires pour chaque fournisseur.
    -- Et enfin la formule qteann * stkale * (1 + 0.20) pour calculer le montant total de la commande, en tenant compte de la TVA de 20%.


    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -----Exercices
    -----Les besoins de mise à jour:
  --1
UPDATE produit
SET prix1 = prix1 * 1.04
WHERE fournisseur = 9180;

UPDATE produit
SET prix2 = prix2 * 1.02
WHERE fournisseur = 9180;
Cette requête utilise la clause UPDATE pour mettre à jour les données de la table produit. 
On multiplie le prix1 par 1.04 pour l'augmenter de 4%, et le prix2 par 1.02 pour l'augmenter de 2%. 
On sélectionne les produits à mettre à jour en utilisant une sous-requête pour trouver les fournitures du fournisseur 9180 dans la table fourniture.

  --2
UPDATE produit
SET prix2 = prix1
WHERE prix2 = 0;
Cette requête utilise la clause UPDATE pour mettre à jour les données de la table produit. 
On utilise une condition WHERE pour sélectionner les produits dont le prix2 est nul. 
On met ensuite à jour le prix2 en lui affectant la valeur du prix1.

  --3
UPDATE entcom
SET obscom = '*****'
WHERE numfou IN (SELECT numfou FROM fournis WHERE satisf < 5);
Cette requête utilise la clause UPDATE pour mettre à jour les données de la table entcom. 
On met à jour le champ obscom en lui affectant la valeur "*****". 
On sélectionne les commandes à mettre à jour en utilisant une sous-requête pour trouver les fournisseurs ayant un indice de satisfaction inférieur à 5 dans la table fournisseurs.

  --4
DELETE FROM produit
WHERE codart = 'I110';
Cette requête utilise la clause DELETE pour supprimer les données de la table produit. 
On utilise une condition WHERE pour sélectionner le produit avec le code "I110". On supprime toutes les lignes correspondantes.