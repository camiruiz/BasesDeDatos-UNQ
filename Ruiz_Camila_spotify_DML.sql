--2) CONSULTAS
--1)

SELECT DISTINCT artista.nombre, usuario.nombre_completo
FROM artista
JOIN en_lista ON artista.id = artista
JOIN usuario ON en_lista.nombre_usuario = usuario.username
WHERE anio_agregacion >= 2012 ;


--2)

SELECT artista.nombre_real, (2019-artista.anio_nacimiento) AS edad
FROM artista
JOIN cancion ON cancion.artista = artista.id
WHERE cancion.descargas_actuales > 10000
AND cancion.nombre = artista.nombre_real
AND artista.sigue_activo ;


--3)

SELECT usuario.username, usuario.anio_inicio, COUNT (artista.id) AS cantidad_de_artistas
FROM usuario
JOIN sigue ON usuario.username = sigue.nombre_usuario
JOIN artista ON sigue.artista = artista.id
WHERE sigue.anio_agregacion < usuario.anio_inicio
GROUP BY usuario.username
ORDER BY COUNT (artista.id) DESC;
 
--4)

SELECT artista.nombre, SUM (cancion.descargas_actuales) AS cantidad_descargas
FROM artista
JOIN cancion ON cancion.artista = artista.id
WHERE artista.pais_origen = 'Argentina'
GROUP BY artista.nombre
HAVING SUM (cancion.descargas_actuales)> (SELECT AVG (descargas_actuales)
 FROM cancion)
ORDER BY cantidad_descargas;


--5)

SELECT COUNT(cancion.nombre) 
FROM cancion
JOIN en_lista ON cancion.nombre = en_lista.nombre_cancion
JOIN usuario ON en_lista.nombre_usuario = usuario.username
JOIN artista ON artista.id = cancion.artista
GROUP BY usuario.pais_usuario, artista.pais_origen
ORDER BY COUNT(cancion.nombre) DESC
LIMIT 10 OFFSET 5;


--6)

SELECT usuario.nombre_completo 
FROM usuario
JOIN en_lista ON en_lista.nombre_usuario = usuario.username
JOIN cancion ON cancion.nombre = en_lista.nombre_cancion
EXCEPT
SELECT usuario.nombre_completo
FROM usuario
JOIN en_lista ON en_lista.nombre_usuario = usuario.username
JOIN cancion ON cancion.nombre = en_lista.nombre_cancion
WHERE cancion.anio_creacion >= 2000
ORDER BY nombre_completo ASC;

--7)

SELECT artista.pais_origen AS nombre_pais, COUNT(artista.id) AS cantidad_de_artistas
FROM artista
JOIN cancion ON cancion.artista = artista.id
WHERE cancion.anio_creacion <= 2015
GROUP BY artista.pais_origen
ORDER BY cantidad_de_artistas ASC;


--8)

SELECT usuario.username, usuario.anio_inicio, usuario.pais_usuario AS pais_sin_artistas_argentinos
FROM usuario
JOIN en_lista ON en_lista.nombre_usuario = usuario.username
JOIN cancion ON cancion.nombre = en_lista.nombre_cancion
JOIN artista ON cancion.artista = artista.id
WHERE artista.pais_origen = 'Argentina' ;


--9)

SELECT AVG (cancion.descargas_actuales) AS promedio_de_descargas
FROM cancion
JOIN artista ON cancion.artista = artista.id
GROUP BY artista.pais_origen 
ORDER BY artista.pais_origen ASC;



--10)

SELECT artista.nombre_real, usuario.nombre_completo
FROM artista
JOIN sigue ON sigue.artista = artista.id
JOIN usuario ON sigue.nombre_usuario = usuario.username
WHERE sigue.anio_agregacion <= 2008 ;



--11)

SELECT DISTINCT artista.nombre_real, (2019 - artista.anio_nacimiento) AS edad_artista
FROM artista
JOIN cancion ON cancion.artista = artista.id
WHERE NOT artista.sigue_activo
AND cancion.descargas_actuales < 10000000 ;
 
 --12)

SELECT artista.nombre, AVG(cancion.descargas_actuales) AS promedio_de_descargas
 FROM artista
 JOIN cancion ON cancion.artista = artista.id
 WHERE artista.pais_origen = 'Canada'
 OR artista.pais_origen = 'Estados Unidos'
 GROUP BY artista.nombre
 HAVING AVG (cancion.descargas_actuales) < (SELECT AVG (descargas_actuales)
 FROM cancion)
 ORDER BY promedio_de_descargas;
 
 --13)
 
SELECT usuario.nombre_completo AS usuarios_sin_AlejandroSanz
FROM usuario
JOIN en_lista ON en_lista.nombre_usuario = usuario.username
JOIN artista ON en_lista.artista = artista.id
JOIN cancion ON cancion.artista = artista.id
WHERE artista.nombre = 'Calle 13'  
EXCEPT (
SELECT usuario.nombre_completo
FROM usuario
JOIN en_lista ON en_lista.nombre_usuario = usuario.username
JOIN artista ON en_lista.artista = artista.id
JOIN cancion ON cancion.artista = artista.id
WHERE artista.nombre = 'Alejandro Sanz')
ORDER BY usuarios_sin_AlejandroSanz ASC;


--14)

SELECT usuario.nombre_completo
FROM usuario
JOIN sigue ON sigue.nombre_usuario = usuario.username
JOIN artista ON artista.id = sigue.artista
EXCEPT
SELECT usuario.nombre_completo
FROM usuario
JOIN sigue ON sigue.nombre_usuario = usuario.username
JOIN artista ON artista.id = sigue.artista
WHERE NOT artista.pais_origen = 'Argentina'
ORDER BY nombre_completo ASC;


--15)

SELECT artista.nombre, COUNT (cancion.nombre)
FROM artista
JOIN cancion ON cancion.artista = artista.id 
LEFT JOIN en_lista ON en_lista.nombre_cancion = cancion.nombre
AND en_lista.artista = cancion.artista
WHERE en_lista.nombre_cancion IS NULL 
AND en_lista.artista IS NULL
GROUP BY artista.nombre
ORDER BY nombre DESC;



---16)

SELECT usuario.username, usuario.anio_inicio, usuario.pais_usuario
FROM usuario
JOIN sigue ON sigue.nombre_usuario = usuario.username
JOIN artista ON artista.id = sigue.artista
where artista.sigue_activo
EXCEPT
SELECT usuario.username, usuario.anio_inicio, usuario.pais_usuario
FROM usuario
JOIN sigue ON sigue.nombre_usuario = usuario.username
JOIN artista ON artista.id = sigue.artista
WHERE NOT artista.sigue_activo;


--17)
SELECT AVG (cancion.descargas_actuales) AS promedio_de_descargas_canciones
FROM cancion
JOIN artista ON cancion.artista = artista.id
GROUP BY artista.anio_nacimiento
ORDER BY AVG (cancion.descargas_actuales) DESC;


--18)

SELECT artista.nombre_real, usuario.nombre_completo AS usuarios_que_siguen_a_uruguayos_o_brasileros
FROM artista 
JOIN sigue ON sigue.artista = artista.id
JOIN usuario ON sigue.nombre_usuario = usuario.username
WHERE artista.pais_origen = 'Uruguay'
OR artista.pais_origen = 'Brasil'
;

--19)

SELECT artista.nombre_real, (2019-artista.anio_nacimiento) AS edad_artista_activo_con_cancion
FROM artista
JOIN cancion ON cancion.artista = artista.id
WHERE artista.sigue_activo
AND cancion.duracion > 100 
AND cancion.duracion < 300
LIMIT 10 OFFSET 5;


--20)

SELECT artista.nombre, AVG (cancion.duracion) AS promedio_de_duracion
FROM artista
JOIN cancion ON cancion.artista = artista.id
WHERE artista.pais_origen = 'Alemania'
GROUP BY artista.nombre
HAVING AVG (cancion.duracion) > (SELECT AVG (duracion)
FROM cancion)
ORDER BY artista.nombre ASC;


--21)

SELECT COUNT (sigue.artista) AS cantidad_de_artistas_que_siguen
FROM artista
JOIN sigue ON sigue.artista = artista.id
JOIN usuario ON usuario.username = sigue.nombre_usuario
WHERE artista.sigue_activo
AND (usuario.pais_usuario = 'Argentina'
OR usuario.pais_usuario = 'Brasil'
OR usuario.pais_usuario = 'Paraguay'
OR usuario.pais_usuario = 'Argentina'
OR usuario.pais_usuario = 'Uruguay'
OR usuario.pais_usuario = 'Venezuela')
GROUP BY pais_usuario
ORDER BY cantidad_de_artistas_que_siguen DESC;

--22)

SELECT artista.nombre_real AS artistas_seguidos
FROM artista
JOIN sigue ON sigue.artista = artista.id
JOIN usuario ON usuario.username = sigue.nombre_usuario
JOIN cancion ON cancion.artista = artista.id
JOIN en_lista ON en_lista.nombre_cancion = cancion.nombre
WHERE usuario.pais_usuario = 'Japon'
UNION
SELECT artista.nombre_real AS artistas_seguidos
FROM artista
JOIN sigue ON sigue.artista = artista.id
JOIN usuario ON usuario.username = sigue.nombre_usuario
JOIN cancion ON cancion.artista = artista.id
JOIN en_lista ON en_lista.nombre_cancion = cancion.nombre
WHERE usuario.pais_usuario = 'Argentina'
AND NOT artista.pais_origen = 'Argentina'
ORDER BY artistas_seguidos ASC;



--23)

SELECT usuario.nombre_completo
FROM usuario
JOIN sigue ON sigue.nombre_usuario = usuario.username
JOIN artista ON artista.id = sigue.artista
WHERE artista.sigue_activo
EXCEPT
SELECT usuario.nombre_completo
FROM usuario
JOIN sigue ON sigue.nombre_usuario = usuario.username
JOIN artista ON artista.id = sigue.artista
WHERE NOT artista.sigue_activo
ORDER BY nombre_completo ASC; 

--24)

SELECT COUNT (artista.id), artista.pais_origen
FROM artista
WHERE artista.id NOT IN (
	SELECT sigue.artista FROM sigue
)
GROUP BY artista.pais_origen
ORDER BY COUNT (id) ASC;


--25)

SELECT usuario.username, usuario.anio_inicio, usuario.pais_usuario
FROM usuario 
WHERE usuario.username NOT IN (
	SELECT en_lista.nombre_usuario FROM en_lista
	JOIN cancion ON en_lista.nombre_cancion = cancion.nombre
	WHERE cancion.anio_creacion < 2000
);


--26)

SELECT AVG (cancion.duracion) AS duracion_promedio
FROM cancion
JOIN artista ON artista.id = cancion.artista
GROUP BY artista.anio_nacimiento
ORDER BY duracion_promedio DESC;
