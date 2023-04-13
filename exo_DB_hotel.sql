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

-- 8 - Afficher la liste des chambres et leur hôtel
-- Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre
        SELECT hotel.hot_nom, hotel.hot_categorie, hotel.hot_ville, chambre.cha_numero
        FROM chambre
        JOIN hotel ON chambre.cha_hot_id = hotel.hot_id;

-- 9 - Afficher la liste des chambres de plus d'une place dans des hôtels situés sur la ville de Bretou
-- Le résultat doit faire apparaître le nom de l’hôtel, la catégorie, la ville, le numéro de la chambre et sa capacité
        SELECT hotel.hot_nom, hotel.hot_categorie, hotel.hot_ville, chambre.cha_numero, chambre.cha_capacite
        FROM chambre
        JOIN hotel ON chambre.cha_hot_id = hotel.hot_id
        WHERE hotel.hot_ville = 'Bretou' AND chambre.cha_capacite >1;
    
-- 10 - Afficher la liste des réservations avec le nom des clients
-- Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de réservation
        SELECT client.cli_nom, hotel.hot_nom, reservation.res_date
        FROM reservation
        JOIN client ON client.cli_id = reservation.res_cli_id
        JOIN chambre ON chambre.cha_id = res_cha_id 
        JOIN hotel ON  hotel.hot_id = chambre.cha_hot_id;

-- 11 - Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station
-- Le résultat doit faire apparaître le nom de la station, le nom de l’hôtel, le numéro de la chambre et sa capacité
        SELECT station.sta_nom, hotel.hot_nom, chambre.cha_numero, chambre.cha_capacite
        FROM station
        JOIN hotel ON station.sta_id = hotel.hot_sta_id
        JOIN chambre ON hotel.hot_id = chambre.cha_hot_id;

-- 12 - Afficher les réservations avec le nom du client et le nom de l’hôtel avec datediff
-- Le résultat doit faire apparaître le nom du client, le nom de l’hôtel, la date de début du séjour et la durée du séjour
        SELECT client.cli_nom, hotel.hot_nom, reservation.res_date_debut, DATEDIFF(res_date_fin, res_date_debut)
        FROM client
        JOIN reservation ON client.cli_id = reservation.res_cli_id
        JOIN chambre ON chambre.cha_id = reservation.res_cha_id
        JOIN hotel ON hotel.hot_id = chambre.cha_hot_id;

