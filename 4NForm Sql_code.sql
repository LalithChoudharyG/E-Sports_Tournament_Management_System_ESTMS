create database if not exists Esports;

create table Team (
    TeamID int auto_increment primary key,
    TeamName VARCHAR(50),
    TeamCaptain VARCHAR(50),
    DateOfFormation DATE,
    SponsorshipDetails INT,
    TeamMascot VARCHAR(100),
    TeamRegion VARCHAR(50)
);
create table Player (
    PlayerID int auto_increment primary key,
    PlayerRosterName varchar(50),
    PlayerName varchar(50),
    Age int,
    Nationality varchar(50),
    GamingHandle VARCHAR(50),
    TeamID int,
    foreign key (TeamID) references team(TeamID)
);
create table Game (
    GameID int auto_increment primary key,
    GameTitle VARCHAR(100),
    Genre VARCHAR(50),
    ReleaseDate DATE,
    Platforms VARCHAR(50),
    EsportsRating DECIMAL(10, 1)
);
create table Sponsor (
    SponsorID int auto_increment primary key,
    SponsorName VARCHAR(50),
    SponsorType VARCHAR(50),
    SponsorContactInformation VARCHAR(100),
    SponsorshipStartDate DATE,
    SponsorshipEndDate DATE,
    SponsorshipAmount DECIMAL(10, 2)
);
create table Caster (
    CasterID int auto_increment primary key,
    CasterName VARCHAR(100),
    BroadcastingPlatform VARCHAR(100),
    ExperienceLevel VARCHAR(50),
    SpecialtyGames VARCHAR(100),
    CastingStyle VARCHAR(100)
    -- Play-by-play,Analyst,Hype Caster,Educational Caster,Humor Caster
);
create table Tournament (
    TournamentID int auto_increment primary key,
    TournamentName VARCHAR(100),
    Organizer VARCHAR(100),
    PrizePool DECIMAL(10, 2),
    StartDate DATE,
    EndDate DATE,
	CasterID INT, 
    SponsorID INT,
    TournamentFormat VARCHAR(50),
	FOREIGN KEY (CasterID) REFERENCES Caster(CasterID),
    FOREIGN KEY (SponsorID) REFERENCES Sponsor(SponsorID)
);
CREATE TABLE venue (
    venueid INT AUTO_INCREMENT PRIMARY KEY,
    venuename VARCHAR(100),
    location VARCHAR(100),
    capacity INT,
    amenities TEXT,
    bookingavailability BOOLEAN,
    rentalcost DECIMAL(10, 2)
);
CREATE TABLE Matches (
  MatchID INT AUTO_INCREMENT PRIMARY KEY,
  VenueID INT,
  TournamentID INT,
  GameID INT,
  MatchType VARCHAR(50),
  Team1ID INT,
  Team2ID INT,
  Team1Score INT,
  Team2Score INT,
  Round VARCHAR(50),
  MatchDate DATE,
  FOREIGN KEY (TournamentID) REFERENCES Tournament(TournamentID),
  FOREIGN KEY (GameID) REFERENCES Game(GameID),
  FOREIGN KEY (Team1ID) REFERENCES Team(TeamID),
  FOREIGN KEY (Team2ID) REFERENCES Team(TeamID),
  FOREIGN KEY (VenueID) REFERENCES Venue(VenueID)
);
CREATE TABLE BracketMatch (
  BracketMatchID INT AUTO_INCREMENT PRIMARY KEY,
  MatchID INT,
  WinnerID INT,
  ParentMatchID INT,
  BracketType VARCHAR(50),  -- Added column to specify bracket type
  FOREIGN KEY (MatchID) REFERENCES Matches(MatchID),
  FOREIGN KEY (WinnerID) REFERENCES Team(TeamID),
  FOREIGN KEY (ParentMatchID) REFERENCES BracketMatch(BracketMatchID)
);

CREATE TABLE PrizePool (
  PrizePoolID INT AUTO_INCREMENT PRIMARY KEY,
  TournamentID INT,  
  Place INT,  
  PrizeAmount DECIMAL(10, 2),
  FOREIGN KEY (TournamentID) REFERENCES Tournament(TournamentID)  
);

CREATE TABLE Coach ( -- weak entity depends on team  
    CoachName VARCHAR(50),
    CoachingExperience INT,
    TeamID INT,
    CoachRole VARCHAR(50), 
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
    ON DELETE CASCADE,
    PRIMARY KEY (TeamID, CoachRole)
);
CREATE TABLE TournamentStandings (
    TournamentID INT,
    TeamID INT,
    Position INT,
    PRIMARY KEY (TournamentID, TeamID),
    FOREIGN KEY (TournamentID) REFERENCES Tournament(TournamentID),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

show tables;

INSERT INTO Team (TeamName, TeamCaptain, DateOfFormation, SponsorshipDetails, TeamRegion, TeamMascot)
VALUES 
  ('Qing Jiu Club', 'Sun', '2020-12-20', 10000, 'CHN', 'GG'),
  ('Wolves', ' King', '2018-07-11', 15000, 'CHN', 'Wolf'),
  ('Stand Point Gaming', 'Guagua', '2021-07-07', 20010, 'CHN', 'Tiger'),
  ('VOLT','Dolaky','2023-04-08',20001,'JPN','Bolt'),
  ('Powerhouse','incendio','2023-09-05',15500,'SNP','Flash'),
  ('Kagendra','Clove','2020-01-06',20000,'SNP','Eagle'),
  ('GodLike','Neutrino','2018-10-02',30000,'IND','GL'),
  ('Team Vitality','JOKOs','2021-03-26',25000,'IND','Bee'),
  ('Luminosity','Marshy','2022-11-14',30500,'NA','Eye'),
  ('Team Mayhem','AyeoRaph','2023-08-11',10200,'NA','Soal'),
  ('Tribe Gaming','Jezz','2017-04-15',13000,'NA','Axe'),
  ('Kingsclan','Saze','2019-06-14',22000,'EU','Crown'),
  ('Exclusive','Neil','2023-04-27',10500,'EU','EXL'),
  ('TLE Esports','Saucy','2022-10-10',2000,'MEX','Beast'),
  ('Loops','Keyotk','2019-06-28',1000,'BRZ','Infinite'),
  ('iNCO Gaming','LiNBZ','2021-07-16',2000,'BRZ','Lion')
  ;
  
  select * from team;
  
insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('Sun','Liu Hangchun',21,'CHINA','SunQJC',1),
('MaoQi','Ma Zhonghao',22,'CHINA','MaoQiQJC',1),
('Ouling','Ruan Hongyu',22,'CHINA','OulingQJC',1),
('YangYi','Wang Zhiguo',20,'CHINA','YangYiQJC',1),
('Xinan','Liu Wenzhen',21,'CHINA','XinanQJC',1)
;
select*from player;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('Anzai','Su Ruihao',20,'CHINA','AnzaiWL',2),
('NIAN','Xu Ruijie',20,'CHINA','NIANWL',2),
('Pegg','Wang Jiahui',19,'CHINA','PeggWL',2),
('King','Lin Chengyi',20,'CHINA','KingWL',2),
('XQing','Yang Kaihao',21,'CHINA','XQingWL',2)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('Guagua','Su ihao',20,'CHINA','GuaGuaSPG',3),
('Chu','xuijie',20,'CHINA','ChuSPG',3),
('Nanchuang','Wan',19,'CHINA','NanchuangSPG',3),
('Bird','Lhengyi',22,'CHINA','BirdSPG',3),
('Swan','Yang',21,'CHINA','SwanSPG',3)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('Bista','NO INFO',22,'JAPAN','BistaVolt',4),
('Ecchan','NO INFO',19,'JAPAN','EcchanVolt',4),
('Mic','Jono Kai',20,'JAPAN','MicVolt',4),
('UnLucky','NO INFO',22,'JAPAN','UnLuckyVolt',4),
('Dolaky','NO INFO',21,'JAPAN','DolakyVolt',4)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('B1ngo','Declan Bong',19,'Malaysia','B1ngoPH',5),
('Incendio','Toh Jun Hui',24,'Singapore','IncendioPH',5),
('IrfanJ','	Irfan Jaffri',20,'Singapore','IrfanJPH',5),
('Sh4d4p','Arifin Salim',22,'Singapore','Sh4d4pPH',5),
('Skerd','Averson Salaya',21,'Philippines','SkerdPH',5)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('Clove','Andhika',18,'Indonesia','CloveKG',6),
('Frann','Giffran',24,'Indonesia','KGFrann',6),
('Zen','Rivaturahman',20,'Indonesia','ZenKG',6),
('Mecyx',' Anderson',22,'Indonesia','MEcyxKG',6),
('Reef','Maulana Rifky',21,'Indonesia','ReefKG',6)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('Learn','Jash Shah',23,'INDIA','LearnGL',7),
('Neutrino','Zeel Patel',24,'INDIA','GL_Neutrino',7),
('TrunKs','Rishi Dubey',21,'INDIA','Trunks_GL',7),
('SkullGuy','Aniket Majumdar',22,'INDIA','GL_SkullGuy',7),
('AbhizDADA','Abhishek Nagar',20,'INDIA','AbhiZGL',7)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('JOKOs','Samartha Ganesh Ghadge',21,'INDIA','JOkosVt',8),
('SAMs','Samruddha Ghadge',21,'INDIA','VTSams',8),
('Broszxs','Sameer Sinha',25,'INDIA','BrosVT',8),
('BurnZ','Chiranthan Shetty',24,'INDIA','BurnzVT',8),
('Vegaz','Anirudh Vhavle',23,'INDIA','VegzVT',8)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('Banned','Kent Nerves',21,'Philippines','LG_Banned',9),
('Marshy','Angel Gonzalez',21,'United States','Marshy_LG',9),
('Tectonic','Brian Michel',21,'United States','TectonicLG',9),
('Vague','Maiwand Zai',20,'Canada','LGM_Vague',9),
('Washy','Christian Manalo',20,'Philippines','LG_Washy',9)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('AyeoRaph','Raphael Gebremedhin',20,'Canada','TM_Ayeo',10),
('Carte1s','Lasel Sin',19,'United States','TM_Cartz',10),
('JesusSaves','Adam Khreis',21,'Canada','TM_JS',10),
('Blurr','Angel Gonzalez',20,'Puerto Rico','Blurz_tm',10),
('Kingz','NO_INFO',20,'United States','KingzTMS',10)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('Rebalo','NO_INFO',21,'Iraq','TG_Reba',11),
('Solo','Solomon Smith',19,'United States','TG_solo',11),
('Space','Corey Brown',21,'United States','TG_Spaxe',11),
('Jezz','NO_INFO',20,'United States','JEzz',11),
('Sthug','NO_INFO',20,'Mexico','Sthug_TG',11)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('Saze','Adam Kalem',21,'France','KC_Saze',12),
('cZSpy','Petr Karásek',20,'Czechia','KCCZspy',12),
('Rayyd','NO_INFO',21,'France','Rayyd_KC',12),
('Marvel','Gustav',26,'France','MarvelKC',12),
('Grizz','Will S.',21,'United Kingdom','Griz_kC',12)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('vere','Faith Camgöz',21,'Germany','EXL_VERE',13),
('Neil','Geneil Rae Dacanay',22,'Philippines','EXL_Neil',13),
('Creed','Serhat Atilla',21,'Netherlands','Credd_EXl',13),
('Champi','Emre K',22,'Denmark','Champi_EXl',13),
('Sh4rk','NO_INFO',21,'France','EXL_Sh4rk',13)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('Tetillo','Leonel Fernández',25,'Mexico','TLE_Tetillo',14),
('Saucy','Alexander Sánchez',22,'Peru','Saucy_TLE',14),
('Zyrax','César Treviño',21,'Mexico','Zyrax_TLe',14),
('Shisui','Mauricio Díaz',22,'Mexico','TLE_Shisui',14),
('PABZERA','Pedro Arthur Barbosa',22,'Brazil','PABZ.TLE',14)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('B1godera','João Pedro Teixeira',24,'Brazil','Loops_B1god',15),
('Keyotk','Ricke Ramon',22,'Brazil','Keyotk_loops',15),
('Magg1e','Lucas Costa',20,'Brazil','Maggle_lps',15),
('KiNg','Rodrigo Masson',21,'Brazil','King_loops',15),
('Krozin','Vitor Leandro da Silva',21,'Brazil','Krozin_loops',15)
;

insert into player(PlayerRosterName, PlayerName,Age,Nationality,GamingHandle,TeamID)
values
('DaD','Lucas Rossi',23,'Brazil','Dad_incogaming',16),
('LiNBZ','Gustavo Lin Pacifico',21,'Brazil','LinBZ_IG',16),
('Lucaszin','Lucas Joia Ferreira',19,'Brazil','Lucasz_IG',16),
('LeozZera','Leonardo Padilha',21,'Brazil','Leoz_IG',16),
('Dermec','Pedro Henrique Ramos',22,'Brazil','Dermec_IG',16)
;

insert into game(GameTitle,Genre,ReleaseDate,Platforms,EsportsRating)
values
('Call_Of_Duty_Mobile','FPS_Shooting','2019-10-01','Mobile',0.8)
;

select* from game;

insert into caster( CasterName,BroadcastingPlatform,ExperienceLevel,SpecialtyGames,CastingStyle)
values
('GlitterXplosion','CODM_Site','1-Year','Codm,csgo,Valorent','Analyst'),
('Gilmania','CODM_Site','2-Year','Codm,csgo','Educational Caster'),
('TheMustachio AJ','CODM_Site','1-Year','Codm,Fornite','Hype Caster,commentator'),
('Alpha','Youtube','3-Year','FPS','Play-by-play')
;

select*from caster;

insert into sponsor(SponsorName,SponsorType,SponsorContactInformation,SponsorshipStartDate,SponsorshipEndDate,SponsorshipAmount)
values
('Sony','Official Partners','electronics.sony.com','2023-12-15','2023-12-17','1000000'),
('Snapdragon','Endemic Sponsors','snapdragon.com','2023-12-15','2023-12-17','200000'),
('SAMSUNG','Gear Sponsors','samsung.com','2023-12-15','2023-12-17','10000')
;
select*from sponsor;

insert into tournament(TournamentID,TournamentName,Organizer,PrizePool,StartDate,EndDate,CasterID,SponsorID,TournamentFormat)
values
(1,'Call of Duty Mobile World Championship',' Activision','1000000','2023-12-15','2023-12-17',1,2,'Hybrid')
;

select*from tournament;

insert into venue(venueid,venuename,location,capacity,amenities,bookingavailability,rentalcost) 
values
(1,'Georgia World Congress Center','Atlanta',350000,'Monitors,Info Desks,ATMs',TRUE,2000000);

select*from venue;

insert into matches(VenueID,TournamentID,GameID,Matchtype,Team1ID,Team2ID,Team1Score,Team2Score,Round,Matchdate) values
(1,1,1,'Swiss',1,8,2,0,1,'2023-12-15'),
(1,1,1,'Swiss',14,3,0,2,1,'2023-12-15'),
(1,1,1,'Swiss',9,16,2,1,1,'2023-12-15'),
(1,1,1,'Swiss',5,11,0,2,1,'2023-12-15'),
(1,1,1,'Swiss',12,2,0,2,1,'2023-12-15'),
(1,1,1,'Swiss',7,6,1,2,1,'2023-12-15'),
(1,1,1,'Swiss',4,13,2,0,1,'2023-12-15'),
(1,1,1,'Swiss',10,15,1,2,1,'2023-12-15')
;

select*from matches;

insert into matches(VenueID,TournamentID,GameID,Matchtype,Team1ID,Team2ID,Team1Score,Team2Score,Round,Matchdate) values
(1,1,1,'Swiss',14,8,2,0,2,'2023-12-15'),
(1,1,1,'Swiss',9,11,2,1,2,'2023-12-15'),
(1,1,1,'Swiss',1,3,2,1,2,'2023-12-15'),
(1,1,1,'Swiss',2,6,2,0,2,'2023-12-15'),
(1,1,1,'Swiss',15,4,0,2,2,'2023-12-15'),
(1,1,1,'Swiss',5,16,2,1,2,'2023-12-15'),
(1,1,1,'Swiss',12,7,0,2,2,'2023-12-15'),
(1,1,1,'Swiss',13,10,2,0,2,'2023-12-15');

insert into matches(VenueID,TournamentID,GameID,Matchtype,Team1ID,Team2ID,Team1Score,Team2Score,Round,Matchdate) values
(1,1,1,'Swiss',2,1,2,1,3,'2023-12-15'),
(1,1,1,'Swiss',8,12,0,2,3,'2023-12-15'),
(1,1,1,'Swiss',7,13,2,0,3,'2023-12-15'),
(1,1,1,'Swiss',5,3,0,2,3,'2023-12-15'),
(1,1,1,'Swiss',14,11,2,0,3,'2023-12-15'),
(1,1,1,'Swiss',6,15,2,0,3,'2023-12-15'),
(1,1,1,'Swiss',9,4,2,1,3,'2023-12-15'),
(1,1,1,'Swiss',10,16,2,1,3,'2023-12-15');

insert into matches(VenueID,TournamentID,GameID,Matchtype,Team1ID,Team2ID,Team1Score,Team2Score,Round,Matchdate) values
(1,1,1,'Swiss',1,6,2,0,4,'2023-12-15'),
(1,1,1,'Swiss',7,14,2,1,4,'2023-12-15'),
(1,1,1,'Swiss',3,4,2,0,4,'2023-12-15'),
(1,1,1,'Swiss',11,10,2,1,4,'2023-12-15'),
(1,1,1,'Swiss',12,13,0,2,4,'2023-12-15'),
(1,1,1,'Swiss',5,15,2,0,4,'2023-12-15');

insert into matches(VenueID,TournamentID,GameID,Matchtype,Team1ID,Team2ID,Team1Score,Team2Score,Round,Matchdate) values
(1,1,1,'Swiss',14,6,0,2,5,'2023-12-15'),
(1,1,1,'Swiss',5,13,2,1,5,'2023-12-15'),
(1,1,1,'Swiss',11,4,2,0,5,'2023-12-15');

insert into matches(VenueID,TournamentID,GameID,Matchtype,Team1ID,Team2ID,Team1Score,Team2Score,Round,Matchdate) values
(1,1,1,'Playoffs',9,6,3,0,'Quarterfinals','2023-12-16'),
(1,1,1,'Playoffs',3,7,0,3,'Quarterfinals','2023-12-16'),
(1,1,1,'Playoffs',1,5,3,0,'Quarterfinals','2023-12-16'),
(1,1,1,'Playoffs',11,2,0,3,'Quarterfinals','2023-12-16'),
(1,1,1,'Playoffs',9,7,2,3,'Semifinals','2023-12-17'),
(1,1,1,'Playoffs',1,2,0,3,'Semifinals','2023-12-17'),
(1,1,1,'Playoffs',7,2,2,4,'Grand Finals','2023-12-18');

insert into BracketMatch(MatchID,WinnerID,ParentMatchID,BracketType) values
(1,1,NULL,'Swiss'),
(2,3,NULL,'Swiss'),
(3,9,NULL,'Swiss'),
(4,11,NULL,'Swiss'),
(5,2,NULL,'Swiss'),
(6,6,NULL,'Swiss'),
(7,4,NULL,'Swiss'),
(8,15,NULL,'Swiss'),
(9,14,NULL,'Swiss'),
(10,9,NULL,'Swiss'),
(11,1,NULL,'Swiss'),
(12,2,NULL,'Swiss'),
(13,4,NULL,'Swiss'),
(14,5,NULL,'Swiss'),
(15,7,NULL,'Swiss'),
(16,13,NULL,'Swiss'),
(17,2,NULL,'Swiss'),
(18,12,NULL,'Swiss'),
(19,7,NULL,'Swiss'),
(20,3,NULL,'Swiss'),
(21,14,NULL,'Swiss'),
(22,6,NULL,'Swiss'),
(23,9,NULL,'Swiss'),
(24,10,NULL,'Swiss'),
(25,1,NULL,'Swiss'),
(26,7,NULL,'Swiss'),
(27,3,NULL,'Swiss'),
(28,11,NULL,'Swiss'),
(29,13,NULL,'Swiss'),
(30,5,NULL,'Swiss'),
(31,6,NULL,'Swiss'),
(32,5,NULL,'Swiss'),
(33,11,NULL,'Swiss'),
(34,9,NULL,'Playoffs'),
(35,7,NULL,'Playoffs'),
(36,1,NULL,'Playoffs'),
(37,2,NULL,'Playoffs');

select*from bracketmatch;

insert into BracketMatch(MatchID,WinnerID,ParentMatchID,BracketType) values
(38,7,35,'Playoffs'),
(39,2,37,'Playoffs'),
(40,2,39,'Playoffs');

insert into PrizePool(TournamentID,Place,PrizeAmount) values
(1,1,400000),
(1,2,170000),
(1,3,80000),
(1,4,80000),
(1,5,40000),
(1,6,40000),
(1,7,40000),
(1,8,40000),
(1,9,20000),
(1,10,20000),
(1,11,20000),
(1,12,12000),
(1,13,12000),
(1,14,12000),
(1,15,7000),
(1,16,7000);

select*from PrizePool;

insert into coach(CoachName,CoachingExperience,TeamID,CoachRole) values
('SH1NE',12,1,'Head Coach'),
('Mikasa',13,2,'Strategic Coach'),
('Per',9,3,'Analyst Coach'),
('Pepu',12,4,'Head Coach'),
('FDx',3,5,'Strategic Coach'),
('Dioxide',24,6,'Head Coach'),
('Ygor',12,7,'Head Coach'),
('ZIM',15,8,'Strategic Coach'),
('Clout',16,9,'Analyst Coach'),
('KBR',17,10,'Strategic Coach'),
('Chief Pat',20,11,'Head Coach'),
('Palitão',14,12,'Analyst Coach'),
('ayonix',18,13,'Head Coach'),
('Alma',20,14,'Technical Coach'),
('Major',12,15,'Head Coach'),
('Glda7',16,16,'Head Coach');

select*from coach;

insert into TournamentStandings (TournamentID, TeamID, Position) values 
(1,1,3),
(1,2,1),
(1,3,5),
(1,4,9),
(1,5,5),
(1,6,5),
(1,7,2),
(1,8,15),
(1,9,3),
(1,10,12),
(1,11,5),
(1,12,12),
(1,13,9),
(1,14,9),
(1,15,12),
(1,16,15);


select*from TournamentStandings;
-- --------------------------------------------------------------------------------------------------------------------------------------------
/* INSERT INTO TournamentStandings (TournamentID, TeamID, Position)  -- Populate the TournamentStandings table with positions
SELECT
    m.TournamentID,
    t.TeamID,
    RANK() OVER (PARTITION BY m.TournamentID ORDER BY TotalWins DESC) AS Position
FROM
    Matches m
JOIN
    Team t ON t.TeamID = m.Team1ID OR t.TeamID = m.Team2ID
GROUP BY
    m.TournamentID, t.TeamID; */
    