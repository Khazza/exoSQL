-- Exercice
-- Ecrivez les requêtes correspondant aux demandes suivantes :
-- Lot 1 : SELECT - FROM - WHERE - AND

-- 1 - Afficher la liste des hôtels.
-- Le résultat doit faire apparaître le nom de l’hôtel et la ville
        SELECT hot_nom, hot_ville
        FROM hotel


-- 2 - Afficher la ville de résidence de Mr White
-- Le résultat doit faire apparaître le nom, le prénom, et l'adresse du client
        SELECT cli_nom, cli_prenom, cli_adressei, cli_ville
        FROM client
        WHERE cli_nom = 'White';

-- 3 - Afficher la liste des stations dont l’altitude < 1000
-- Le résultat doit faire apparaître le nom de la station et l'altitude
        SELECT sta_nom, sta_altitude
        FROM station
        WHERE sta_alitude < 1000;

-- 4 - Afficher la liste des chambres ayant une capacité > 1
-- Le résultat doit faire apparaître le numéro de la chambre ainsi que la capacité
        SELECT cha_numero, cha_capacite
        FROM chambre
        WHERE cha_capacite > 1;

--  5 - Afficher les clients n’habitant pas à Londres
-- Le résultat doit faire apparaître le nom du client et la ville
        SELECT cli_nom, cli_ville
        FROM client
        WHERE cli_ville != 'Londres';

-- 6 - Afficher la liste des hôtels située sur la ville de Bretou et possédant une catégorie > 3
-- Le résultat doit faire apparaître le nom de l'hôtel, ville et la catégorie
        SELECT hot_nom, hot_ville, hot_categorie
        FROM hotel
        WHERE hot_ville = 'Bretou' AND hot_categorie > 3;


-- Exercice
-- Ecrivez les requêtes correspondant aux demandes suivantes :
-- Lot 2 : JOIN
-- 7 - Afficher la liste des hôtels avec leur station
-- Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, la catégorie, la ville
        SELECT station.sta_nom, hotel.hot_nom, hotel.hot_categorie, hotel.hot_ville
        FROM  station
        JOIN hotel ON station.sta_id = hotel.hot_sta_id;
                --Explication: Cette requête sélectionne les colonnes sta_nom, hot_nom, hot_categorie et hot_ville de la table hotel
                --et la colonne sta_nom de la table station en joignant les deux tables sur la colonne sta_id de la table station et la colonne hot_sta_id de la table hotel.

-- 8 - Afficher la liste des chambres et leur hôtel
-- Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre
        SELECT hotel.hot_nom, hotel.hot_categorie, hotel.hot_ville, chambre.cha_numero
        FROM chambre
        JOIN hotel ON chambre.cha_hot_id = hotel.hot_id;
                --Explication: Cette requête sélectionne les colonnes hot_nom, hot_categorie, hot_ville et cha_numero de la table hotel et la table chambre en 
                --joignant les deux tables sur la colonne cha_hot_id de la table chambre et la colonne hot_id de la table hotel.

-- 9 - Afficher la liste des chambres de plus d'une place dans des hôtels situés sur la ville de Bretou
-- Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre et sa capacité
        SELECT hotel.hot_nom, hotel.hot_categorie, hotel.hot_ville, chambre.cha_numero, chambre.cha_capacite
        FROM chambre
        JOIN hotel ON chambre.cha_hot_id = hotel.hot_id
        WHERE hotel.hot_ville = 'Bretou' AND chambre.cha_capacite >1;
                --Explication: Cette requête sélectionne les colonnes hot_nom, hot_categorie, hot_ville, cha_numero et cha_capacite de la table hotel et la table chambre en joignant 
                --les deux tables sur la colonne cha_hot_id de la table chambre et la colonne hot_id de la table hotel en utilisant les clauses WHERE pour filtrer les résultats pour les hôtels
                --situés à Bretou et pour les chambres avec une capacité de plus d'une place.
    
-- 10 - Afficher la liste des réservations avec le nom des clients
-- Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de réservation
        SELECT client.cli_nom, hotel.hot_nom, reservation.res_date
        FROM reservation
        JOIN client ON client.cli_id = reservation.res_cli_id
        JOIN chambre ON chambre.cha_id = res_cha_id 
        JOIN hotel ON  hotel.hot_id = chambre.cha_hot_id;
                --Explication: Cette requête sélectionne les colonnes cli_nom, hot_nom et res_date de la table client, la table reservation, la table chambre
                --et la table hotel en joignant les tables client, reservation, chambre et hotel sur les colonnes cli_id, res_cli_id, cha_id et cha_hot_id, respectivement.

-- 11 - Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station
-- Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, le numéro de la chambre et sa capacité
        SELECT station.sta_nom, hotel.hot_nom, chambre.cha_numero, chambre.cha_capacite
        FROM station
        JOIN hotel ON station.sta_id = hotel.hot_sta_id
        JOIN chambre ON hotel.hot_id = chambre.cha_hot_id;
                --Explication: Cette requête sélectionne les colonnes sta_nom, hot_nom, cha_numero et cha_capacite de la table station, la table hotel
                --et la table chambre en joignant les trois tables sur les colonnes sta_id, hot_sta_id et cha_hot_id, respectivement.


-- 12 - Afficher les réservations avec le nom du client et le nom de l’hôtel avec datediff
-- Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de début du séjour et la durée du séjour
        SELECT client.cli_nom, hotel.hot_nom, reservation.res_date_debut, DATEDIFF(res_date_fin, res_date_debut) AS duree_sejour
        FROM reservation
        JOIN client ON reservation.res_cli_id = client.cli_id
        JOIN chambre ON reservation.res_cha_id = chambre.cha_id
        JOIN hotel ON chambre.cha_hot_id = hotel.hot_id
                --Explication :
                --On sélectionne les colonnes cli_nom, hot_nom, res_date_debut et la durée du séjour obtenue avec la fonction DATEDIFF(res_date_fin, res_date_debut)
                --qui calcule la différence en jours entre la date de fin et la date de début de la réservation.
                --On récupère les données à partir de la table reservation.
                --On relie les tables client, chambre et hotel en utilisant la clause JOIN.
                --Les relations entre les tables sont spécifiées grâce aux clauses ON. 
                --On relie reservation et client avec la clé étrangère res_cli_id et cli_id. On relie reservation, chambre et hotel avec les clés étrangères res_cha_id, cha_id, cha_hot_id et hot_id.


-- Exercice
-- Ecrivez les requêtes correspondant aux demandes suivantes :
-- Lot 3 : fonctions d'agrégation

-- 13 - Compter le nombre d’hôtel par station :
        SELECT hot_sta_id, COUNT(*) AS 'Nombre Hotels'
        FROM hotel
        GROUP BY hot_sta_id;
                -- Cette requête utilise la fonction d'agrégation COUNT pour compter le nombre d'hôtels par station. 
                -- La clause GROUP BY regroupe les résultats par station.

-- 14 - Compter le nombre de chambres par station :
        SELECT hot_sta_id, COUNT(*) AS 'Nombre Chambres'
        FROM chambre
        JOIN hotel ON chambre.cha_hot_id = hotel.hot_id
        GROUP BY hot_sta_id;
                -- Cette requête utilise la fonction d'agrégation COUNT pour compter le nombre de chambres par station. 
                -- Elle utilise également une jointure entre la table chambre et la table hotel pour pouvoir accéder à la station de chaque hôtel. 
                -- La clause GROUP BY regroupe les résultats par station.

-- 15 - Compter le nombre de chambres par station ayant une capacité > 1 :
        SELECT hot_sta_id, COUNT(*) AS 'Nombre Chambres capsup 1'
        FROM chambre
        JOIN hotel ON chambre.cha_hot_id = hotel.hot_id
        WHERE cha_capacite > 1
        GROUP BY hot_sta_id;
                -- Cette requête utilise la fonction d'agrégation COUNT pour compter le nombre de chambres par station ayant une capacité supérieure à 1. 
                -- Elle utilise également une jointure entre la table chambre et la table hotel pour pouvoir accéder à la station de chaque hôtel. 
                -- La clause WHERE permet de filtrer les résultats pour ne conserver que les chambres ayant une capacité supérieure à 1. La clause GROUP BY regroupe les résultats par station.

-- 16 - Afficher la liste des hôtels pour lesquels Mr Squire a effectué une réservation :
        SELECT DISTINCT hotel.hot_nom
        FROM reservation
        JOIN chambre ON reservation.res_cha_id = chambre.cha_id
        JOIN hotel ON chambre.cha_hot_id = hotel.hot_id
        JOIN client ON reservation.res_cli_id = client.cli_id
        WHERE client.cli_nom = 'Squire';
                -- Cette requête utilise une jointure entre la table reservation, la table chambre, la table hotel et la table client pour accéder aux informations nécessaires. 
                -- La clause WHERE permet de filtrer les résultats pour ne conserver que les réservations effectuées par un client nommé 'Squire'. 
                -- La clause DISTINCT permet d'éviter d'avoir des doublons si plusieurs chambres ont été réservées dans le même hôtel.

-- 17 - Afficher la durée moyenne des réservations par station :
        SELECT hotel.hot_sta_id, AVG(DATEDIFF(res_date_fin, res_date_debut)) AS 'Duree Moyenne Reservation'
        FROM reservation
        JOIN chambre ON reservation.res_cha_id = chambre.cha_id
        JOIN hotel ON chambre.cha_hot_id = hotel.hot_id
        GROUP BY hotel.hot_sta_id;
                -- Cette requête utilise la fonction d'agrégation AVG pour calculer la durée moyenne des réservations par station. 
                -- Elle utilise une jointure entre la table reservation, la table chambre et la table hotel pour accéder aux informations nécessaires. 
                -- La fonction DATEDIFF est utilisée pour calculer la durée d'une réservation. La clause GROUP BY regroupe les résultats par station.