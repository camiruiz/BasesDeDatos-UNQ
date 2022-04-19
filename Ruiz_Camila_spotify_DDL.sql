--1) DDL. 

CREATE TABLE artista
	( id SERIAL PRIMARY KEY NOT NULL,
	  nombre VARCHAR(50) UNIQUE NOT NULL,
	  nombre_real VARCHAR(50) NOT NULL,
	  pais_origen VARCHAR(50) NOT NULL,
	  anio_nacimiento INT NOT NULL,
	  sigue_activo BOOL DEFAULT 'true' NOT NULL);
--Cree la tabla artista con los datos dados
--Tuve que googlear como hacera sigue_activo un booleano cuyo valor por defecto es true, aunque además de esa opción encontré
-- que podía ponerlo como BOOL BIT(1) para true o BOOL BIT(0) para false, aunque ese no me sirvió.


 CREATE TABLE usuario
	 ( nombre_completo VARCHAR(50),
 	username VARCHAR(50) PRIMARY KEY UNIQUE,
 	password VARCHAR(50),
 	anio_inicio INT,
 	pais_usuario VARCHAR(50));
	
 -- Cree la tabla usuario según los datos dados y cuando le puse VARCHAR(16) a password que fue la cantidad que
 -- vimos en clase me saltó error ya que ocupaba más por lo tanto tuve que modificar la tabla y poner un
 --número mayor como los demás y puse (50)
 
CREATE TABLE cancion
	( nombre VARCHAR(50),
  	artista INT,
  	duracion INT,
  	descargas_actuales INT,
  	anio_creacion INT,
  	CONSTRAINT artista_f_key FOREIGN KEY (artista) REFERENCES artista(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT artista_p_key PRIMARY KEY (nombre, artista));
	
	--Cree la tabla cancion con los datos, y en vez de INT puse artista como VARCHAR; y cuando lo corrí para probarlo
	-- me saltó error por lo tanto tuve que alterar esa parte ya que en los datos dados artista hace referencia a un número
 
 CREATE TABLE en_lista
	( nombre_usuario VARCHAR(50),
	nombre_cancion VARCHAR(50),
  	artista INT,
	anio_agregacion INT,
	CONSTRAINT nombre_usuario_f_key FOREIGN KEY (nombre_usuario) REFERENCES usuario(username),
	CONSTRAINT nombre_y_artista_cancion_f_key FOREIGN KEY (nombre_cancion, artista) REFERENCES cancion(nombre, artista),
 --Acá luego de crear la tabla agregué una CONSTRAINT de más la cual era:
--CONSTRAINT artista_fk2 FOREIGN KEY (artista) REFERENCES artista(id)
--me di cuenta que era innecesaria debido a la anterior CONSTRAINT que había hecho
	 CONSTRAINT en_lista_p_key PRIMARY KEY (nombre_usuario, nombre_cancion, artista));
	 
--Me costó darme cuenta que tenia que meter ambas claves en la segunda CONSTRAINT fk
	
 
CREATE TABLE sigue
	( artista INT,
  	nombre_usuario VARCHAR(50),
	anio_agregacion INT,
	CONSTRAINT nombre_usuario_f_key2 FOREIGN KEY (nombre_usuario) REFERENCES usuario(username),
	CONSTRAINT artista_f_key FOREIGN KEY (artista) REFERENCES artista(id),
	CONSTRAINT sigue_p_key PRIMARY KEY (artista, nombre_usuario));
	
--No tuve problemas en crear esta tabla, sólo me surgieron dudas si podía poner el mismo nombre
--de la CONSTRAINT "nombre_usuario_f_key" que en la anterior tabla, entonces le agregué un 2 al final 



-- PUNTO d) 

INSERT INTO usuario (nombre_completo, username, password, anio_inicio, pais_usuario) VALUES ('Ines Cosa', 'ninita', 'muerte', '2019', 'Italia')

--Agregué el usuario 'Ines Cosa' y puse como "anio_inicio" 2019 aunque no estaba segura si era ese el anio o era NULL
--