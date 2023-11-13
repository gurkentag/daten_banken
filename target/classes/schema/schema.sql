-- Script fürs Ausführen in postgres DB

CREATE TABLE Kategorie
(
    KategorieId   INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    KategorieName VARCHAR(500)
);

CREATE TABLE KategorieHierarchie
(
    ElternId     INTEGER NULL,
    FOREIGN KEY (ElternId) references Kategorie (KategorieId) ON DELETE CASCADE ON UPDATE CASCADE,
    KinderId     INTEGER NULL,
    FOREIGN KEY (KinderId) references Kategorie (KategorieId) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (ElternId, KinderId)
);


CREATE TABLE Product
(
    ProductNummer       VARCHAR(100) NOT NULL PRIMARY KEY,
    KategorieId         INTEGER      NULL,
    producttype         VARCHAR(100),
    Ean                 VARCHAR(100),
    Titel               VARCHAR(500),
    Bild                VARCHAR(500),
    Verkaufsrang        INTEGER,
    Verkaufrating       INTEGER,
    FOREIGN KEY (KategorieId) references Kategorie (KategorieId) ON DELETE SET null  on update CASCADE
);


create table BookProperties
(
    ProductNummer VARCHAR(100) PRIMARY key,
    FOREIGN KEY (ProductNummer) references Product (ProductNummer) ON DELETE cascade  on update cascade,
    Seitenzahl          INTEGER,
    IsbnNummer          VARCHAR(100),
    Binding             VARCHAR(100),
    Edition             VARCHAR(500),
    Packages            VARCHAR(500),
    Publication1        VARCHAR(500)

);

create table MusicProperties
(
    ProductNummer VARCHAR(100) PRIMARY key,
    FOREIGN KEY (ProductNummer) references Product (ProductNummer) ON DELETE cascade on update cascade,
    Binding             VARCHAR(100),
    Format              VARCHAR(500),
    NumDiscs            VARCHAR(100),
    ReleaseDate         VARCHAR(100),
    ProductLabel        VARCHAR(100),
    Ups                 VARCHAR(500)
);

create table DVDProperties
(
    ProductNummer VARCHAR(100) PRIMARY key,
    FOREIGN KEY (ProductNummer) references Product (ProductNummer) ON DELETE cascade on update cascade,
    AspectRatio         VARCHAR(100),
    TextId              Integer,
    Format              VARCHAR(500),
    RegionCode          VARCHAR(100),
    ReleaseDate         VARCHAR(100),
    TheatricalRelease   VARCHAR(100),
    LaufZeit            VARCHAR(100),
    Ups                 VARCHAR(500),
    Studio              VARCHAR(500)
);


create table Authors
(
    AuthorId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY key,
    AName VARCHAR(100)
);

create table books_authors
(
    AuthorId INTEGER,
    ProductNummer VARCHAR(100),
    FOREIGN key (AuthorId) references Authors (AuthorId) ON DELETE CASCADE on update cascade,
    foreign key (ProductNummer) references BookProperties (ProductNummer) ON DELETE CASCADE on update cascade,
    primary key(AuthorId,ProductNummer)
);

create table Tracks
(
    TrackId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY key,
    Titel VARCHAR(100)
);

create table cds_tracks
(
    TrackId INTEGER ,
    ProductNummer VARCHAR(100),
    foreign key (ProductNummer) references MusicProperties (ProductNummer) ON DELETE CASCADE on update cascade,
    foreign key (TrackId) references Tracks (TrackId) ON DELETE CASCADE on update cascade,
    primary key(ProductNummer, TrackId)
);

create table audiotext
(
    audiotextId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    AudioFormat VARCHAR(100) not null,
    Languages VARCHAR (100) not null
);

create table Dvd_audiotext
(
    audiotextid INTEGER ,
    ProductNummer VARCHAR(100),
    foreign key (ProductNummer) references DVDProperties (ProductNummer) ON DELETE CASCADE on update cascade,
    foreign key (audiotextid) references audiotext (audiotextId) ON DELETE CASCADE on update cascade,
    primary key (ProductNummer, audiotextid)

);

create table Publichers
(
    PublicherId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY key,
    PName VARCHAR(100)

);

create table books_publicher
(
    PublicherId INTEGER,
    ProductNummer VARCHAR(100),
    foreign key (ProductNummer) references BookProperties (ProductNummer) ON DELETE CASCADE on update cascade,
    foreign key (PublicherId) references Publichers(PublicherId) ON DELETE cascade on update cascade,
    primary key (PublicherId,ProductNummer)
);

create table Directors
(
    DirectorId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    DName VARCHAR(100)

);

create table dvd_director
(
    DirectorId INTEGER ,
    ProductNummer VARCHAR(100),
    foreign key (ProductNummer) references DVDProperties (ProductNummer) ON DELETE CASCADE on update cascade,
    foreign key (DirectorId) references Directors (DirectorId) ON DELETE CASCADE on update cascade,
    primary key(ProductNummer, DirectorId)
);

create table Creators
(
    CreatorId  INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    CName VARCHAR(100)
);

create table dvd_creator
(
    CreatorId  INTEGER,
    FOREIGN key (CreatorId) references Creators (CreatorId) ON DELETE cascade on update cascade,
    ProductNummer VARCHAR(100),
    foreign key (ProductNummer) references DVDProperties (ProductNummer) ON DELETE CASCADE on update cascade,
    primary key(CreatorId, ProductNummer)

);

create table cd_creator
(
    CreatorId  INTEGER,
    FOREIGN key (CreatorId) references Creators (CreatorId) ON DELETE cascade on update cascade,
    ProductNummer VARCHAR(100),
    foreign key (ProductNummer) references MusicProperties (ProductNummer) ON DELETE cascade on update cascade,
    primary key(CreatorId, ProductNummer)
);

create table Actors
(
    ActorId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    AName VARCHAR(100)
);

create table dvd_actors
(
    ActorId INTEGER ,
    FOREIGN key (ActorId) references Actors (ActorId) ON DELETE cascade on update cascade,
    ProductNummer VARCHAR(100),
    foreign key (ProductNummer) references DVDProperties (ProductNummer) ON DELETE CASCADE on update cascade,
    primary key(ActorId, ProductNummer)
);

CREATE TABLE Kunde
(
    AccountNumber INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    Kontonummer   VARCHAR(100),
    Lieferadresse VARCHAR(100),
    UserName      VARCHAR(100)
);

CREATE TABLE Filiale
(
    FilialId   INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    Filialname VARCHAR(100),
    Anschrift  VARCHAR(500)
);

CREATE TABLE Bewertung
(
    BewertungId   INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    UserName      VARCHAR(5000),
    Rating        INTEGER,
    Helpful       INTEGER,
    Datum         DATE,
    Summary       VARCHAR(10000),
    Inhalt        VARCHAR(10000),
    ProductNummer VARCHAR(100),
    FOREIGN KEY (ProductNummer) references Product (ProductNummer) ON DELETE cascade on update CASCADE
);

create table Kauf
(
    FilialId      INTEGER ,
    ProductNummer VARCHAR(100),
    Datum         DATE,
    KundeNumber   INTEGER ,
    FOREIGN key (ProductNummer) references Product (ProductNummer) ON DELETE no action on update cascade,
    FOREIGN key (FilialId) references Filiale (FilialId) ON DELETE no action on update cascade,
    FOREIGN key (KundeNumber) references Kunde (AccountNumber) ON DELETE no action on update cascade,
    primary key(FilialId, ProductNummer,Datum,KundeNumber)
);

CREATE TABLE Verfügbarkeit
(
    Preis           double precision,
    Zustand         VARCHAR(100),
    Productanzahl   INTEGER,
    FilialId        INTEGER,
    FOREIGN KEY (FilialId) references Filiale (FilialId) ON DELETE cascade on update cascade,
    ProductNummer   VARCHAR(100),
    FOREIGN key (ProductNummer) references Product (ProductNummer) ON DELETE cascade on update cascade,
    primary key(FilialId,ProductNummer)
);

CREATE TABLE ähnlicheProdukte
(
    product1id        VARCHAR(100),
    FOREIGN KEY (product1id) references Product (ProductNummer) ON DELETE cascade on update cascade,
    product2id       VARCHAR(100),
    FOREIGN KEY (product2id) references Product (ProductNummer) ON DELETE cascade on update cascade,
    primary key(product1id,product2id)

);

CREATE INDEX idx_productrating
    ON Bewertung (ProductNummer, Rating);



CREATE INDEX idx_verfuegbarkeits_nummer
    ON Verfügbarkeit (ProductNummer);

