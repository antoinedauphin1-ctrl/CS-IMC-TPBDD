
/*
__Question 1:
SELECT birthYear FROM dbo.tArtist WHERE primaryName = 'Brad Pitt'
On prend l'année de naissance dans les artistes en filtrant avec le nom égal à Brad Pitt
Mais Brad Pitt n'est pas dans la base de données donc cela ne renvoie rien.

__Question 2:
SELECT COUNT(*) AS Nombre_Artistes FROM dbo.tArtist
On compte le nombre de lignes dans la table dbo.tArtist car chaque ligne correspond à un artiste et chaque artiste est présent dans au plus une ligne.
On appelle la variable renvoyée Nombre_Artistes par soucis de clarté

__Question 3:
SELECT primaryName FROM dbo.tArtist WHERE birthYear = 1960
SELECT COUNT(*) FROM dbo.tArtist WHERE birthYear = 1960
On sélectionne le nom des artistes nés en 1960 en filtrant avec l'année de naissance égale à 1960
On compte le nombre d'artistes nés en 1960 en filtrant avec l'année de naissance égale à 1960

__Question 4:
SELECT TOP 1 birthYear, COUNT(*) AS nb
FROM dbo.tArtist
WHERE birthYear !=0
GROUP BY birthYear
ORDER BY nb DESC;
On utilise TOP 1 pour ne garder que l'année avec le plus d'artistes
On sélectionne l'année de naissance et on compte le nombre d'artistes nés cette
année en filtrant avec l'année de naissance différente de 0 
On groupe par année de naissance pour compter le nombre d'artistes par année
On ordonne par le nombre d'artistes en ordre décroissant pour avoir l'année avec le plus d'artistes en premier


__Question 5:
/*
SELECT primaryName
FROM dbo.tArtist
WHERE (SELECT COUNT(*) 
       FROM dbo.tJob 
       WHERE dbo.tJob.idArtist = dbo.tArtist.idArtist
        GROUP BY dbo.tJob.idArtist
      ) > 1;
*/
On sélectionne le nom des artistes
On utilise une sous-requête pour compter le nombre de films pour chaque artiste
On filtre les artistes ayant plus d'un film en utilisant la clause WHERE avec la sous-requête
On groupe par idArtist pour compter le nombre de films par artiste et ne pas prendre en compte si l'artiste a eu plusieurs rôles dans le même film

__Question 6:
/*
SELECT a.primaryName
FROM dbo.tArtist AS a
JOIN dbo.tJob AS j ON a.idArtist = j.idArtist
GROUP BY a.idArtist, a.primaryName
HAVING COUNT(DISTINCT j.category) > 1;
*/
On sélectionne le nom des artistes
On utilise une jointure entre la table des artistes et la table des jobs pour lier les artistes à leurs rôles
On groupe par idArtist et primaryName pour compter le nombre de rôles par artiste
On utilise HAVING avec COUNT(DISTINCT j.category) pour ne compter que les rôles distincts et filtrer les artistes ayant plus d'un rôle différent



__Question 7:

SELECT TOP 1 WITH TIES f.primaryTitle, COUNT(DISTINCT a.idArtist) AS nb_acteurs
FROM dbo.tFilm AS f
JOIN dbo.tJob AS j ON f.idFilm = j.idFilm
JOIN dbo.tArtist AS a ON j.idArtist = a.idArtist
WHERE j.category = 'acted in'
GROUP BY f.primaryTitle
ORDER BY COUNT(DISTINCT a.idArtist) DESC;
On utilise TOP 1 WITH TIES pour obtenir tous les films ayant le plus grand nombre d'acteurs
On sélectionne le titre principal des films
On utilise des jointures entre la table des films, la table des jobs et la table des artistes pour lier les films aux acteurs
On filtre les jobs pour ne garder que ceux où la catégorie est 'acted in'
On groupe par titre principal pour compter le nombre d'acteurs par film
On ordonne par le nombre d'acteurs distincts en ordre décroissant

__Question 8:
SELECT a.primaryName, f.primaryTitle
FROM dbo.tArtist AS a
JOIN dbo.tJob AS j ON a.idArtist = j.idArtist
JOIN dbo.tFilm AS f ON j.idFilm = f.idFilm
WHERE (SELECT COUNT(DISTINCT category)
       FROM dbo.tJob AS j2
       WHERE j2.idFilm = f.idFilm AND j2.idArtist = a.idArtist
      ) > 1
GROUP BY a.primaryName, f.primaryTitle;
On sélectionne le nom des artistes et le titre principal des films
On utilise des jointures entre la table des artistes, la table des jobs et la table des films pour lier les artistes aux films
On utilise une sous-requête pour compter le nombre de rôles distincts pour chaque artiste dans chaque film
On filtre les artistes ayant plus d'un rôle dans un même film en utilisant la clause WHERE avec la sous-requête
On groupe par nom d'artiste et titre de film pour obtenir les paires artiste-film correspondantes

*/