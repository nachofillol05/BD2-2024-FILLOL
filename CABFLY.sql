DROP DATABASE IF EXISTS CABFLY;
CREATE DATABASE CABFLY;
USE CABFLY;
DROP TABLE IF EXISTS ASIENTO;
DROP TABLE IF EXISTS ESTADOASIENTO;
DROP TABLE IF EXISTS PASAJERO;
DROP TABLE IF EXISTS CIUDAD;
DROP TABLE IF EXISTS AEROPUERTO;
DROP TABLE IF EXISTS AERONAVE;
DROP TABLE IF EXISTS SERVICIOCOMIDA;
DROP TABLE IF EXISTS VUELO;
DROP TABLE IF EXISTS RESERVA;


CREATE TABLE ESTADOASIENTO(
	IDESTADO INT AUTO_INCREMENT NOT NULL,
    NOMBRE VARCHAR(55),
    CARACTERISTICAS VARCHAR(255),
    HABILITADOCOMPRA BOOLEAN,
    CONSTRAINT PK_IDESTADO PRIMARY KEY(IDESTADO)
)ENGINE=INNODB;

CREATE TABLE ASIENTO(
	IDASIENTO INT AUTO_INCREMENT NOT NULL,
    IDESTADO INT NOT NULL,
    CONSTRAINT FKESTADOASIENTO FOREIGN KEY (IDESTADO) REFERENCES ESTADOASIENTO(IDESTADO),
    CONSTRAINT PK_ASIENTO PRIMARY KEY(IDASIENTO)
)ENGINE=INNODB;

CREATE TABLE TIPODOC(
	IDTIPODOC INT AUTO_INCREMENT NOT NULL,
    NOMBRE VARCHAR(55),
    CARACTERISTICAS VARCHAR(255),
    CONSTRAINT PK_TIPODOC PRIMARY KEY(IDTIPODOC)
)ENGINE=INNODB;

CREATE TABLE PASAJERO(
	IDPASAJERO INT AUTO_INCREMENT NOT NULL,
    NOMBRE VARCHAR(55),
    IDTIPODOC INT NOT NULL,
    CARACTERISTICAS VARCHAR(255),
	CONSTRAINT FKTIPODOC FOREIGN KEY (IDTIPODOC) REFERENCES TIPODOC(IDTIPODOC),
    CONSTRAINT PK_PASAJERO PRIMARY KEY(IDPASAJERO)
)ENGINE=INNODB;

CREATE TABLE CIUDAD(
	IDCIUDAD INT AUTO_INCREMENT NOT NULL,
    NOMBRE VARCHAR(55),
    CARACTERISTICAS VARCHAR(255),
    CONSTRAINT PK_CIUDAD PRIMARY KEY(IDCIUDAD)
)ENGINE=INNODB;

CREATE TABLE AEROPUERTO(
	IDAEROPUERTO INT AUTO_INCREMENT NOT NULL,
    NOMBRE VARCHAR(55),
    CARACTERISTICAS VARCHAR(255),
    IDCIUDAD INT NOT NULL,
	CONSTRAINT FKCIUDAD FOREIGN KEY (IDCIUDAD) REFERENCES CIUDAD(IDCIUDAD),
    CONSTRAINT PK_AEROPUERTO PRIMARY KEY(IDAEROPUERTO)
)ENGINE=INNODB;
CREATE TABLE AERONAVE(
	IDAERONAVE INT AUTO_INCREMENT NOT NULL,
    MARCA VARCHAR(55),
    MODELO VARCHAR(255),
    CONSTRAINT PK_AERONAVE PRIMARY KEY(IDAERONAVE)
)ENGINE=INNODB;
CREATE TABLE SERVICIOCOMIDA(
	IDSERVICIOCOMIDA INT AUTO_INCREMENT NOT NULL,
    NOMBRE VARCHAR(55),
    CARACTERISTICAS VARCHAR(255),
    CONSTRAINT PK_SERVICIOCOMIDA PRIMARY KEY(IDSERVICIOCOMIDA)
)ENGINE=INNODB;
CREATE TABLE VUELO(
	NUMEROVUELO INT NOT NULL,
    FECHAVUELO DATE,
    IDAEROPUERTOSALIDA INT NOT NULL,
    IDAEROPUERTODESTINO INT NOT NULL,
    HORASALIDA DATETIME,
    HORALLEGADA DATETIME,
    IDAERONAVE INT NOT NULL,
    DURACION TIME,
    DISTANCIA INT,
    CARACTERISTICAS VARCHAR(255),
    CONSTRAINT FKAEROPUERTOSALIDA FOREIGN KEY (IDAEROPUERTOSALIDA) REFERENCES AEROPUERTO(IDAEROPUERTO),
    CONSTRAINT FKAEROPUERTODESTINO FOREIGN KEY (IDAEROPUERTODESTINO) REFERENCES AEROPUERTO(IDAEROPUERTO),
    CONSTRAINT FKAERONAVEFOREIGN FOREIGN KEY (IDAERONAVE) REFERENCES AERONAVE(IDAERONAVE),
    CONSTRAINT PK_VUELO PRIMARY KEY(NUMEROVUELO)
)ENGINE=INNODB;

CREATE TABLE RESERVA(
	CODIGORESERVA INT NOT NULL,
    IDPASAJERO INT NOT NULL,
    NUMEROVUELO INT NOT NULL,
    IDASIENTO INT NOT NULL,
    IDSERVICIOCOMIDA INT NOT NULL,
    COSTOVUELO INT,
    GENERACIONTARJETAHABILITADA BOOLEAN,
    CONSTRAINT FKVUELO FOREIGN KEY (NUMEROVUELO) REFERENCES VUELO(NUMEROVUELO),
    CONSTRAINT FKASIENTO FOREIGN KEY (IDASIENTO) REFERENCES ASIENTO(IDASIENTO),
    CONSTRAINT FKSERVICIOCOMIDA FOREIGN KEY (IDSERVICIOCOMIDA) REFERENCES SERVICIOCOMIDA(IDSERVICIOCOMIDA),
     CONSTRAINT FKPASAJERO FOREIGN KEY (IDPASAJERO) REFERENCES PASAJERO(IDPASAJERO),
    CONSTRAINT PK_RESERVA PRIMARY KEY(CODIGORESERVA)
)ENGINE=INNODB;

