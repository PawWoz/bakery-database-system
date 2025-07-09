CREATE DATABASE Piekarnia;

USE Piekarnia
GO

CREATE TABLE Wojewodztwa(
    IdWojewodztwa INT PRIMARY KEY NOT NULL,
    Wojewodztwo VARCHAR(19) NOT NULL
);

CREATE TABLE Sklepy (
    IdSklepu INT PRIMARY KEY NOT NULL,
    NazwaSklepu VARCHAR(50) NOT NULL,
    Adres VARCHAR(50) NOT NULL,
    Nip VARCHAR(10) NOT NULL UNIQUE,
    Telefon VARCHAR(12),
    TelefonKomorkowy VARCHAR(14),
    Email VARCHAR(50),
    KodPocztowy VARCHAR(6) NOT NULL,
    Miejscowosc VARCHAR(35) NOT NULL,
    IdWojewodztwa INT NOT NULL,
    FOREIGN KEY (IdWojewodztwa) REFERENCES Wojewodztwa(IdWojewodztwa)
);

CREATE TABLE KategorieProduktow (
    IdKategorii INT PRIMARY KEY NOT NULL,
    NazwaKategorii VARCHAR(30) NOT NULL
);

CREATE TABLE Opakowania (
    IdOpakowania INT PRIMARY KEY NOT NULL,
    RodzajOpakowania VARCHAR(30) NOT NULL
);

CREATE TABLE Produkty (
    IdProduktu INT PRIMARY KEY NOT NULL,
    IdKategorii INT NOT NULL,
    IdOpakowania INT NOT NULL,
    NazwaProduktu VARCHAR(30) NOT NULL,
    OpisProduktu VARCHAR(50) NOT NULL,
    CenaProduktu DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (IdKategorii) REFERENCES KategorieProduktow(IdKategorii),
    FOREIGN KEY (IdOpakowania) REFERENCES Opakowania(IdOpakowania)
);

CREATE TABLE Plcie (
    IdPlec INT PRIMARY KEY NOT NULL,
    Plec VARCHAR(9) NOT NULL,
    SymbolPlci CHAR(1) NOT NULL
);

CREATE TABLE Stanowiska (
    IdStanowiska INT PRIMARY KEY NOT NULL,
    Stanowisko VARCHAR(50) NOT NULL
);

CREATE TABLE StawkiPracownikow (
    IdStawki INT PRIMARY KEY NOT NULL,
    KwotaStawki DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Pracownicy (
    IdPracownika INT PRIMARY KEY NOT NULL,
    Imie VARCHAR(15) NOT NULL,
    Nazwisko VARCHAR(30) NOT NULL,
    Pesel VARCHAR(11) NOT NULL UNIQUE,
    Telefon VARCHAR(12),
    TelefonKomorkowy VARCHAR(14),
    IdStanowiska INT NOT NULL,
    Email VARCHAR(50),
    IdStawki INT NOT NULL,
    IdPlec INT NOT NULL
	FOREIGN KEY (IdStanowiska) REFERENCES Stanowiska(IdStanowiska),
	FOREIGN KEY (IdStawki) REFERENCES StawkiPracownikow(IdStawki),
	FOREIGN KEY (IdPlec) REFERENCES Plcie(IdPlec)
);

CREATE TABLE Szkolenia (
    IdSzkolenia INT PRIMARY KEY NOT NULL,
    NazwaSzkolenia VARCHAR(50) NOT NULL,
    DataSzkolenia DATE NOT NULL
);

CREATE TABLE ZapisaniNaSzkolenia (
    IdZapisani INT PRIMARY KEY NOT NULL,
    IdPracownika INT NOT NULL,
    IdSzkolenia INT NOT NULL,
    FOREIGN KEY (IdPracownika) REFERENCES Pracownicy(IdPracownika),
    FOREIGN KEY (IdSzkolenia) REFERENCES Szkolenia(IdSzkolenia)
);

CREATE TABLE PrzebiegDniaPracy (
    IdPrzebiegu INT PRIMARY KEY NOT NULL,
    IdPracownika INT NOT NULL,
    Data DATE NOT NULL,
    LiczbaGodzin INT NOT NULL,
    FOREIGN KEY (IdPracownika) REFERENCES Pracownicy(IdPracownika)
);

CREATE TABLE Zamowienia (
    IdZamowienia INT PRIMARY KEY NOT NULL,
    IdSklepu INT NOT NULL,
    DataZamowienia DATE NOT NULL,
	IdSamochodu INT NOT NULL,
    FOREIGN KEY (IdSklepu) REFERENCES Sklepy(IdSklepu),
	FOREIGN KEY (IdSamochodu) REFERENCES Samochody (IdSamochodu)
);

CREATE TABLE SzczegolyZamowien (
    IdSzczegoluZam INT PRIMARY KEY NOT NULL,
    IdZamowienia INT NOT NULL,
    IdProduktu INT NOT NULL,
    Ilosc INT NOT NULL,
    FOREIGN KEY (IdZamowienia) REFERENCES Zamowienia(IdZamowienia),
    FOREIGN KEY (IdProduktu) REFERENCES Produkty(IdProduktu)
);

CREATE TABLE Samochody (
    IdSamochodu INT PRIMARY KEY NOT NULL,
    NumerRejestracyjny VARCHAR(8) NOT NULL UNIQUE,
    Vin VARCHAR(17) NOT NULL UNIQUE,
    RodzajPaliwa CHAR(2) NOT NULL,
    Marka VARCHAR(30) NOT NULL,
    IdPracownika INT NOT NULL,
    FOREIGN KEY (IdPracownika) REFERENCES Pracownicy(IdPracownika)
);

CREATE TABLE Zwroty (
    IdZwrotu INT PRIMARY KEY NOT NULL,
    IdSklepu INT NOT NULL,
    DataZwrotu DATE NOT NULL,
    Pow�d VARCHAR(50) NOT NULL,
	IdPracownika INT NOT NULL,
    FOREIGN KEY (IdSklepu) REFERENCES Sklepy(IdSklepu),
	FOREIGN KEY (IdPracownika) REFERENCES Pracownicy(IdPracownika)
);

CREATE TABLE SzczegolyZwrotow (
    IdSzczegZwrotu INT PRIMARY KEY NOT NULL,
    IdZwrotu INT NOT NULL,
    IdProduktu INT NOT NULL,
    IdZamowienia INT NOT NULL,
    Ilosc INT NOT NULL,
    FOREIGN KEY (IdZwrotu) REFERENCES Zwroty(IdZwrotu),
    FOREIGN KEY (IdProduktu) REFERENCES Produkty(IdProduktu),
    FOREIGN KEY (IdZamowienia) REFERENCES Zamowienia(IdZamowienia)
);

CREATE TABLE Magazyn (
    IdMagazynu INT PRIMARY KEY NOT NULL,
    NazwaMagazynu VARCHAR(50) NOT NULL,
    Adres VARCHAR(50) NOT NULL,
    KodPocztowy VARCHAR(6) NOT NULL,
    Miejscowosc VARCHAR(35) NOT NULL,
    IdWojewodztwa INT NOT NULL,
    FOREIGN KEY (IdWojewodztwa) REFERENCES Wojewodztwa(IdWojewodztwa)
);

CREATE TABLE Skladniki (
    IdSk�adnika INT PRIMARY KEY NOT NULL,
    NazwaSkladnika VARCHAR(30) NOT NULL,
    OpisSkladnika VARCHAR(50),
    JednostkaMiary VARCHAR(5) NOT NULL
);

CREATE TABLE Dostawcy (
    IdDostawcy INT PRIMARY KEY NOT NULL,
    NazwaDostawcy VARCHAR(50) NOT NULL,
    Adres VARCHAR(50) NOT NULL,
    Nip VARCHAR(10) NOT NULL UNIQUE,
    Telefon VARCHAR(12),
    TelefonKomorkowy VARCHAR(14),
    Email VARCHAR(50),
    KodPocztowy VARCHAR(6) NOT NULL,
    Miejscowosc VARCHAR(35) NOT NULL,
    IdWojewodztwa INT NOT NULL,
    FOREIGN KEY (IdWojewodztwa) REFERENCES Wojewodztwa(IdWojewodztwa)
);

CREATE TABLE Dostawy (
    IdDostawy INT PRIMARY KEY NOT NULL,
    IdDostawcy INT NOT NULL,
    DataDostawy DATE NOT NULL,
    KwotaDostawy DECIMAL(10, 2) NOT NULL,
    IdMagazynu INT NOT NULL,
    FOREIGN KEY (IdDostawcy) REFERENCES Dostawcy(IdDostawcy),
    FOREIGN KEY (IdMagazynu) REFERENCES Magazyn(IdMagazynu)
);

CREATE TABLE SzczegolyDostaw (
    IdSzczegoluDostawy INT PRIMARY KEY NOT NULL,
    IdDostawy INT NOT NULL,
    IdSkladnika INT NOT NULL,
    Ilosc INT NOT NULL,
    FOREIGN KEY (IdDostawy) REFERENCES Dostawy(IdDostawy),
    FOREIGN KEY (IdSkladnika) REFERENCES Skladniki(IdSk�adnika)
);

CREATE TABLE Informacje(
	IdInfo INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Wiadomosc VARCHAR(500) NOT NULL,
	Gdzie VARCHAR(128) NOT NULL,
	Data DATETIME NOT NULL
);

-- Indeks dla kolumny NazwaSklepu w tabeli Sklepy
CREATE INDEX idx_nazwa_sklepu ON Sklepy (NazwaSklepu);

-- Unikalny indeks dla kolumny Nip w tabeli Sklepy
CREATE UNIQUE INDEX ui_nip_sklepu ON Sklepy (Nip);

-- Unikalny indeks dla kolumny Nip w tabeli Dostawcy
CREATE UNIQUE INDEX ui_nip_dostawcy ON Dostawcy (Nip);

-- Unikalny indeks dla kolumny Pesel w tabeli Pracownicy
CREATE UNIQUE INDEX ui_pesel ON Pracownicy (Pesel);

-- Indeks dla kolumny Data w tabeli PrzebiegDniaPracy
CREATE INDEX idx_data_dzien_rob ON PrzebiegDniaPracy (Data);

-- Indeks dla kolumny NazwaSkladnika w tabeli Skladniki
CREATE INDEX idx_nazwa_skladnika ON Skladniki (NazwaSkladnika);

-- Indeks dla kolumny NazwaProduktu w tabeli Produkty
CREATE INDEX idx_nazwa_produktu ON Produkty (NazwaProduktu);

-- Indeks dla kolumny DataZamowienia w tabeli Zamowienia
CREATE INDEX idx_data_zamowienia ON Zamowienia (DataZamowienia);

-- Unikalny indeks dla kolumny NumerRejestracyjny w tabeli Samochody
CREATE UNIQUE INDEX ui_numer_rej ON Samochody (NumerRejestracyjny);

-- Unikalny indeks dla kolumny Vin w tabeli Samochody
CREATE UNIQUE INDEX ui_vin ON Samochody (Vin);

INSERT INTO Wojewodztwa (IdWojewodztwa, Wojewodztwo) VALUES
(1, 'dolno�l�skie'),
(2, 'kujawsko-pomorskie'),
(3, 'lubelskie'),
(4, 'lubuskie'),
(5, '��dzkie'),
(6, 'ma�opolskie'),
(7, 'mazowieckie'),
(8, 'opolskie'),
(9, 'podkarpackie'),
(10, 'podlaskie'),
(11, 'pomorskie'),
(12, '�l�skie'),
(13, '�wi�tokrzyskie'),
(14, 'warmi�sko-mazurskie'),
(15, 'wielkopolskie'),
(16, 'zachodniopomorskie');

INSERT INTO Sklepy (IdSklepu, NazwaSklepu, Adres, Nip, Telefon, TelefonKomorkowy, Email, KodPocztowy, Miejscowosc, IdWojewodztwa) VALUES
(1, 'Piekarnia Warszawska', 'Gr�jecka 7', '1234567890', '111222333', '833199222', 'warszawska@piekarnia.pl', '00-001', 'Warszawa', 6),
(2, 'Piekarnia M�ka', 'Kopci�skiego 64', '1234567891', '123123123', '033823182', 'maka@piekarnia.pl', '60-001', '��d�', 5),
(3, 'Piekarnia Pawe�ek', 'Legion�w 66', '1234567892', '456456456', '666777111', 'pawelek@piekarnia.pl', '30-001', 'Wo�omin', 6),
(4, 'Piekarnia Putka', 'Piotrkowska 193', '1234567893', '444555666', '166166611', 'putka@piekarnia.pl', '40-001', '��d�', 5),
(5, 'Piekarnia K�os', '�elazna 1', '1234567894', '787787787', '957217222', 'klos@piekarnia.pl', '50-001', 'Katowica', 12);

INSERT INTO KategorieProduktow (IdKategorii, NazwaKategorii) VALUES
(1, 'Chleby'),
(2, 'Bu�ki'),
(3, 'Ciasta'),
(4, 'Przek�ski S�one'),
(5, 'Przek�ski S�odkie');

INSERT INTO Opakowania (IdOpakowania, RodzajOpakowania) VALUES
(1, 'Papier'),
(2, 'Folia'),
(3, 'Pude�ko kartonowe'),
(4, 'Torebka papierowa'),
(5, 'Plastik');

INSERT INTO Produkty (IdProduktu, IdKategorii, IdOpakowania, NazwaProduktu, OpisProduktu, CenaProduktu) VALUES
(1, 1, 1, 'Chleb �ytni', 'Chleb �ytni na zakwasie', 4.50),
(2, 2, 4, 'Bu�ka Kajzerka', 'Tradycyjna bu�ka kajzerka', 0.60),
(3, 3, 3, 'Ciasto Czekoladowe', 'Ciasto czekoladowe z polew�', 12.00),
(4, 4, 2, 'Bagietka Czosnkowa', 'Bagietka czosnkowa', 3.00),
(5, 5, 2, 'Muffin Czekoladowy', 'Muffin czekoladowy z kawa�kami czekolady', 2.50);

-- Wype�nienie tabeli Plcie
INSERT INTO Plcie (IdPlec, Plec, SymbolPlci) VALUES
(1, 'M�czyzna', 'M'),
(2, 'Kobieta', 'K');

-- Wype�nienie tabeli Stanowiska
INSERT INTO Stanowiska (IdStanowiska, Stanowisko) VALUES
(1, 'Sprzedawca'),
(2, 'Piekarz'),
(3, 'Kierownik Sklepu'),
(4, 'Magazynier'),
(5, 'Kierowca');

-- Wype�nienie tabeli StawkiPracownikow
INSERT INTO StawkiPracownikow (IdStawki, KwotaStawki) VALUES
(1, 15.00),
(2, 18.00),
(3, 20.00),
(4, 22.00),
(5, 25.00);

-- Wype�nienie tabeli Szkolenia
INSERT INTO Szkolenia (IdSzkolenia, NazwaSzkolenia, DataSzkolenia) VALUES
(1, 'Bezpiecze�stwo pracy', '2024-06-01'),
(2, 'Obs�uga klienta', '2024-06-02'),
(3, 'Techniki sprzeda�y', '2024-06-03'),
(4, 'Przygotowanie pieczywa', '2024-06-04'),
(5, 'Zarz�dzanie zespo�em', '2024-06-05');

-- Wype�nienie tabeli Pracownicy
INSERT INTO Pracownicy (IdPracownika, Imie, Nazwisko, Pesel, Telefon, TelefonKomorkowy, IdStanowiska, Email, IdStawki, IdPlec) VALUES
(1, 'Jan', 'Kowalski', '12345678901', '222333444', '666777888', 1, 'jan.kowalski@piekarnia.pl', 1, 1),
(2, 'Anna', 'Nowak', '12345678902', '222333445', '666777889', 2, 'anna.nowak@piekarnia.pl', 2, 2),
(3, 'Piotr', 'Wi�niewski', '12345678903', '222333446', '666777890', 3, 'piotr.wisniewski@piekarnia.pl', 3, 1),
(4, 'Katarzyna', 'W�jcik', '12345678904', '222333447', '666777891', 4, 'katarzyna.wojcik@piekarnia.pl', 4, 2),
(5, 'Tomasz', 'Kowalczyk', '12345678905', '222333448', '666777892', 5, 'tomasz.kowalczyk@piekarnia.pl', 5, 1);

-- Wype�nienie tabeli ZapisaniNaSzkolenia
INSERT INTO ZapisaniNaSzkolenia (IdZapisani, IdPracownika, IdSzkolenia) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

-- Wype�nienie tabeli PrzebiegDniaPracy
INSERT INTO PrzebiegDniaPracy (IdPrzebiegu, IdPracownika, Data, LiczbaGodzin) VALUES
(1, 1, '2024-05-01', 8),
(2, 2, '2024-05-01', 8),
(3, 3, '2024-05-01', 8),
(4, 4, '2024-05-01', 8),
(5, 5, '2024-05-01', 8);

INSERT INTO Skladniki (IdSk�adnika, NazwaSkladnika, OpisSkladnika, JednostkaMiary) VALUES
(1, 'M�ka Pszenna', 'M�ka pszenna typ 500', 'kg'),
(2, 'Dro�d�e', 'Dro�d�e suche', 'g'),
(3, 'S�l', 'S�l kuchenna', 'g'),
(4, 'Cukier', 'Cukier bia�y', 'g'),
(5, 'Woda', 'Woda mineralna', 'l');

INSERT INTO Magazyn (IdMagazynu, NazwaMagazynu, Adres, KodPocztowy, Miejscowosc, IdWojewodztwa) VALUES
(1, 'Magazyn Warszawa', 'Pu�awska 16', '00-002', 'Warszawa', 7),
(2, 'Magazyn Pozna�', 'Podolska 1', '60-002', 'Pozna�', 15),
(3, 'Magazyn Krak�w', 'Parkowa 32', '30-002', 'Krak�w', 6),
(4, 'Magazyn Katowice', 'Szkolna 7', '40-002', 'Katowice', 12),
(5, 'Magazyn Wroc�aw', 'Zachodnia 7', '50-002', 'Wroc�aw', 1);

INSERT INTO Dostawcy (IdDostawcy, NazwaDostawcy, Adres, Nip, Telefon, TelefonKomorkowy, Email, KodPocztowy, Miejscowosc, IdWojewodztwa) VALUES
(1, 'M�yn Warszawski', 'Gr�jecka 17', '2345678901', '999000111', '888888881', 'kontakt@mw-warszawski.pl', '00-003', 'Warszawa', 7),
(2, 'M�yn Pozna�ski', 'M�y�ska 2', '2345678902', '999000888', '888888882', 'kontakt@mw-poznanski.pl', '60-003', 'Pozna�', 15),
(3, 'M�yn Krakowski', 'Klasztorna 114', '2345678903', '999000777', '888888883', 'kontakt@mw-krakowski.pl', '30-003', 'Krak�w', 6),
(4, 'M�yn Katowicki', 'Mariacka 90', '2345678904', '999000333', '888888884', 'kontakt@mw-katowicki.pl', '40-003', 'Katowice', 12),
(5, 'M�yn Wroc�awski', 'Chopina 2', '2345678905', '999000222', '888888885', 'kontakt@mw-wroclawski.pl', '50-003', 'Wroc�aw', 1);

-- Wype�nienie tabeli Dostawy
INSERT INTO Dostawy (IdDostawy, IdDostawcy, DataDostawy, KwotaDostawy, IdMagazynu) VALUES
(1, 1, '2024-05-01', 500.00, 1),
(2, 2, '2024-05-02', 600.00, 2),
(3, 3, '2024-05-03', 700.00, 3),
(4, 4, '2024-05-04', 800.00, 4),
(5, 5, '2024-05-05', 900.00, 5);

-- Wype�nienie tabeli SzczegolyDostaw
INSERT INTO SzczegolyDostaw (IdSzczegoluDostawy, IdDostawy, IdSkladnika, Ilosc) VALUES
(1, 1, 1, 100),
(2, 2, 2, 200),
(3, 3, 3, 300),
(4, 4, 4, 400),
(5, 5, 5, 500);

-- Wype�nienie tabeli Samochody
INSERT INTO Samochody (IdSamochodu, NumerRejestracyjny, Vin, RodzajPaliwa, Marka, IdPracownika) VALUES
(1, 'WX12345', '1HGCM82633A123456', 'ON', 'Ford Transit', 1),
(2, 'PO54321', '1HGCM82633A654321', 'PB', 'Renault Master', 2),
(3, 'KR67890', '1HGCM82633A789012', 'ON', 'Mercedes Sprinter', 3),
(4, 'KT09876', '1HGCM82633A987654', 'PB', 'Fiat Ducato', 4),
(5, 'WR56789', '1HGCM82633A123987', 'ON', 'Volkswagen Crafter', 5);

-- Wype�nienie tabeli Zamowienia
INSERT INTO Zamowienia (IdZamowienia, IdSklepu, DataZamowienia, IdSamochodu) VALUES
(1, 1, '2024-05-01', 1),
(2, 2, '2024-05-02', 2),
(3, 3, '2024-05-03', 3),
(4, 4, '2024-05-04', 4),
(5, 5, '2024-05-05', 5);

-- Wype�nienie tabeli SzczegolyZamowien
INSERT INTO SzczegolyZamowien (IdSzczegoluZam, IdZamowienia, IdProduktu, Ilosc) VALUES
(1, 1, 1, 10),
(2, 2, 2, 20),
(3, 3, 3, 30),
(4, 4, 4, 40),
(5, 5, 5, 50);

-- Wype�nienie tabeli Zwroty
INSERT INTO Zwroty (IdZwrotu, IdSklepu, DataZwrotu, Pow�d, IdPracownika) VALUES
(1, 1, '2024-05-01', 'Niew�a�ciwy produkt', 1),
(2, 2, '2024-05-02', 'Uszkodzony towar', 2),
(3, 3, '2024-05-03', 'Niezgodno�� z zam�wieniem', 1),
(4, 4, '2024-05-04', 'Zbyt kr�tki termin wa�no�ci', 2),
(5, 5, '2024-05-05', 'B��dna ilo��', 3);

-- Wype�nienie tabeli SzczegolyZwrotow
INSERT INTO SzczegolyZwrotow (IdSzczegZwrotu, IdZwrotu, IdProduktu, IdZamowienia, Ilosc) VALUES
(1, 1, 1, 1, 1),
(2, 2, 2, 2, 2),
(3, 3, 3, 3, 3),
(4, 4, 4, 4, 4),
(5, 5, 5, 5, 5);

--Widoki
--Widok "vw_PracownicySzkolenia"
GO
CREATE VIEW vw_PracownicySzkolenia AS
SELECT 
    P.IdPracownika,
    P.Imie,
    P.Nazwisko,
    P.Pesel,
    P.Telefon,
    P.TelefonKomorkowy,
    P.Email,
    S.Stanowisko,
    St.KwotaStawki,
    Pl.Plec,
    Pl.SymbolPlci,
    Sz.IdSzkolenia,
    Sz.NazwaSzkolenia,
    Sz.DataSzkolenia
FROM 
    Pracownicy P
    INNER JOIN Stanowiska S ON P.IdStanowiska = S.IdStanowiska
    INNER JOIN StawkiPracownikow St ON P.IdStawki = St.IdStawki
    INNER JOIN Plcie Pl ON P.IdPlec = Pl.IdPlec
    INNER JOIN ZapisaniNaSzkolenia ZS ON P.IdPracownika = ZS.IdPracownika
    INNER JOIN Szkolenia Sz ON ZS.IdSzkolenia = Sz.IdSzkolenia;
GO
--Widok "vw_ProduktyKategorie"
CREATE VIEW vw_ProduktyKategorie AS
SELECT 
    P.IdProduktu,
    P.NazwaProduktu,
    P.OpisProduktu,
    P.CenaProduktu,
    K.IdKategorii,
    K.NazwaKategorii
FROM 
    Produkty P
    INNER JOIN KategorieProduktow K ON P.IdKategorii = K.IdKategorii;
GO
--Widok "vw_ZamowieniaSzczegoly"
CREATE VIEW vw_ZamowieniaSzczegoly AS
SELECT 
    Z.IdZamowienia,
    Z.DataZamowienia,
	Z.IdSamochodu,
    S.IdSklepu,
    S.NazwaSklepu,
    S.Adres AS AdresSklepu,
    SZ.IdSzczegoluZam,
    P.IdProduktu,
    P.NazwaProduktu,
    P.OpisProduktu,
    P.CenaProduktu,
    SZ.Ilosc
FROM 
    Zamowienia Z
    INNER JOIN SzczegolyZamowien SZ ON Z.IdZamowienia = SZ.IdZamowienia
    INNER JOIN Produkty P ON SZ.IdProduktu = P.IdProduktu
    INNER JOIN Sklepy S ON Z.IdSklepu = S.IdSklepu;
GO
--Widok "vw_DostawcyDostawy"
CREATE VIEW vw_DostawcyDostawy AS
SELECT 
    D.IdDostawcy,
    D.NazwaDostawcy,
    D.Adres AS AdresDostawcy,
    D.Nip AS NipDostawcy,
    D.Telefon AS TelefonDostawcy,
    D.TelefonKomorkowy AS TelefonKomorkowyDostawcy,
    D.Email AS EmailDostawcy,
    D.KodPocztowy AS KodPocztowyDostawcy,
    D.Miejscowosc AS MiejscowoscDostawcy,
    W.Wojewodztwo AS WojewodztwoDostawcy,
    DS.IdDostawy,
    DS.DataDostawy,
    DS.KwotaDostawy,
    M.NazwaMagazynu,
    M.Adres AS AdresMagazynu
FROM 
    Dostawcy D
    INNER JOIN Dostawy DS ON D.IdDostawcy = DS.IdDostawcy
    INNER JOIN Magazyn M ON DS.IdMagazynu = M.IdMagazynu
    INNER JOIN Wojewodztwa W ON D.IdWojewodztwa = W.IdWojewodztwa;
GO
--Widok "vw_SklepyZwroty"
CREATE VIEW vw_SklepyZwroty AS
SELECT 
    S.IdSklepu,
    S.NazwaSklepu,
    S.Adres AS AdresSklepu,
    S.Nip AS NipSklepu,
    S.Telefon AS TelefonSklepu,
    S.TelefonKomorkowy AS TelefonKomorkowySklepu,
    S.Email AS EmailSklepu,
    S.KodPocztowy AS KodPocztowySklepu,
    S.Miejscowosc AS MiejscowoscSklepu,
    W.Wojewodztwo AS WojewodztwoSklepu,
    Z.IdZwrotu,
    Z.DataZwrotu,
    Z.Pow�d AS PowodZwrotu,
	Z.IdPracownika
FROM 
    Sklepy S
    INNER JOIN Zwroty Z ON S.IdSklepu = Z.IdSklepu
    INNER JOIN Wojewodztwa W ON S.IdWojewodztwa = W.IdWojewodztwa;
GO
--Widok "vw_ProduktyOpakowania"
CREATE VIEW vw_ProduktyOpakowania AS
SELECT 
    P.IdProduktu,
    P.NazwaProduktu,
    P.OpisProduktu,
    P.CenaProduktu,
    O.IdOpakowania,
    O.RodzajOpakowania
FROM 
    Produkty P
    INNER JOIN Opakowania O ON P.IdOpakowania = O.IdOpakowania;
GO
--Widok "vw_PracownicySamochody"
CREATE VIEW vw_PracownicySamochody AS
SELECT 
    P.IdPracownika,
    P.Imie,
    P.Nazwisko,
    P.Pesel,
    P.Telefon,
    P.TelefonKomorkowy,
    P.Email,
    S.Stanowisko,
    St.KwotaStawki,
    Pl.Plec,
    Pl.SymbolPlci,
    Sa.IdSamochodu,
    Sa.NumerRejestracyjny,
    Sa.Vin,
    Sa.RodzajPaliwa,
    Sa.Marka
FROM 
    Pracownicy P
    INNER JOIN Stanowiska S ON P.IdStanowiska = S.IdStanowiska
    INNER JOIN StawkiPracownikow St ON P.IdStawki = St.IdStawki
    INNER JOIN Plcie Pl ON P.IdPlec = Pl.IdPlec
    LEFT JOIN Samochody Sa ON P.IdPracownika = Sa.IdPracownika;
GO
--Widok "vw_DostawyMagazyny"
CREATE VIEW vw_DostawyMagazyny AS
SELECT 
    DS.IdDostawy,
    DS.DataDostawy,
    DS.KwotaDostawy,
    D.IdDostawcy,
    D.NazwaDostawcy,
    D.Adres AS AdresDostawcy,
    D.Nip AS NipDostawcy,
    D.Telefon AS TelefonDostawcy,
    D.TelefonKomorkowy AS TelefonKomorkowyDostawcy,
    D.Email AS EmailDostawcy,
    D.KodPocztowy AS KodPocztowyDostawcy,
    D.Miejscowosc AS MiejscowoscDostawcy,
    W.Wojewodztwo AS WojewodztwoDostawcy,
    M.IdMagazynu,
    M.NazwaMagazynu,
    M.Adres AS AdresMagazynu,
    M.KodPocztowy AS KodPocztowyMagazynu,
    M.Miejscowosc AS MiejscowoscMagazynu
FROM 
    Dostawy DS
    INNER JOIN Dostawcy D ON DS.IdDostawcy = D.IdDostawcy
    INNER JOIN Magazyn M ON DS.IdMagazynu = M.IdMagazynu
    INNER JOIN Wojewodztwa W ON D.IdWojewodztwa = W.IdWojewodztwa;
GO
--Widok "vw_Sk�adnikiDostawy"
CREATE VIEW vw_SkladnikiDostawy AS
SELECT 
    DS.IdDostawy,
    DS.DataDostawy,
    DS.KwotaDostawy,
    DO.IdDostawcy,
    DO.NazwaDostawcy,
    DO.Adres AS AdresDostawcy,
    DO.Nip AS NipDostawcy,
    DO.Telefon AS TelefonDostawcy,
    DO.TelefonKomorkowy AS TelefonKomorkowyDostawcy,
    DO.Email AS EmailDostawcy,
    DO.KodPocztowy AS KodPocztowyDostawcy,
    DO.Miejscowosc AS MiejscowoscDostawcy,
    M.IdMagazynu,
    M.NazwaMagazynu,
    M.Adres AS AdresMagazynu,
    M.KodPocztowy AS KodPocztowyMagazynu,
    M.Miejscowosc AS MiejscowoscMagazynu,
    SK.IdSk�adnika,
    SK.NazwaSkladnika,
    SK.OpisSkladnika,
    SK.JednostkaMiary,
    SD.Ilosc
FROM 
    SzczegolyDostaw SD
    INNER JOIN Dostawy DS ON SD.IdDostawy = DS.IdDostawy
    INNER JOIN Dostawcy DO ON DS.IdDostawcy = DO.IdDostawcy
    INNER JOIN Magazyn M ON DS.IdMagazynu = M.IdMagazynu
    INNER JOIN Skladniki SK ON SD.IdSkladnika = SK.IdSk�adnika;
GO
--Widok "vw_DostawySzczegoly"
CREATE VIEW vw_DostawySzczegoly AS
SELECT 
    DS.IdDostawy,
    DS.DataDostawy,
    DS.KwotaDostawy,
    D.IdDostawcy,
    D.NazwaDostawcy,
    D.Adres AS AdresDostawcy,
    D.Nip AS NipDostawcy,
    D.Telefon AS TelefonDostawcy,
    D.TelefonKomorkowy AS TelefonKomorkowyDostawcy,
    D.Email AS EmailDostawcy,
    D.KodPocztowy AS KodPocztowyDostawcy,
    D.Miejscowosc AS MiejscowoscDostawcy,
    W.Wojewodztwo AS WojewodztwoDostawcy,
    M.IdMagazynu,
    M.NazwaMagazynu,
    M.Adres AS AdresMagazynu,
    M.KodPocztowy AS KodPocztowyMagazynu,
    M.Miejscowosc AS MiejscowoscMagazynu,
    S.IdSk�adnika,
    S.NazwaSkladnika,
    S.OpisSkladnika,
    S.JednostkaMiary,
    SD.Ilosc
FROM 
    SzczegolyDostaw SD
    INNER JOIN Dostawy DS ON SD.IdDostawy = DS.IdDostawy
    INNER JOIN Dostawcy D ON DS.IdDostawcy = D.IdDostawcy
    INNER JOIN Magazyn M ON DS.IdMagazynu = M.IdMagazynu
    INNER JOIN Wojewodztwa W ON D.IdWojewodztwa = W.IdWojewodztwa
    INNER JOIN Skladniki S ON SD.IdSkladnika = S.IdSk�adnika;

GO
--Widok "vw_MagazynySkladniki"
CREATE VIEW vw_MagazynySkladniki AS
SELECT 
    M.IdMagazynu,
    M.NazwaMagazynu,
    M.Adres AS AdresMagazynu,
    M.KodPocztowy AS KodPocztowyMagazynu,
    M.Miejscowosc AS MiejscowoscMagazynu,
    W.Wojewodztwo AS WojewodztwoMagazynu,
    S.IdSk�adnika,
    S.NazwaSkladnika,
    S.OpisSkladnika,
    S.JednostkaMiary,
    SD.Ilosc,
    D.IdDostawy,
    D.DataDostawy,
    DO.IdDostawcy,
    DO.NazwaDostawcy
FROM 
    Magazyn M
    INNER JOIN Wojewodztwa W ON M.IdWojewodztwa = W.IdWojewodztwa
    INNER JOIN Dostawy D ON M.IdMagazynu = D.IdMagazynu
    INNER JOIN Dostawcy DO ON D.IdDostawcy = DO.IdDostawcy
    INNER JOIN SzczegolyDostaw SD ON D.IdDostawy = SD.IdDostawy
    INNER JOIN Skladniki S ON SD.IdSkladnika = S.IdSk�adnika;
GO

--Procedury i triggery do modyfikacji danych

---PROCEDURE DEFINITION
---up_DodajPracownika
---CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura dodaj�ca nowego pracownika:
-- Parametry wej�ciowe:--    @IdPracownika INT - identyfikator pracownika
--    @Imie VARCHAR(15) - imi� pracownika
--    @Nazwisko VARCHAR(30) - nazwisko pracownika
--    @Pesel VARCHAR(11) - numer PESEL pracownika
--    @Telefon VARCHAR(12) - numer telefonu pracownika (opcjonalny)
--    @TelefonKomorkowy VARCHAR(14) - numer telefonu kom�rkowego pracownika (opcjonalny)
--    @IdStanowiska INT - identyfikator stanowiska pracownika
--    @Email VARCHAR(50) - adres email pracownika (opcjonalny)
--    @IdStawki INT - identyfikator stawki pracownika
--    @IdPlec INT - identyfikator p�ci pracownika
--
-- Parametry wyj�ciowe:
-- Dodano rekord do tabeli Pracownicy
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdPracownika INT = 1
DECLARE @Imie VARCHAR(15) = 'Jan';
DECLARE @Nazwisko VARCHAR(30) = 'Kowalski';
DECLARE @Pesel VARCHAR(11) = '12345678901';
DECLARE @IdStanowiska INT = 1;
DECLARE @IdStawki INT = 1;
DECLARE @IdPlec INT = 1;
EXEC DodajPracownika
    @Imie = @Imie,
    @Nazwisko = @Nazwisko,
    @Pesel = @Pesel,
    @IdStanowiska = @IdStanowiska,
    @IdStawki = @IdStawki,
    @IdPlec = @IdPlec;
*/
CREATE OR ALTER PROCEDURE up_DodajPracownika (
	@IdPracownika INT,
    @Imie VARCHAR(15),
    @Nazwisko VARCHAR(30),
    @Pesel VARCHAR(11),
    @Telefon VARCHAR(12) = NULL,
    @TelefonKomorkowy VARCHAR(14) = NULL,
    @IdStanowiska INT,
    @Email VARCHAR(50) = NULL,
    @IdStawki INT,
    @IdPlec INT
)
AS
BEGIN TRY
    BEGIN
        - Sprawdzenie, czy wszystkie pola s� uzupe�nione
        IF @IdPracownika IS NULL OR @Imie IS NULL OR @Nazwisko IS NULL OR @Pesel IS NULL OR @Telefon IS NULL OR @TelefonKomorkowy IS NULL OR @Email IS NULL
        BEGIN
            RAISERROR('Wszystkie pola musz� by� wype�nione.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie d�ugo�ci p�l
        IF LEN(@Imie) > 15 OR LEN(@Nazwisko) > 30 OR LEN(@Pesel) <> 11 OR LEN(@Telefon) > 12 OR LEN(@TelefonKomorkowy) > 14 OR LEN(@Email) > 50
        BEGIN
            RAISERROR('D�ugo�� pola przekroczy�a dopuszczalny limit.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu PESELu
        IF NOT @Pesel LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        BEGIN
            RAISERROR('Numer PESEL musi sk�ada� si� z 11 cyfr.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu telefonu
        IF @Telefon IS NOT NULL AND (LEN(@Telefon) <> 9 OR NOT @Telefon LIKE '[0-9]%' OR @Telefon NOT LIKE '_________')
        BEGIN
            RAISERROR('Numer telefonu musi sk�ada� si� z 9 cyfr.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu telefonu kom�rkowego
        IF @TelefonKomorkowy IS NOT NULL AND (LEN(@TelefonKomorkowy) <> 9 OR NOT @TelefonKomorkowy LIKE '[0-9]%' OR @TelefonKomorkowy NOT LIKE '_________')
        BEGIN
            RAISERROR('Numer telefonu kom�rkowego musi sk�ada� si� z 9 cyfr.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu adresu email
        IF @Email IS NOT NULL AND NOT @Email LIKE '%@%.%'
        BEGIN
            RAISERROR('Nieprawid�owy adres email.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy istnieje podane stanowisko
        IF NOT EXISTS (SELECT 1 FROM Stanowiska WHERE IdStanowiska = @IdStanowiska)
        BEGIN
            RAISERROR('Podane stanowisko nie istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy istnieje podana stawka
        IF NOT EXISTS (SELECT 1 FROM StawkiPracownikow WHERE IdStawki = @IdStawki)
        BEGIN
            RAISERROR('Podana stawka nie istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy istnieje podana p�e�
        IF NOT EXISTS (SELECT 1 FROM Plcie WHERE IdPlec = @IdPlec)
        BEGIN
            RAISERROR('Podana p�e� nie istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy pracownik o podanym PESELu ju� istnieje
        IF EXISTS (SELECT 1 FROM Pracownicy WHERE Pesel = @Pesel)
        BEGIN
            RAISERROR('Pracownik o podanym PESELu ju� istnieje.', 16, 1);
            RETURN;
        END

		-- Sprawdzenie unikalno�ci adresu e-mail
        IF EXISTS (SELECT 1 FROM Pracownicy WHERE Email = @Email)
        BEGIN
            RAISERROR('Adres e-mail jest ju� przypisany do innego pracownika.', 16, 1);
            RETURN;
        END

		-- Sprawdzenie unikalno�ci identyfikatora
		IF EXISTS (SELECT 1 FROM Pracownicy WHERE IdPracownika = @IdPracownika)
		BEGIN
			RAISERROR('Pracownik o podanym identyfikatorze ju� istnieje.', 16,1);
			RETURN;
		END

        -- Dodanie nowego pracownika
        INSERT INTO Pracownicy (Imie, Nazwisko, Pesel, Telefon, TelefonKomorkowy, IdStanowiska, Email, IdStawki, IdPlec)
        VALUES (@Imie, @Nazwisko, @Pesel, @Telefon, @TelefonKomorkowy, @IdStanowiska, @Email, @IdStawki, @IdPlec);

        PRINT 'Nowy pracownik zosta� dodany.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
---PROCEDURE DEFINITION
---up_UsunPracownika
---CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura usuwaj�ca pracownika:
-- Parametry wej�ciowe:
--    @IdPracownika INT - identyfikator pracownika do usuni�cia
--
-- Parametry wyj�ciowe:
-- Usuni�to rekord z tabeli Pracownicy
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdPracownika INT = 1;
EXEC UsunPracownika
    @IdPracownika = @IdPracownika;
*/
CREATE OR ALTER PROCEDURE up_UsunPracownika (
    @IdPracownika INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy pracownik istnieje
        IF NOT EXISTS (SELECT 1 FROM Pracownicy WHERE IdPracownika = @IdPracownika)
        BEGIN
            RAISERROR('Pracownik o podanym identyfikatorze nie istnieje.', 16, 1);
            RETURN;
        END

        -- Usuni�cie pracownika
        DELETE FROM Pracownicy WHERE IdPracownika = @IdPracownika;

        PRINT 'Pracownik zosta� usuni�ty.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
---PROCEDURE DEFINITION
---up_AktualizujPracownika
---CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura aktualizuj�ca dane pracownika:
-- Parametry wej�ciowe:
--    @IdPracownika INT - identyfikator pracownika do aktualizacji
--    @Imie VARCHAR(15) - nowe imi� pracownika
--    @Nazwisko VARCHAR(30) - nowe nazwisko pracownika
--    @Pesel VARCHAR(11) - nowy numer PESEL pracownika
--    @Telefon VARCHAR(12) - nowy numer telefonu pracownika
--    @TelefonKomorkowy VARCHAR(14) - nowy numer telefonu kom�rkowego pracownika
--    @IdStanowiska INT - nowy identyfikator stanowiska pracownika
--    @Email VARCHAR(50) - nowy adres email pracownika
--    @IdStawki INT - nowy identyfikator stawki pracownika
--    @IdPlec INT - nowy identyfikator p�ci pracownika
--
-- Parametry wyj�ciowe:
-- Zaktualizowano rekord w tabeli Pracownicy
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdPracownika INT = 1;
DECLARE @Imie VARCHAR(15) = 'NoweImie';
DECLARE @Nazwisko VARCHAR(30) = 'NoweNazwisko';
DECLARE @Pesel VARCHAR(11) = '12345678901';
DECLARE @Telefon VARCHAR(12) = '999888777';
DECLARE @TelefonKomorkowy VARCHAR(14) = '666555444';
DECLARE @IdStanowiska INT = 2;
DECLARE @Email VARCHAR(50) = 'nowy@email.pl';
DECLARE @IdStawki INT = 3;
DECLARE @IdPlec INT = 2;
EXEC AktualizujPracownika
    @IdPracownika = @IdPracownika,
    @Imie = @Imie,
    @Nazwisko = @Nazwisko,
    @Pesel = @Pesel,
    @Telefon = @Telefon,
    @TelefonKomorkowy = @TelefonKomorkowy,
    @IdStanowiska = @IdStanowiska,
    @Email = @Email,
    @IdStawki = @IdStawki,
    @IdPlec = @IdPlec;
*/
CREATE OR ALTER PROCEDURE up_AktualizujPracownika (
    @IdPracownika INT,
    @Imie VARCHAR(15),
    @Nazwisko VARCHAR(30),
    @Pesel VARCHAR(11),
    @Telefon VARCHAR(12),
    @TelefonKomorkowy VARCHAR(14),
    @IdStanowiska INT,
    @Email VARCHAR(50),
    @IdStawki INT,
    @IdPlec INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy wszystkie pola s� uzupe�nione
        IF @Imie IS NULL OR @Nazwisko IS NULL OR @Pesel IS NULL OR @Telefon IS NULL OR @TelefonKomorkowy IS NULL OR @Email IS NULL
        BEGIN
            RAISERROR('Wszystkie pola musz� by� wype�nione.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie d�ugo�ci p�l
        IF LEN(@Imie) > 15 OR LEN(@Nazwisko) > 30 OR LEN(@Pesel) <> 11 OR LEN(@Telefon) > 12 OR LEN(@TelefonKomorkowy) > 14 OR LEN(@Email) > 50
        BEGIN
            RAISERROR('D�ugo�� pola przekroczy�a dopuszczalny limit.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu PESELu
        IF NOT @Pesel LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
        BEGIN
            RAISERROR('Numer PESEL musi sk�ada� si� z 11 cyfr.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu telefonu
        IF @Telefon IS NOT NULL AND (LEN(@Telefon) <> 9 OR NOT @Telefon LIKE '[0-9]%' OR @Telefon NOT LIKE '_________')
        BEGIN
            RAISERROR('Numer telefonu musi sk�ada� si� z 9 cyfr.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu telefonu kom�rkowego
        IF @TelefonKomorkowy IS NOT NULL AND (LEN(@TelefonKomorkowy) <> 9 OR NOT @TelefonKomorkowy LIKE '[0-9]%' OR @TelefonKomorkowy NOT LIKE '_________')
        BEGIN
            RAISERROR('Numer telefonu kom�rkowego musi sk�ada� si� z 9 cyfr.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu adresu email
        IF @Email IS NOT NULL AND NOT @Email LIKE '%@%.%'
        BEGIN
            RAISERROR('Nieprawid�owy adres email.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy istnieje podane stanowisko
        IF NOT EXISTS (SELECT 1 FROM Stanowiska WHERE IdStanowiska = @IdStanowiska)
        BEGIN
            RAISERROR('Podane stanowisko nie istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy istnieje podana stawka
        IF NOT EXISTS (SELECT 1 FROM StawkiPracownikow WHERE IdStawki = @IdStawki)
        BEGIN
            RAISERROR('Podana stawka nie istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy istnieje podana p�e�
        IF NOT EXISTS (SELECT 1 FROM Plcie WHERE IdPlec = @IdPlec)
        BEGIN
            RAISERROR('Podana p�e� nie istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy pracownik o podanym PESELu ju� istnieje
        IF EXISTS (SELECT 1 FROM Pracownicy WHERE Pesel = @Pesel AND IdPracownika != @IdPracownika)
        BEGIN
            RAISERROR('Pracownik o podanym PESELu ju� istnieje.', 16, 1);
            RETURN;
        END

		-- Sprawdzenie unikalno�ci adresu e-mail
        IF EXISTS (SELECT 1 FROM Pracownicy WHERE Email = @Email AND IdPracownika != @IdPracownika)
        BEGIN
            RAISERROR('Adres e-mail jest ju� przypisany do innego pracownika.', 16, 1);
            RETURN;
        END

		IF EXISTS (SELECT 1 FROM Pracownicy WHERE IdPracownika = @IdPracownika AND IdPracownika != @IdPracownika)
		BEGIN
			RAISERROR('Pracownik o podanym identyfikatorze ju� istnieje.', 16,1);
			RETURN;
		END

        -- Aktualizacja danych pracownika
        UPDATE Pracownicy
        SET 
            Imie = @Imie,
            Nazwisko = @Nazwisko,
            Pesel = @Pesel,
            Telefon = @Telefon,
            TelefonKomorkowy = @TelefonKomorkowy,
            IdStanowiska = @IdStanowiska,
            Email = @Email,
            IdStawki = @IdStawki,
            IdPlec = @IdPlec
        WHERE IdPracownika = @IdPracownika;
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_DodajSklep
-- CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura dodaj�ca nowy sklep:
-- Parametry wej�ciowe:
--    @IdSklepu INT - identyfikator sklepu
--    @NazwaSklepu VARCHAR(50) - nazwa sklepu
--    @Adres VARCHAR(50) - adres sklepu
--    @Nip VARCHAR(10) - numer NIP sklepu
--    @Telefon VARCHAR(12) - numer telefonu sklepu (opcjonalny)
--    @TelefonKomorkowy VARCHAR(14) - numer telefonu kom�rkowego sklepu (opcjonalny)
--    @Email VARCHAR(50) - adres email sklepu (opcjonalny)
--    @KodPocztowy VARCHAR(6) - kod pocztowy sklepu
--    @Miejscowosc VARCHAR(35) - miejscowo�� sklepu
--    @IdWojewodztwa INT - identyfikator wojew�dztwa sklepu
--
-- Parametry wyj�ciowe:
-- Dodano rekord do tabeli Sklepy
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdSklepu INT = 1;
DECLARE @NazwaSklepu VARCHAR(50) = 'Sklep Spo�ywczy';
DECLARE @Adres VARCHAR(50) = 'ul. Testowa 1';
DECLARE @Nip VARCHAR(10) = '123-456-78-90';
DECLARE @KodPocztowy VARCHAR(6) = '12-345';
DECLARE @Miejscowosc VARCHAR(35) = 'Krak�w';
DECLARE @IdWojewodztwa INT = 1;
EXEC up_DodajSklep
    @IdSklepu = @IdSklepu,
    @NazwaSklepu = @NazwaSklepu,
    @Adres = @Adres,
    @Nip = @Nip,
    @KodPocztowy = @KodPocztowy,
    @Miejscowosc = @Miejscowosc,
    @IdWojewodztwa = @IdWojewodztwa;
*/
CREATE OR ALTER PROCEDURE up_DodajSklep (
    @IdSklepu INT,
    @NazwaSklepu VARCHAR(50),
    @Adres VARCHAR(50),
    @Nip VARCHAR(10),
    @Telefon VARCHAR(12) = NULL,
    @TelefonKomorkowy VARCHAR(14) = NULL,
    @Email VARCHAR(50) = NULL,
    @KodPocztowy VARCHAR(6),
    @Miejscowosc VARCHAR(35),
    @IdWojewodztwa INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy wszystkie pola s� uzupe�nione
        IF @IdSklepu IS NULL OR @NazwaSklepu IS NULL OR @Adres IS NULL OR @Nip IS NULL OR @KodPocztowy IS NULL OR @Miejscowosc IS NULL OR @IdWojewodztwa IS NULL
        BEGIN
            RAISERROR('Wszystkie pola musz� by� wype�nione.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie d�ugo�ci p�l
        IF LEN(@NazwaSklepu) > 50 OR LEN(@Adres) > 50 OR LEN(@Nip) <> 10 OR LEN(@Telefon) > 12 OR LEN(@TelefonKomorkowy) > 14 OR LEN(@Email) > 50 OR LEN(@KodPocztowy) <> 6 OR LEN(@Miejscowosc) > 35
        BEGIN
            RAISERROR('D�ugo�� pola przekroczy�a dopuszczalny limit.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu NIPu
        IF NOT @Nip LIKE '[0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9]-[0-9]'
        BEGIN
            RAISERROR('Nieprawid�owy format NIPu.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu telefonu
        IF @Telefon IS NOT NULL AND (LEN(@Telefon) <> 9 OR NOT @Telefon LIKE '[0-9]%' OR @Telefon NOT LIKE '_________')
        BEGIN
            RAISERROR('Numer telefonu musi sk�ada� si� z 9 cyfr.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu telefonu kom�rkowego
        IF @TelefonKomorkowy IS NOT NULL AND (LEN(@TelefonKomorkowy) <> 9 OR NOT @TelefonKomorkowy LIKE '[0-9]%' OR @TelefonKomorkowy NOT LIKE '_________')
        BEGIN
            RAISERROR('Numer telefonu kom�rkowego musi sk�ada� si� z 9 cyfr.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu adresu email
        IF @Email IS NOT NULL AND NOT @Email LIKE '%@%.%'
        BEGIN
            RAISERROR('Nieprawid�owy adres email.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy podany kod pocztowy jest poprawny
        IF NOT @KodPocztowy LIKE '[0-9][0-9]-[0-9][0-9][0-9]'
        BEGIN
            RAISERROR('Nieprawid�owy format kodu pocztowego.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy istnieje podane wojew�dztwo
        IF NOT EXISTS (SELECT 1 FROM Wojewodztwa WHERE IdWojewodztwa = @IdWojewodztwa)
        BEGIN
            RAISERROR('Podane wojew�dztwo nie istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy NIP jest unikalny
        IF EXISTS (SELECT 1 FROM Sklepy WHERE Nip = @Nip)
        BEGIN
            RAISERROR('Sklep o podanym NIPie ju� istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy nazwa sklepu jest unikalna
        IF EXISTS (SELECT 1 FROM Sklepy WHERE NazwaSklepu = @NazwaSklepu)
        BEGIN
            RAISERROR('Sklep o podanej nazwie ju� istnieje.', 16, 1);
            RETURN;
        END

        -- Dodanie nowego sklepu
        INSERT INTO Sklepy (IdSklepu, NazwaSklepu, Adres, Nip, Telefon, TelefonKomorkowy, Email, KodPocztowy, Miejscowosc, IdWojewodztwa)
        VALUES (@IdSklepu, @NazwaSklepu, @Adres, @Nip, @Telefon, @TelefonKomorkowy, @Email, @KodPocztowy, @Miejscowosc, @IdWojewodztwa);

        PRINT 'Nowy sklep zosta� dodany.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_UsunSklep
-- CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura usuwaj�ca sklep:
-- Parametry wej�ciowe:
--    @IdSklepu INT - identyfikator sklepu do usuni�cia
--
-- Parametry wyj�ciowe:
-- Usuni�to rekord z tabeli Sklepy
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdSklepu INT = 1;
EXEC up_UsunSklep
    @IdSklepu = @IdSklepu;
*/
CREATE OR ALTER PROCEDURE up_UsunSklep (
    @IdSklepu INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy podany sklep istnieje
        IF NOT EXISTS (SELECT 1 FROM Sklepy WHERE IdSklepu = @IdSklepu)
        BEGIN
            RAISERROR('Sklep o podanym identyfikatorze nie istnieje.', 16, 1);
            RETURN;
        END

        -- Usuni�cie sklepu
        DELETE FROM Sklepy WHERE IdSklepu = @IdSklepu;

        PRINT 'Sklep zosta� usuni�ty.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_AktualizujSklep
-- CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura aktualizuj�ca dane sklepu:
-- Parametry wej�ciowe:
--    @IdSklepu INT - identyfikator sklepu do zaktualizowania
--    @NazwaSklepu VARCHAR(50) - nowa nazwa sklepu 
--    @Adres VARCHAR(50) - nowy adres sklepu 
--    @Nip VARCHAR(10) - nowy numer NIP sklepu 
--    @Telefon VARCHAR(12) - nowy numer telefonu sklepu 
--    @TelefonKomorkowy VARCHAR(14) - nowy numer telefonu kom�rkowego sklepu 
--    @Email VARCHAR(50) - nowy adres email sklepu 
--    @KodPocztowy VARCHAR(6) - nowy kod pocztowy sklepu 
--    @Miejscowosc VARCHAR(35) - nowa miejscowo�� sklepu 
--    @IdWojewodztwa INT - nowy identyfikator wojew�dztwa sklepu
--
-- Parametry wyj�ciowe:
-- Zaktualizowano rekord w tabeli Sklepy
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdSklepu INT = 1;
DECLARE @NazwaSklepu VARCHAR(50) = 'Nowa Nazwa Sklepu';
DECLARE @Adres VARCHAR(50) = 'Nowy Adres 123';
DECLARE @Nip VARCHAR(10) = '987-654-32-10';
DECLARE @Telefon VARCHAR(12) = '123456789';
DECLARE @TelefonKomorkowy VARCHAR(14) = '987654321';
DECLARE @Email VARCHAR(50) = 'nowy@email.com';
DECLARE @KodPocztowy VARCHAR(6) = '11-111';
DECLARE @Miejscowosc VARCHAR(35) = 'Nowe Miasto';
DECLARE @IdWojewodztwa INT = 2;
EXEC up_AktualizujSklep
    @IdSklepu = @IdSklepu,
    @NazwaSklepu = @NazwaSklepu,
    @Adres = @Adres,
    @Nip = @Nip,
    @Telefon = @Telefon,
    @TelefonKomorkowy = @TelefonKomorkowy,
    @Email = @Email,
    @KodPocztowy = @KodPocztowy,
    @Miejscowosc = @Miejscowosc,
    @IdWojewodztwa = @IdWojewodztwa;
*/
CREATE OR ALTER PROCEDURE up_AktualizujSklep (
    @IdSklepu INT,
    @NazwaSklepu VARCHAR(50),
    @Adres VARCHAR(50),
    @Nip VARCHAR(10),
    @Telefon VARCHAR(12),
    @TelefonKomorkowy VARCHAR(14),
    @Email VARCHAR(50),
    @KodPocztowy VARCHAR(6),
    @Miejscowosc VARCHAR(35),
    @IdWojewodztwa INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy wszystkie pola s� uzupe�nione
        IF @NazwaSklepu IS NULL OR @Adres IS NULL OR @Nip IS NULL OR @KodPocztowy IS NULL OR @Miejscowosc IS NULL OR @IdWojewodztwa IS NULL
        BEGIN
            RAISERROR('Wszystkie pola musz� by� wype�nione.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie d�ugo�ci p�l
        IF LEN(@NazwaSklepu) > 50 OR LEN(@Adres) > 50 OR LEN(@Nip) > 10 OR LEN(@Telefon) > 12 OR LEN(@TelefonKomorkowy) > 14 OR LEN(@Email) > 50 OR LEN(@KodPocztowy) > 6 OR LEN(@Miejscowosc) > 35
        BEGIN
            RAISERROR('D�ugo�� pola przekroczy�a dopuszczalny limit.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu NIPu
        IF NOT @Nip LIKE '[0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'
        BEGIN
            RAISERROR('Nieprawid�owy numer NIP.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu telefonu
        IF @Telefon IS NOT NULL AND (LEN(@Telefon) <> 9 OR NOT @Telefon LIKE '[0-9]%' OR @Telefon NOT LIKE '_________')
        BEGIN
            RAISERROR('Numer telefonu musi sk�ada� si� z 9 cyfr.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu telefonu kom�rkowego
        IF @TelefonKomorkowy IS NOT NULL AND (LEN(@TelefonKomorkowy) <> 9 OR NOT @TelefonKomorkowy LIKE '[0-9]%' OR @TelefonKomorkowy NOT LIKE '_________')
        BEGIN
            RAISERROR('Numer telefonu kom�rkowego musi sk�ada� si� z 9 cyfr.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu adresu email
        IF @Email IS NOT NULL AND NOT @Email LIKE '%@%.%'
        BEGIN
            RAISERROR('Nieprawid�owy adres email.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy istnieje podane wojew�dztwo
        IF NOT EXISTS (SELECT 1 FROM Wojewodztwa WHERE IdWojewodztwa = @IdWojewodztwa)
        BEGIN
            RAISERROR('Podane wojew�dztwo nie istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy sklep o podanym NIPie ju� istnieje
        IF EXISTS (SELECT 1 FROM Sklepy WHERE Nip = @Nip AND IdSklepu != @IdSklepu)
        BEGIN
            RAISERROR('Sklep o podanym NIPie ju� istnieje.', 16, 1);
            RETURN;
        END

        -- Aktualizacja danych sklepu
        UPDATE Sklepy
        SET 
            NazwaSklepu = @NazwaSklepu,
            Adres = @Adres,
            Nip = @Nip,
            Telefon = @Telefon,
            TelefonKomorkowy = @TelefonKomorkowy,
            Email = @Email,
            KodPocztowy = @KodPocztowy,
            Miejscowosc = @Miejscowosc,
            IdWojewodztwa = @IdWojewodztwa
        WHERE IdSklepu = @IdSklepu;

        PRINT 'Dane sklepu zosta�y zaktualizowane.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_DodajSamochod
-- CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura dodaj�ca nowy samoch�d:
-- Parametry wej�ciowe:
--    @IdSamochodu INT - identyfikator samochodu
--    @NumerRejestracyjny VARCHAR(8) - numer rejestracyjny samochodu
--    @Vin VARCHAR(17) - numer VIN samochodu
--    @RodzajPaliwa CHAR(2) - rodzaj paliwa (np. PB - benzyna, ON - olej nap�dowy)
--    @Marka VARCHAR(30) - marka samochodu
--    @IdPracownika INT - identyfikator pracownika, kt�ry zarz�dza samochodem
--
-- Parametry wyj�ciowe:
-- Dodano rekord do tabeli Samochody
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdSamochodu INT = 1;
DECLARE @NumerRejestracyjny VARCHAR(8) = 'ABC1234';
DECLARE @Vin VARCHAR(17) = '12345678901234567';
DECLARE @RodzajPaliwa CHAR(2) = 'PB';
DECLARE @Marka VARCHAR(30) = 'Toyota';
DECLARE @IdPracownika INT = 1;
EXEC up_DodajSamochod
    @IdSamochodu = @IdSamochodu,
    @NumerRejestracyjny = @NumerRejestracyjny,
    @Vin = @Vin,
    @RodzajPaliwa = @RodzajPaliwa,
    @Marka = @Marka,
    @IdPracownika = @IdPracownika;
*/
CREATE OR ALTER PROCEDURE up_DodajSamochod (
    @IdSamochodu INT,
    @NumerRejestracyjny VARCHAR(8),
    @Vin VARCHAR(17),
    @RodzajPaliwa CHAR(2),
    @Marka VARCHAR(30),
    @IdPracownika INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy wszystkie pola s� uzupe�nione
        IF @IdSamochodu IS NULL OR @NumerRejestracyjny IS NULL OR @Vin IS NULL OR @RodzajPaliwa IS NULL OR @Marka IS NULL OR @IdPracownika IS NULL
        BEGIN
            RAISERROR('Wszystkie pola musz� by� wype�nione.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie d�ugo�ci p�l
        IF LEN(@NumerRejestracyjny) <> 8 OR LEN(@Vin) <> 17 OR LEN(@RodzajPaliwa) <> 2 OR LEN(@Marka) > 30
        BEGIN
            RAISERROR('D�ugo�� pola przekroczy�a dopuszczalny limit.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie unikalno�ci numeru rejestracyjnego
        IF EXISTS (SELECT 1 FROM Samochody WHERE NumerRejestracyjny = @NumerRejestracyjny)
        BEGIN
            RAISERROR('Samoch�d o podanym numerze rejestracyjnym ju� istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie unikalno�ci numeru VIN
        IF EXISTS (SELECT 1 FROM Samochody WHERE Vin = @Vin)
        BEGIN
            RAISERROR('Samoch�d o podanym numerze VIN ju� istnieje.', 16, 1);
            RETURN;
        END

        -- Dodanie nowego samochodu
        INSERT INTO Samochody (IdSamochodu, NumerRejestracyjny, Vin, RodzajPaliwa, Marka, IdPracownika)
        VALUES (@IdSamochodu, @NumerRejestracyjny, @Vin, @RodzajPaliwa, @Marka, @IdPracownika);

        PRINT 'Nowy samoch�d zosta� dodany.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_AktualizujSamochod
-- CREATED BY Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura aktualizuj�ca dane samochodu:
-- Parametry wej�ciowe:
--    @IdSamochodu INT - identyfikator samochodu do zaktualizowania
--    @NumerRejestracyjny VARCHAR(8) - nowy numer rejestracyjny samochodu 
--    @Vin VARCHAR(17) - nowy numer identyfikacyjny pojazdu (VIN) 
--    @RodzajPaliwa CHAR(2) - nowy rodzaj paliwa (np. PB - benzyna, ON - olej nap�dowy)
--    @Marka VARCHAR(30) - nowa marka samochodu 
--    @IdPracownika INT - nowy identyfikator pracownika przypisanego do samochodu
--
-- Parametry wyj�ciowe:
-- Zaktualizowano rekord w tabeli Samochody
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdSamochodu INT = 1;
DECLARE @NumerRejestracyjny VARCHAR(8) = 'ABC1234';
DECLARE @Vin VARCHAR(17) = '12345678901234567';
DECLARE @RodzajPaliwa CHAR(2) = 'PB';
DECLARE @Marka VARCHAR(30) = 'Toyota';
DECLARE @IdPracownika INT = 2;
EXEC up_AktualizujSamochod
    @IdSamochodu = @IdSamochodu,
    @NumerRejestracyjny = @NumerRejestracyjny,
    @Vin = @Vin,
    @RodzajPaliwa = @RodzajPaliwa,
    @Marka = @Marka,
    @IdPracownika = @IdPracownika;
*/
CREATE OR ALTER PROCEDURE up_AktualizujSamochod (
    @IdSamochodu INT,
    @NumerRejestracyjny VARCHAR(8),
    @Vin VARCHAR(17),
    @RodzajPaliwa CHAR(2),
    @Marka VARCHAR(30),
    @IdPracownika INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy wszystkie pola s� uzupe�nione
        IF @NumerRejestracyjny IS NULL OR @Vin IS NULL OR @RodzajPaliwa IS NULL OR @Marka IS NULL OR @IdPracownika IS NULL
        BEGIN
            RAISERROR('Wszystkie pola musz� by� wype�nione.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie d�ugo�ci p�l
        IF LEN(@NumerRejestracyjny) <> 8 OR LEN(@Vin) <> 17 OR LEN(@RodzajPaliwa) <> 2 OR LEN(@Marka) > 30
        BEGIN
            RAISERROR('D�ugo�� pola przekroczy�a dopuszczalny limit.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie formatu VIN
        IF NOT @Vin LIKE '[0-9A-Z]%'
        BEGIN
            RAISERROR('Nieprawid�owy numer identyfikacyjny pojazdu (VIN).', 16, 1);
            RETURN;
        END

        -- Sprawdzenie, czy podany pracownik istnieje
        IF NOT EXISTS (SELECT 1 FROM Pracownicy WHERE IdPracownika = @IdPracownika)
        BEGIN
            RAISERROR('Podany pracownik nie istnieje.', 16, 1);
            RETURN;
        END

        -- Sprawdzenie unikalno�ci VIN
        IF EXISTS (SELECT 1 FROM Samochody WHERE Vin = @Vin AND IdSamochodu != @IdSamochodu)
        BEGIN
            RAISERROR('Podany numer identyfikacyjny pojazdu (VIN) ju� istnieje.', 16, 1);
            RETURN;
        END

        -- Aktualizacja danych samochodu
        UPDATE Samochody
        SET 
            NumerRejestracyjny = @NumerRejestracyjny,
            Vin = @Vin,
            RodzajPaliwa = @RodzajPaliwa,
            Marka = @Marka,
            IdPracownika = @IdPracownika
        WHERE IdSamochodu = @IdSamochodu;

        PRINT 'Dane samochodu zosta�y zaktualizowane.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO

-- PROCEDURE DEFINITION
-- up_UsunSamochod
-- CREATED BY Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura usuwaj�ca samoch�d:
-- Parametry wej�ciowe:
--    @IdSamochodu INT - identyfikator samochodu do usuni�cia
--
-- Parametry wyj�ciowe:
-- Usuni�to rekord z tabeli Samochody
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdSamochodu INT = 1;
EXEC up_UsunSamochod @IdSamochodu = @IdSamochodu;
*/
CREATE OR ALTER PROCEDURE up_UsunSamochod (
    @IdSamochodu INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy podany samoch�d istnieje
        IF NOT EXISTS (SELECT 1 FROM Samochody WHERE IdSamochodu = @IdSamochodu)
        BEGIN
            RAISERROR('Podany samoch�d nie istnieje.', 16, 1);
            RETURN;
        END

        -- Usuni�cie samochodu
        DELETE FROM Samochody WHERE IdSamochodu = @IdSamochodu;
        PRINT 'Samoch�d zosta� usuni�ty.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_DodajZamowienie
-- CREATED BY Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura dodaj�ca nowe zam�wienie:
-- Parametry wej�ciowe:
--    @IdZamowienia INT - identyfikator zam�wienia
--    @IdSklepu INT - identyfikator sklepu, z kt�rego pochodzi zam�wienie
--    @DataZamowienia DATE - data zam�wienia
--	  @IdSamochodu INT - identyfikator samochodu, kt�ry dowozi zam�wienie do sklepu
--
-- Parametry wyj�ciowe:
-- Dodano rekord do tabeli Zamowienia
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdZamowienia INT = 1;
DECLARE @IdSklepu INT = 1;
DECLARE @DataZamowienia DATE = '2024-05-30';
@IdSamochodu INT = 2
EXEC up_DodajZamowienie
    @IdZamowienia = @IdZamowienia,
    @IdSklepu = @IdSklepu,
    @DataZamowienia = @DataZamowienia;
	@IdSamochodu = @IdSamochodu
*/
CREATE OR ALTER PROCEDURE up_DodajZamowienie (
    @IdZamowienia INT,
    @IdSklepu INT,
    @DataZamowienia DATE,
	@IdSamochodu INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy data zam�wienia nie jest przesz�a
        IF @DataZamowienia < GETDATE()
        BEGIN
            RAISERROR('Nie mo�na doda� zam�wienia z przesz�� dat�.', 16, 1);
            RETURN;
        END

        -- Dodanie nowego zam�wienia
        INSERT INTO Zamowienia (IdZamowienia, IdSklepu, DataZamowienia, IdSamochodu)
        VALUES (@IdZamowienia, @IdSklepu, @DataZamowienia, @IdSamochodu);

        PRINT 'Nowe zam�wienie zosta�o dodane.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_UsunZamowienie
-- CREATED BY Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura usuwaj�ca zam�wienie:
-- Parametry wej�ciowe:
--    @IdZamowienia INT - identyfikator zam�wienia do usuni�cia
--
-- Parametry wyj�ciowe:
-- Usuni�to rekord z tabeli Zamowienia
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdZamowienia INT = 1;
EXEC up_UsunZamowienie
    @IdZamowienia = @IdZamowienia;
*/
CREATE OR ALTER PROCEDURE up_UsunZamowienie (
    @IdZamowienia INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy data zam�wienia jest przesz�a
        IF EXISTS (SELECT 1 FROM Zamowienia WHERE IdZamowienia = @IdZamowienia AND DataZamowienia < GETDATE())
        BEGIN
            RAISERROR('Nie mo�na usun�� zam�wienia z przesz�� dat� zam�wienia.', 16, 1);
            RETURN;
        END

        -- Usuni�cie zam�wienia
        DELETE FROM Zamowienia WHERE IdZamowienia = @IdZamowienia;

        PRINT 'Zam�wienie zosta�o usuni�te.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_AktualizujZamowienie
-- CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura aktualizuj�ca dane zam�wienia:
-- Parametry wej�ciowe:
--    @IdZamowienia INT - identyfikator zam�wienia do zaktualizowania
--    @IdSklepu INT - nowy identyfikator sklepu
--    @DataZamowienia DATE - nowa data zam�wienia
--	  @IdSamochodu INT - identyfikator samochodu, kt�ry dowozi zam�wienie do sklepu
--
-- Parametry wyj�ciowe:
-- Zaktualizowano rekord w tabeli Zamowienia
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdZamowienia INT = 1;
DECLARE @IdSklepu INT = 2;
DECLARE @DataZamowienia DATE = '2024-05-31';
DECLARE @IdSamochodu INT = 2
EXEC up_AktualizujZamowienie
    @IdZamowienia = @IdZamowienia,
    @IdSklepu = @IdSklepu,
    @DataZamowienia = @DataZamowienia,
	@IdSamochodu = @IdSamochodu;
*/
CREATE OR ALTER PROCEDURE up_AktualizujZamowienie (
    @IdZamowienia INT,
    @IdSklepu INT,
    @DataZamowienia DATE,
	@IdSamochodu INT
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy data zam�wienia jest przesz�a
        IF @DataZamowienia < GETDATE()
        BEGIN
            RAISERROR('Nie mo�na zaktualizowa� zam�wienia na przesz�� dat� zam�wienia.', 16, 1);
            RETURN;
        END

        -- Aktualizacja danych zam�wienia
        UPDATE Zamowienia
        SET 
            IdSklepu = @IdSklepu,
            DataZamowienia = @DataZamowienia
			IdSamochodu = @IdSamochodu
        WHERE IdZamowienia = @IdZamowienia;

        PRINT 'Dane zam�wienia zosta�y zaktualizowane.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_DodajSzczegolZamowienia
-- CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura dodaj�ca szczeg�y zam�wienia:
-- Parametry wej�ciowe:
--    @IdZamowienia INT - identyfikator zam�wienia
--    @IdProduktu INT - identyfikator produktu
--    @Ilosc INT - ilo�� produkt�w
--
-- Parametry wyj�ciowe:
-- Dodano rekord do tabeli SzczegolyZamowien
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdZamowienia INT = 1;
DECLARE @IdProduktu INT = 2;
DECLARE @Ilosc INT = 10;
EXEC up_DodajSzczegolZamowienia
    @IdZamowienia = @IdZamowienia,
    @IdProduktu = @IdProduktu,
    @Ilosc = @Ilosc;
*/
CREATE OR ALTER PROCEDURE up_DodajSzczegolZamowienia (
    @IdZamowienia INT,
    @IdProduktu INT,
    @Ilosc VARCHAR(10)
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy ilo�� jest liczb� dodatni�
        IF ISNUMERIC(@Ilosc) = 0 OR CAST(@Ilosc AS INT) <= 0
        BEGIN
            RAISERROR('Ilo�� musi by� dodatni� liczb� ca�kowit�.', 16, 1);
            RETURN;
        END

        -- Dodanie szczeg��w zam�wienia
        INSERT INTO SzczegolyZamowien (IdZamowienia, IdProduktu, Ilosc)
        VALUES (@IdZamowienia, @IdProduktu, @Ilosc);

        PRINT 'Szczeg�y zam�wienia zosta�y dodane.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_AktualizujSzczegolZamowienia
-- CREATED BY Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura aktualizuj�ca szczeg�y zam�wienia:
-- Parametry wej�ciowe:
--    @IdSzczegoluZamowienia INT - identyfikator szczeg�u zam�wienia do zaktualizowania
--    @Ilosc INT - nowa ilo�� produkt�w
--
-- Parametry wyj�ciowe:
-- Zaktualizowano rekord w tabeli SzczegolyZamowien
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdSzczegoluZamowienia INT = 1;
DECLARE @Ilosc INT = 15;
EXEC up_AktualizujSzczegolZamowienia
    @IdSzczegoluZamowienia = @IdSzczegoluZamowienia,
    @Ilosc = @Ilosc;
*/
CREATE OR ALTER PROCEDURE up_AktualizujSzczegolZamowienia (
    @IdSzczegoluZamowienia INT,
    @Ilosc VARCHAR(10)
)
AS
BEGIN TRY
    BEGIN
        -- Sprawdzenie, czy ilo�� jest liczb� dodatni�
        IF ISNUMERIC(@Ilosc) = 0 OR CAST(@Ilosc AS INT) <= 0
        BEGIN
            RAISERROR('Ilo�� musi by� dodatni� liczb� ca�kowit�.', 16, 1);
            RETURN;
        END

        -- Aktualizacja szczeg��w zam�wienia
        UPDATE SzczegolyZamowien
        SET Ilosc = @Ilosc
        WHERE IdSzczegoluZam = @IdSzczegoluZamowienia;

        PRINT 'Szczeg�y zam�wienia zosta�y zaktualizowane.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- PROCEDURE DEFINITION
-- up_UsunSzczegolZamowienia
-- CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura usuwaj�ca szczeg� zam�wienia:
-- Parametry wej�ciowe:
--    @IdSzczegoluZamowienia INT - identyfikator szczeg�u zam�wienia do usuni�cia
--
-- Parametry wyj�ciowe:
-- Usuni�to rekord z tabeli SzczegolyZamowien
--
/*
-- Przyk�ad u�ycia:
DECLARE @IdSzczegoluZamowienia INT = 1;
EXEC up_UsunSzczegolZamowienia
    @IdSzczegoluZamowienia = @IdSzczegoluZamowienia;
*/
CREATE OR ALTER PROCEDURE up_UsunSzczegolZamowienia (
    @IdSzczegoluZamowienia INT
)
AS
BEGIN TRY
    BEGIN
        -- Usuni�cie szczeg�u zam�wienia
        DELETE FROM SzczegolyZamowien
        WHERE IdSzczegoluZam = @IdSzczegoluZamowienia;

        PRINT 'Szczeg� zam�wienia zosta� usuni�ty.';
    END
END TRY
BEGIN CATCH
    DECLARE @ErrorMessage NVARCHAR(4000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;
    DECLARE @ErrorProcedure NVARCHAR(128);

    SELECT @ErrorMessage = ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE(),
           @ErrorProcedure = ERROR_PROCEDURE();
    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
GO
-- Triggery
/*
    TRIGGER DEFINITION
    trg_SprawdzDuzeZamowienie
    CREATED BY Pawe� Wozign�j
    ----------------------------------------------------------
    Opis:
    Trigger sprawdza czy dodawana lub aktualizowana ilo�� produktu w zam�wieniu jest wi�ksza ni� 100. 
    Je�li tak, zapisuje komunikat o du�ej ilo�ci produkt�w w zam�wieniu do tabeli Informacje.

    Parametry wej�ciowe:
    Insert lub Update w tabeli SzczegolyZamowien

    Parametry wyj�ciowe:
    Zapis komunikatu o du�ej ilo�ci produkt�w w zam�wieniu do tabeli Informacje
*/
CREATE OR ALTER TRIGGER tr_SprawdzDuzeZamowienie
ON SzczegolyZamowien
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @IdZamowienia INT;
    DECLARE @Ilosc INT;

    SELECT @IdZamowienia = IdZamowienia, @Ilosc = Ilosc
    FROM inserted;

    IF @Ilosc > 100
    BEGIN
        DECLARE @Komunikat VARCHAR(500);
        SET @Komunikat = 'Uwaga: Zam�wienie ' + CAST(@IdZamowienia AS VARCHAR) + ' zawiera du�� ilo�� produktu!';

        INSERT INTO Informacje (Wiadomosc, Gdzie, Data)
        VALUES (@Komunikat, 'SzczegolyZamowien', GETDATE());
    END
END;
GO

 /*
    TRIGGER DEFINITION
    trg_WyswietlNowyZwrot
    CREATED BY Pawe� Wozign�j
    ----------------------------------------------------------
    Opis:
    Trigger dodaje komunikat do tabeli Informacje po dodaniu nowego zwrotu produktu, informuj�c o jego szczeg�ach.

    Parametry wej�ciowe:
    Insert w tabeli Zwroty

    Parametry wyj�ciowe:
    Komunikat z informacjami o nowym zwrocie produktu
    */
CREATE OR ALTER TRIGGER tr_WyswietlNowyZwrot
ON Zwroty
AFTER INSERT
AS
BEGIN
    DECLARE @IdZwrotu INT;
    DECLARE @DataZwrotu DATE;
    DECLARE @Powod VARCHAR(100);

    SELECT @IdZwrotu = IdZwrotu, @DataZwrotu = DataZwrotu, @Powod = Pow�d
    FROM inserted;

    DECLARE @Komunikat VARCHAR(500);
    SET @Komunikat = 'Dodano nowy zwrot produktu: ID zwrotu: ' + CAST(@IdZwrotu AS VARCHAR(10)) +
                     ', Data zwrotu: ' + CONVERT(VARCHAR, @DataZwrotu, 106) +
                     ', Pow�d: ' + @Powod;

    INSERT INTO Informacje (Wiadomosc, Gdzie, Data)
    VALUES (@Komunikat, 'Zwroty', GETDATE());
END;
GO

/*
    TRIGGER DEFINITION
    trg_WyswietlDateRealizacjiZamowienia
    CREATED BY Wojciech Zawieja
    ----------------------------------------------------------
    Opis:
    Trigger wy�wietla komunikat po dodaniu lub aktualizacji zam�wienia, informuj�c o dacie jego z�o�enia.

    Parametry wej�ciowe:
    Insert lub Update w tabeli Zamowienia

    Parametry wyj�ciowe:
    Komunikat: Insert do tabeli Informacje
    */
CREATE OR ALTER TRIGGER tr_WyswietlDateRealizacjiZamowienia
ON Zamowienia
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @OrderId INT;
    DECLARE @OrderDate DATE;

    SELECT TOP 1 @OrderId = IdZamowienia, @OrderDate = DataZamowienia
    FROM inserted;

    DECLARE @Komunikat VARCHAR(500);
    SET @Komunikat = 'Nowe zam�wienie o numerze ' + CAST(@OrderId AS VARCHAR(10));

    INSERT INTO Informacje (Wiadomosc, Gdzie, Data)
    VALUES (@Komunikat, 'Zamowienia', GETDATE());
END;
GO

/*
    TRIGGER DEFINITION
    trg_WyswietlKwoteDostawy
    CREATED BY Wojciech Zawieja
    ----------------------------------------------------------
    Opis:
    Trigger zapisuje komunikat do tabeli Informacje po dodaniu lub aktualizacji dostawy o kwocie powy�ej 1000 z�otych.
    Dodatkowo zapisuje informacj� o dacie z�o�enia dostawy.

    Parametry wej�ciowe:
    Insert lub Update w tabeli Dostawy

    Parametry wyj�ciowe:
    Komunikat zapisany w tabeli Informacje:
    - 'Dostawa o numerze [IdDostawy] wynosi [KwotaDostawy] z�. Uwaga: To du�a kwota do zap�aty za dostaw�.'
    - 'Dostawa o numerze [IdDostawy] zosta�a z�o�ona dnia [DataDostawy]'
*/
CREATE OR ALTER TRIGGER tr_WyswietlKwoteDostawy
ON Dostawy
AFTER INSERT, UPDATE
AS
BEGIN
    -- Wstawienie komunikatu o du�ej kwocie dostawy
    INSERT INTO Informacje (Wiadomosc, Gdzie, Data)
    SELECT 
        'Dostawa o numerze ' + CAST(IdDostawy AS VARCHAR(10)) + ' wynosi ' + CAST(KwotaDostawy AS VARCHAR(10)) + ' z�. Uwaga: To du�a kwota do zap�aty za dostaw�.',
        'Dostawy',
        GETDATE()
    FROM inserted
    WHERE KwotaDostawy > 1000;

    -- Wstawienie informacji o dacie dostawy
    INSERT INTO Informacje (Wiadomosc, Gdzie, Data)
    SELECT 
        'Dostawa o numerze ' + CAST(IdDostawy AS VARCHAR(10)) + ' zosta�a z�o�ona dnia ' + CONVERT(VARCHAR, DataDostawy, 106),
        'Dostawy',
        GETDATE()
    FROM inserted;
END;
GO

/*
    TRIGGER DEFINITION
    trg_WysokaCenaProduktu
    CREATED BY Wojciech Zawieja
    ----------------------------------------------------------
    Opis:
    Trigger zapisuje komunikat do tabeli Informacje po dodaniu lub aktualizacji produktu o wysokiej cenie.

    Parametry wej�ciowe:
    Insert lub Update w tabeli Produkty

    Parametry wyj�ciowe:
    Insert do tabeli Informacje:
    'Produkt [NazwaProduktu] (ID: [IdProduktu]) ma wysok� cen�: [CenaProduktu] z�.'

    */
CREATE OR ALTER TRIGGER tr_WysokaCenaProduktu
ON Produkty
AFTER INSERT, UPDATE
AS
BEGIN
    -- Wstawienie komunikatu o wysokiej cenie produktu
    INSERT INTO Informacje (Wiadomosc, Gdzie, Data)
    SELECT 
        'Produkt ' + NazwaProduktu + ' (ID: ' + CAST(IdProduktu AS VARCHAR(10)) + ') ma wysok� cen�: ' + CAST(CenaProduktu AS VARCHAR(10)) + ' z�.',
        'Produkty',
        GETDATE()
    FROM inserted
    WHERE CenaProduktu > 50;
END;
GO


--Funkcje i procedury do przegl�dania danych
--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_PrzegladajZamowieniaSklepu
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura wy�wietlaj�ca informacje o wszystkich zam�wieniach z danego sklepu
-- Parametry wej�ciowe:
-- @IdSklepu - identyfikator sklepu
--
-- Parametry wyj�ciowe: Lista rekord�w z zam�wieniami dla danego sklepu
--
-- Przyk�ad u�ycia:
-- DECLARE @IdSklepu INT = 1
-- EXEC up_PrzegladajZamowieniaSklepu @IdSklepu
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_PrzegladajZamowieniaSklepu
    @IdSklepu INT
AS
BEGIN

    DECLARE @Zamowienia TABLE (
        IdZamowienia INT,
        IdSklepu INT,
        DataZamowienia DATE,
        IdSamochodu INT
    );

    INSERT INTO @Zamowienia
    SELECT IdZamowienia, IdSklepu, DataZamowienia, IdSamochodu
    FROM Zamowienia 
    WHERE IdSklepu = @IdSklepu;

    SELECT * FROM @Zamowienia;
END;
GO

--------------------------------------------------------------------------------------
-- FUNCTION DEFINITION
-- uf_SredniaCenaProduktowWKategorii
-- CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Funkcja zwracaj�ca �redni� cen� produkt�w w danej kategorii
-- Parametry wej�ciowe:
-- @IdKategorii - identyfikator kategorii produkt�w
--
-- Parametry wyj�ciowe: �rednia cena produkt�w w danej kategorii
--
-- Przyk�ad u�ycia:
-- DECLARE @IdKategorii INT = 1
-- SELECT dbo.uf_SredniaCenaProduktowWKategorii(@IdKategorii) AS SredniaCena
--
--------------------------------------------------------------------------------------
CREATE FUNCTION uf_SredniaCenaProduktowWKategorii
(
    @IdKategorii INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @SredniaCena DECIMAL(10,2);

    SELECT @SredniaCena = AVG(CenaProduktu)
    FROM Produkty
    WHERE IdKategorii = @IdKategorii;

    IF @SredniaCena IS NULL
    BEGIN
        SET @SredniaCena = 0.00;
    END

    RETURN @SredniaCena;
END;
GO

--------------------------------------------------------------------------------------
-- PROCEDURE DEFINITION
-- up_PrzegladajSzczegolyDostawDlaDostawcy
-- CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura wy�wietlaj�ca wszystkie szczeg�y dostaw dla danego dostawcy
-- Parametry wej�ciowe:
-- @IdDostawcy - identyfikator dostawcy
--
-- Parametry wyj�ciowe: Lista szczeg��w dostaw dla danego dostawcy
--
-- Przyk�ad u�ycia:
-- DECLARE @IdDostawcy INT = 1
-- EXEC up_PrzegladajSzczegolyDostawDlaDostawcy @IdDostawcy
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_PrzegladajSzczegolyDostawDlaDostawcy
    @IdDostawcy INT
AS
BEGIN
    -- Deklaracja tabeli wynikowej
    DECLARE @SzczegolyDostaw TABLE (
        IdSzczegoluDostawy INT,
        IdDostawy INT,
        Produkt VARCHAR(100),
        Ilosc INT,
		DataDostawy DATE,
        KwotaDostawy DECIMAL(10, 2)
    );

    INSERT INTO @SzczegolyDostaw
    SELECT 
        sd.IdSzczegoluDostawy,
        sd.IdDostawy,
        sd.Ilosc,
		d.DataDostawy,
		d.KwotaDostawy
    FROM 
        SzczegolyDostaw sd
    INNER JOIN 
        Dostawy d ON sd.IdDostawy = d.IdDostawy
    WHERE 
        d.IdDostawcy = @IdDostawcy;

    SELECT * FROM @SzczegolyDostaw;
END;
GO

--------------------------------------------------------------------------------------
-- PROCEDURE DEFINITION
-- up_PrzegladajPracownikowNaStanowisku
-- CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura wy�wietlaj�ca pracownik�w z okre�lonego stanowiska
-- Parametry wej�ciowe:
-- @Stanowisko - nazwa stanowiska
--
-- Parametry wyj�ciowe: Lista pracownik�w na okre�lonym stanowisku
--
-- Przyk�ad u�ycia:
-- DECLARE @Stanowisko VARCHAR(50) = 'Kierowca'
-- EXEC up_PrzegladajPracownikowNaStanowisku @Stanowisko
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_PrzegladajPracownikowNaStanowisku
    @Stanowisko VARCHAR(50)
AS
BEGIN
    -- Deklaracja tabeli wynikowej
    DECLARE @PracownicyNaStanowisku TABLE (
        IdPracownika INT,
        Imie VARCHAR(50),
        Nazwisko VARCHAR(50),
        IdStanowiska INT
    );

    INSERT INTO @PracownicyNaStanowisku
    SELECT 
        p.IdPracownika,
        p.Imie,
        p.Nazwisko,
        p.IdStanowiska
    FROM 
        Pracownicy p
    INNER JOIN 
        Stanowiska s ON p.IdStanowiska = s.IdStanowiska
    WHERE 
        s.Stanowisko = @Stanowisko;

    -- Zwr�cenie wynik�w
    SELECT * FROM @PracownicyNaStanowisku;
END;
GO

--------------------------------------------------------------------------------------
-- FUNCTION DEFINITION
-- uf_LiczbaProduktowWMagazynieDlaSkladnika
-- CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Funkcja zwracaj�ca liczb� produkt�w w magazynie dla danego sk�adnika
-- Parametry wej�ciowe:
-- @IdSkladnika - identyfikator sk�adnika
--
-- Parametry wyj�ciowe: Liczba produkt�w w magazynie dla danego sk�adnika
--
-- Przyk�ad u�ycia:
-- DECLARE @IdSkladnika INT = 1
-- SELECT dbo.uf_LiczbaProduktowWMagazynieDlaSkladnika(@IdSkladnika) AS LiczbaProduktow
--
--------------------------------------------------------------------------------------
CREATE FUNCTION uf_LiczbaProduktowWMagazynieDlaSkladnika
(
    @IdSkladnika INT
)
RETURNS INT
AS
BEGIN
    DECLARE @LiczbaProduktow INT = 0;

    SELECT @LiczbaProduktow = SUM(Ilosc)
    FROM SzczegolyDostaw
    WHERE IdSkladnika = @IdSkladnika;

    IF @LiczbaProduktow IS NULL
    BEGIN
        SET @LiczbaProduktow = 0;
    END

    RETURN @LiczbaProduktow;
END;
GO

--------------------------------------------------------------------------------------
-- PROCEDURE DEFINITION
-- up_PrzegladajInformacjePracownika
-- CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura przegl�daj�ca informacje o pracowniku na podstawie numeru PESEL
-- Parametry wej�ciowe:
-- @Pesel - numer PESEL pracownika
--
-- Parametry wyj�ciowe: Informacje o pracowniku o podanym numerze PESEL
--
-- Przyk�ad u�ycia:
-- DECLARE @Pesel VARCHAR(11) = '12345678901'
-- EXEC up_PrzegladajInformacjePracownika @Pesel
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_PrzegladajInformacjePracownika
    @Pesel VARCHAR(11)
AS
BEGIN
    -- Deklaracja zmiennej tabeli
    DECLARE @InformacjePracownika TABLE (
        IdPracownika INT,
        Imie VARCHAR(15),
        Nazwisko VARCHAR(30),
        Pesel VARCHAR(11),
        Telefon VARCHAR(12),
        TelefonKomorkowy VARCHAR(14),
        IdStanowiska INT,
        Email VARCHAR(50),
        IdStawki INT,
        IdPlec INT
    );

    INSERT INTO @InformacjePracownika
    SELECT * FROM Pracownicy WHERE Pesel = @Pesel;

    IF EXISTS (SELECT 1 FROM @InformacjePracownika)
    BEGIN
        SELECT * FROM @InformacjePracownika;
    END
    ELSE
    BEGIN
        PRINT 'Pracownik o podanym numerze PESEL nie istnieje.';
    END
END;
GO

--------------------------------------------------------------------------------------
-- PROCEDURE DEFINITION
-- up_PrzegladajNajwiecejPracujacego
-- CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura wy�wietlaj�ca pracownika, kt�ry przepracowa� najwi�cej godzin w okre�lonym przedziale czasowym
-- Parametry wej�ciowe:
-- @DataPoczatkowa - data pocz�tkowa przedzia�u czasowego
-- @DataKoncowa - data ko�cowa przedzia�u czasowego
--
-- Parametry wyj�ciowe: Informacje o pracowniku, kt�ry przepracowa� najwi�cej godzin w okre�lonym przedziale czasowym
--
-- Przyk�ad u�ycia:
-- DECLARE @DataPoczatkowa DATE = '2024-01-01'
-- DECLARE @DataKoncowa DATE = '2024-01-31'
-- EXEC up_PrzegladajNajwiecejPracujacego @DataPoczatkowa, @DataKoncowa
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_PrzegladajNajwiecejPracujacego
    @DataPoczatkowa DATE,
    @DataKoncowa DATE
AS
BEGIN
    -- Deklaracja zmiennej tabeli
    DECLARE @NajwiecejPracujacy TABLE (
        Pracownik VARCHAR(50),
        SumaGodzinPracy DECIMAL(10,2)
    );

    INSERT INTO @NajwiecejPracujacy
    SELECT TOP 1 p.Imie + ' ' + p.Nazwisko AS Pracownik,
                 SUM(pd.LiczbaGodzin) AS SumaGodzinPracy
    FROM Pracownicy p
    JOIN PrzebiegDniaPracy pd ON p.IdPracownika = pd.IdPracownika
    WHERE pd.Data BETWEEN @DataPoczatkowa AND @DataKoncowa
    GROUP BY p.Imie, p.Nazwisko
    ORDER BY SumaGodzinPracy DESC;

    IF EXISTS (SELECT 1 FROM @NajwiecejPracujacy)
    BEGIN
        SELECT * FROM @NajwiecejPracujacy;
    END
    ELSE
    BEGIN
        PRINT 'Brak danych dla okre�lonego przedzia�u czasowego.';
    END
END;
GO

--------------------------------------------------------------------------------------
-- PROCEDURE DEFINITION
-- up_PrzegladajNajmniejPracujacego
-- CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura wy�wietlaj�ca pracownika, kt�ry przepracowa� najmniej godzin w okre�lonym przedziale czasowym
-- Parametry wej�ciowe:
-- @DataPoczatkowa - data pocz�tkowa przedzia�u czasowego
-- @DataKoncowa - data ko�cowa przedzia�u czasowego
--
-- Parametry wyj�ciowe: Informacje o pracowniku, kt�ry przepracowa� najmniej godzin w okre�lonym przedziale czasowym
--
-- Przyk�ad u�ycia:
-- DECLARE @DataPoczatkowa DATE = '2024-01-01'
-- DECLARE @DataKoncowa DATE = '2024-01-31'
-- EXEC up_PrzegladajNajmniejPracujacego @DataPoczatkowa, @DataKoncowa
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_PrzegladajNajmniejPracujacego
    @DataPoczatkowa DATE,
    @DataKoncowa DATE
AS
BEGIN
    -- Deklaracja zmiennej tabeli
    DECLARE @NajmniejPracujacy TABLE (
        Pracownik VARCHAR(50),
        SumaGodzinPracy DECIMAL(10,2)
    );

    INSERT INTO @NajmniejPracujacy
    SELECT TOP 1 p.Imie + ' ' + p.Nazwisko AS Pracownik,
                 SUM(pd.LiczbaGodzin) AS SumaGodzinPracy
    FROM Pracownicy p
    JOIN PrzebiegDniaPracy pd ON p.IdPracownika = pd.IdPracownika
    WHERE pd.Data BETWEEN @DataPoczatkowa AND @DataKoncowa
    GROUP BY p.Imie, p.Nazwisko
    ORDER BY SumaGodzinPracy ASC;

    IF EXISTS (SELECT 1 FROM @NajmniejPracujacy)
    BEGIN
        SELECT * FROM @NajmniejPracujacy;
    END
    ELSE
    BEGIN
        PRINT 'Brak danych dla okre�lonego przedzia�u czasowego.';
    END
END;
GO

--Procedury do masowej aktualizacji danych
--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_ZwiekszCenyProduktowWKategorii
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura masowej aktualizacji cen produkt�w w danej kategorii o okre�lony procent
-- Parametry wej�ciowe:
-- @IdKategorii - identyfikator kategorii produkt�w, w kt�rej maj� by� zaktualizowane ceny
-- @ProcentWzrostu - procentowy wzrost ceny produkt�w (np. 10 oznacza wzrost o 10%)
--
-- Parametry wyj�ciowe: Brak
--
-- Przyk�ad u�ycia:
-- DECLARE @IdKategorii INT = 1
-- DECLARE @ProcentWzrostu DECIMAL(5,2) = 10.00
-- EXEC up_AktualizujCenyProduktowWKategorii @IdKategorii, @ProcentWzrostu
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_ZwiekszCenyProduktowWKategorii
    @IdKategorii INT,
    @ProcentWzrostu DECIMAL(5,2)
AS
BEGIN
    -- Aktualizuje ceny produkt�w w danej kategorii o okre�lony procent
    DECLARE @Wzrost DECIMAL(5,2)
    SET @Wzrost = 1 + @ProcentWzrostu / 100.0
    UPDATE Produkty SET CenaProduktu = CenaProduktu * @Wzrost WHERE IdKategorii = @IdKategorii;
END;
GO
--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_ZmniejszCenyProduktowWKategorii
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura masowej aktualizacji cen produkt�w w danej kategorii o okre�lony procent
-- Parametry wej�ciowe:
-- @IdKategorii - identyfikator kategorii produkt�w, w kt�rej maj� by� zaktualizowane ceny
-- @ProcentZmniejszenia - procentowy spadek ceny produkt�w (np. 10 oznacza spadek o 10%)
--
-- Parametry wyj�ciowe: Brak
--
-- Przyk�ad u�ycia:
-- DECLARE @IdKategorii INT = 1
-- DECLARE @ProcentZmniejszenia DECIMAL(5,2) = 10.00
-- EXEC up_ZmniejszCenyProduktowWKategorii @IdKategorii, @ProcentZmniejszenia
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_ZmniejszCenyProduktowWKategorii
    @IdKategorii INT,
    @ProcentZmniejszenia DECIMAL(5,2)
AS
BEGIN
    -- Aktualizuje ceny produkt�w w danej kategorii o okre�lony procent
    DECLARE @Spadek DECIMAL(5,2)
    SET @Spadek = 1 - @ProcentZmniejszenia / 100.0
    UPDATE Produkty SET CenaProduktu = CenaProduktu * @Spadek WHERE IdKategorii = @IdKategorii;
END;
GO
--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_DodajStawkeDoStanowiska
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura dodaj�ca okre�lon� kwot� do stawki dla pracownik�w na wybranym stanowisku
-- Parametry wej�ciowe:
-- @IdStanowiska - identyfikator stanowiska, dla kt�rego ma zosta� dodana kwota do stawki
-- @KwotaDodatkowa - dodatkowa kwota, kt�ra ma zosta� dodana do stawki pracownik�w na tym stanowisku
--
-- Parametry wyj�ciowe: Brak
--
-- Przyk�ad u�ycia:
-- DECLARE @IdStanowiska INT = 1
-- DECLARE @KwotaDodatkowa DECIMAL(10,2) = 5.00
-- EXEC up_DodajStawkeDoStanowiska @IdStanowiska, @KwotaDodatkowa
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_DodajStawkeDoStanowiska
    @IdStanowiska INT,
    @KwotaDodatkowa DECIMAL(10,2)
AS
BEGIN
    -- Dodaje okre�lon� kwot� do stawki pracownik�w na wybranym stanowisku
    UPDATE StawkiPracownikow
    SET KwotaStawki = KwotaStawki + @KwotaDodatkowa
    WHERE IdStawki IN (SELECT IdStawki FROM Pracownicy WHERE IdStanowiska = @IdStanowiska);
END;
GO
--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_AktualizujZamowienia
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura aktualizuj�ca dane o zam�wieniach w okre�lonym zakresie czasu
-- Parametry wej�ciowe:
-- @DataPoczatkowa - data pocz�tkowa zakresu czasu (data zam�wienia)
-- @DataKoncowa - data ko�cowa zakresu czasu (data zam�wienia)
-- @NowaDataZamowienia - nowa data zam�wienia
-- @IloscOp�nienia - liczba dni op�nienia
--
-- Parametry wyj�ciowe: Brak
--
-- Przyk�ad u�ycia:
-- DECLARE @DataPoczatkowa DATE = '2024-01-01'
-- DECLARE @DataKoncowa DATE = '2024-06-30'
-- DECLARE @NowaDataZamowienia DATE = '2024-07-10'
-- DECLARE @IloscOp�nienia INT = 5
-- EXEC up_AktualizujZamowienia @DataPoczatkowa, @DataKoncowa, @NowaDataZamowienia, @NowyStatus, @IloscOp�nienia
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_AktualizujZamowienia
    @DataPoczatkowa DATE,
    @DataKoncowa DATE,
    @NowaDataZamowienia DATE,
    @NowyStatus VARCHAR(50),
    @IloscOp�nienia INT
AS
BEGIN
    -- Aktualizuje dane zam�wie� w okre�lonym zakresie czasu
    UPDATE Zamowienia
    SET DataZamowienia = DATEADD(day, @IloscOp�nienia, @NowaDataZamowienia)  -- Nowa data zam�wienia z uwzgl�dnieniem op�nienia
    WHERE DataZamowienia BETWEEN @DataPoczatkowa AND @DataKoncowa;
END;
GO
--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_AktualizujPrzebiegDniaPracy
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura aktualizuj�ca przebieg pracy dla wszystkich pracownik�w (np. Dodaj�ca liczbe godzin: 0 - dzie� wolny)
-- Parametry wej�ciowe:
-- @Data - data, dla kt�rej wprowadzane s� zmiany w przebiegu pracy
-- @LiczbaGodzin - liczba godzin przepracowanych w danym dniu
--
-- Parametry wyj�ciowe: Brak
--
-- Przyk�ad u�ycia:
-- DECLARE @Data DATE = '2024-07-01'
-- DECLARE @LiczbaGodzin INT = 0
-- EXEC up_AktualizujPrzebiegDniaPracy @Data, @LiczbaGodzin
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_AktualizujPrzebiegDniaPracy
    @Data DATE,
    @LiczbaGodzin INT
AS
BEGIN
    UPDATE PrzebiegDniaPracy
    SET LiczbaGodzin = @LiczbaGodzin
    WHERE Data = @Data;
END;
GO

--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_AktualizujDaneKontaktoweDostawcy
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura aktualizuj�ca dane kontaktowe dostawcy oraz powi�zane dane w zam�wieniach
-- Parametry wej�ciowe:
-- @IdDostawcy - identyfikator dostawcy, kt�rego dane maj� by� zaktualizowane
-- @NowyTelefon - nowy numer telefonu dostawcy
-- @NowyEmail - nowy adres e-mail dostawcy
--
-- Parametry wyj�ciowe: Brak
--
-- Przyk�ad u�ycia:
-- DECLARE @IdDostawcy INT = 1
-- DECLARE @NowyTelefon VARCHAR(12) = '123456789'
-- DECLARE @NowyEmail VARCHAR(50) = 'nowyemail@example.com'
-- EXEC up_AktualizujDaneKontaktoweDostawcy @IdDostawcy, @NowyTelefon, @NowyEmail
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_AktualizujDaneKontaktoweDostawcy
    @IdDostawcy INT,
    @NowyTelefon VARCHAR(12),
    @NowyEmail VARCHAR(50)
AS
BEGIN
    -- Aktualizuje dane kontaktowe dostawcy
    UPDATE Dostawcy
    SET Telefon = @NowyTelefon,
        Email = @NowyEmail
    WHERE IdDostawcy = @IdDostawcy;

    -- Aktualizuje dane kontaktowe zwi�zane z zam�wieniami
    UPDATE Zamowienia
    SET TelefonDostawcy = @NowyTelefon,
        EmailDostawcy = @NowyEmail
    WHERE IdDostawcy = @IdDostawcy;
END;
GO;

--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_ZwiekszStawkiNaStanowisku
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura zwi�kszaj�ca stawki pracownik�w na danym stanowisku o okre�lony procent
-- Parametry wej�ciowe:
-- @IdStanowiska - identyfikator stanowiska, dla kt�rego maj� by� zwi�kszone stawki
-- @ProcentWzrostu - procentowy wzrost stawki (np. 10 oznacza wzrost o 10%)
--
-- Parametry wyj�ciowe: Brak
--
-- Przyk�ad u�ycia:
-- DECLARE @IdStanowiska INT = 1
-- DECLARE @ProcentWzrostu DECIMAL(5,2) = 10.00
-- EXEC up_ZwiekszStawkiNaStanowisku @IdStanowiska, @ProcentWzrostu
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_ZwiekszStawkiNaStanowisku
    @IdStanowiska INT,
    @ProcentWzrostu DECIMAL(5,2)
AS
BEGIN
    -- Zwi�ksza stawki pracownik�w na danym stanowisku o okre�lony procent
    DECLARE @Wzrost DECIMAL(5,2);
    SET @Wzrost = 1 + @ProcentWzrostu / 100.0;
    UPDATE StawkiPracownikow
    SET KwotaStawki = KwotaStawki * @Wzrost
    WHERE IdStawki IN (SELECT IdStawki FROM Pracownicy WHERE IdStanowiska = @IdStanowiska);
END;
GO;

--Procedury i funkcje do generowania raport�w
--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_RaportZamowienWszystkichSklepow
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura generuj�ca raport zam�wie� dla wszystkich sklep�w w okre�lonym przedziale czasu
-- Parametry wej�ciowe:
-- @DataPoczatkowa - data pocz�tkowa przedzia�u czasu
-- @DataKoncowa - data ko�cowa przedzia�u czasu
--
-- Parametry wyj�ciowe: Brak
--
-- Przyk�ad u�ycia:
-- EXEC up_RaportZamowienWszystkichSklepow '2024-01-01', '2024-12-31'
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_RaportZamowienWszystkichSklepow
    @DataPoczatkowa DATE,
    @DataKoncowa DATE
AS
BEGIN
	SET NOCOUNT ON;

    DECLARE @IdSklepu INT;
    DECLARE @NazwaSklepu VARCHAR(50);
    DECLARE @AdresSklepu VARCHAR(50);
    DECLARE @NipSklepu VARCHAR(10);
    DECLARE @TelefonSklepu VARCHAR(12);
    DECLARE @EmailSklepu VARCHAR(50);
    DECLARE @KodPocztowySklepu VARCHAR(6);
    DECLARE @MiejscowoscSklepu VARCHAR(35);

    DECLARE sklepy_cursor CURSOR FOR
    SELECT IdSklepu, NazwaSklepu, Adres, Nip, Telefon, Email, KodPocztowy, Miejscowosc
    FROM Sklepy;

    OPEN sklepy_cursor;

    FETCH NEXT FROM sklepy_cursor INTO @IdSklepu, @NazwaSklepu, @AdresSklepu, @NipSklepu, @TelefonSklepu, @EmailSklepu, @KodPocztowySklepu, @MiejscowoscSklepu;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Nazwa sklepu: ' + @NazwaSklepu;
        PRINT 'Adres: ' + @AdresSklepu;
        PRINT 'NIP: ' + @NipSklepu;
        PRINT 'Telefon: ' + @TelefonSklepu;
        PRINT 'Email: ' + @EmailSklepu;
        PRINT 'Kod pocztowy: ' + @KodPocztowySklepu;
        PRINT 'Miejscowosc: ' + @MiejscowoscSklepu;
        PRINT '--------------------------------------------------';

        SELECT IdZamowienia, DataZamowienia
        FROM Zamowienia
        WHERE IdSklepu = @IdSklepu
        AND DataZamowienia BETWEEN @DataPoczatkowa AND @DataKoncowa;

        PRINT ''; 

        FETCH NEXT FROM sklepy_cursor INTO @IdSklepu, @NazwaSklepu, @AdresSklepu, @NipSklepu, @TelefonSklepu, @EmailSklepu, @KodPocztowySklepu, @MiejscowoscSklepu;
    END

    CLOSE sklepy_cursor;
    DEALLOCATE sklepy_cursor;
END;
GO


--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_RaportNajczesciejZamawianychProduktow
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura generuj�ca raport najcz�ciej zamawianych produkt�w
-- Parametry wej�ciowe: Brak
-- Parametry wyj�ciowe: Brak
--
-- Przyk�ad u�ycia: EXEC up_RaportNajczesciejZamawianychProduktow
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_RaportNajczesciejZamawianychProduktow
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NazwaProduktu NVARCHAR(50);
    DECLARE @LiczbaZamowien INT;
    
    DECLARE raport_cursor CURSOR FOR
    SELECT TOP 10 
        Produkty.NazwaProduktu,
        COUNT(SzczegolyZamowien.IdProduktu) AS LiczbaZamowien
    FROM SzczegolyZamowien
    JOIN Produkty ON SzczegolyZamowien.IdProduktu = Produkty.IdProduktu
    GROUP BY SzczegolyZamowien.IdProduktu, Produkty.NazwaProduktu
    ORDER BY LiczbaZamowien DESC;

    OPEN raport_cursor;

    FETCH NEXT FROM raport_cursor INTO @NazwaProduktu, @LiczbaZamowien;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Produkt: ' + @NazwaProduktu + ', Liczba zam�wie�: ' + CAST(@LiczbaZamowien AS NVARCHAR(10));
        FETCH NEXT FROM raport_cursor INTO @NazwaProduktu, @LiczbaZamowien;
    END

    CLOSE raport_cursor;
    DEALLOCATE raport_cursor;
END;
GO

--------------------------------------------------------------------------------------
--PROCEDURE DEFINITION
--up_GenerujRaportPrzebieguDniaPracy
--CREATED BY Pawe� Wozign�j, Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Procedura generuj�ca raport przebiegu dnia pracy dla pracownik�w w okre�lonym przedziale czasu
-- Parametry wej�ciowe:
-- @DataPoczatkowa - data pocz�tkowa przedzia�u czasu
-- @DataKoncowa - data ko�cowa przedzia�u czasu
--
-- Przyk�ad u�ycia:
-- EXEC up_GenerujRaportPrzebieguDniaPracy '2024-01-01', '2024-12-24';
--
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_GenerujRaportPrzebieguDniaPracy
(
    @DataPoczatkowa DATE,
    @DataKoncowa DATE
)
AS
BEGIN
    DECLARE @Imie VARCHAR(50)
    DECLARE @Nazwisko VARCHAR(50)
    DECLARE @Pesel VARCHAR(11)
    DECLARE @Data DATE
    DECLARE @LiczbaGodzin INT

    DECLARE raport_cursor CURSOR FOR
    SELECT 
        P.Imie, 
        P.Nazwisko, 
        P.Pesel, 
        PD.Data,
        PD.LiczbaGodzin
    FROM 
        Pracownicy P
    JOIN 
        PrzebiegDniaPracy PD ON P.IdPracownika = PD.IdPracownika
    WHERE 
        PD.Data BETWEEN @DataPoczatkowa AND @DataKoncowa

    OPEN raport_cursor
    FETCH NEXT FROM raport_cursor INTO @Imie, @Nazwisko, @Pesel, @Data, @LiczbaGodzin

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Pracownik: ' + @Imie + ' ' + @Nazwisko + ' (PESEL: ' + @Pesel + ')'
        PRINT '---------------------------------------------'
        PRINT 'Data        | Liczba godzin'
        PRINT '---------------------------------------------'
        PRINT CONVERT(VARCHAR(10), @Data, 120) + ' | ' + CAST(@LiczbaGodzin AS VARCHAR(5))
        PRINT ''

        FETCH NEXT FROM raport_cursor INTO @Imie, @Nazwisko, @Pesel, @Data, @LiczbaGodzin
    END

    CLOSE raport_cursor
    DEALLOCATE raport_cursor
END

--------------------------------------------------------------------------------------
-- PROCEDURE DEFINITION
-- up_RaportSumaKosztowZamowien
-- CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura generuje raport sumy koszt�w zam�wie� dla ka�dego sklepu
--
-- Parametry wej�ciowe: Brak
-- Parametry wyj�ciowe: Lista sklep�w z sum� koszt�w zam�wie�
--
-- Przyk�ad u�ycia:
-- EXEC up_RaportSumaKosztowZamowien;
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_RaportSumaKosztowZamowien
AS
BEGIN
    DECLARE @IdSklepu INT
    DECLARE @NazwaSklepu VARCHAR(50)
    DECLARE @IdProduktu INT
    DECLARE @NazwaProduktu VARCHAR(50)
    DECLARE @Ilosc INT
    DECLARE @Koszt DECIMAL(10, 2)
    DECLARE @PrevIdSklepu INT = -1 -- Inicjalizacja zmiennej @PrevIdSklepu
    
    DECLARE raport_cursor CURSOR FOR
    SELECT 
        Sklepy.IdSklepu,
        Sklepy.NazwaSklepu,
        SzczegolyZamowien.IdProduktu,
        Produkty.NazwaProduktu,
        SzczegolyZamowien.Ilosc,
        SzczegolyZamowien.Ilosc * Produkty.CenaProduktu AS Koszt
    FROM 
        SzczegolyZamowien
    JOIN 
        Produkty ON SzczegolyZamowien.IdProduktu = Produkty.IdProduktu
    JOIN 
        Zamowienia ON SzczegolyZamowien.IdZamowienia = Zamowienia.IdZamowienia
    JOIN 
        Sklepy ON Zamowienia.IdSklepu = Sklepy.IdSklepu
    ORDER BY 
        Sklepy.IdSklepu;
    
    OPEN raport_cursor
    FETCH NEXT FROM raport_cursor INTO @IdSklepu, @NazwaSklepu, @IdProduktu, @NazwaProduktu, @Ilosc, @Koszt
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF (@@ROWCOUNT = 1) OR (@IdSklepu <> @PrevIdSklepu)
        BEGIN
			PRINT '---------------------------------------------'
			PRINT ' '
            PRINT 'Sklep: ' + @NazwaSklepu
			PRINT ' '
            PRINT 'Produkty:'
			PRINT ' '
			PRINT '---------------------------------------------'
        END
        
        PRINT '  - ' + @NazwaProduktu + ' (Ilo��: ' + CAST(@Ilosc AS VARCHAR(10)) + ', Koszt: ' + CAST(@Koszt AS VARCHAR(20)) + ')'
        
        SET @PrevIdSklepu = @IdSklepu
        
        FETCH NEXT FROM raport_cursor INTO @IdSklepu, @NazwaSklepu, @IdProduktu, @NazwaProduktu, @Ilosc, @Koszt
    END
    
    CLOSE raport_cursor
    DEALLOCATE raport_cursor
END;
GO

DROP PROCEDURE up_RaportSumaKosztowZamowien

--------------------------------------------------------------------------------------
-- FUNCTION DEFINITION
-- uf_LiczbaPracownikowNaStanowisku
-- CREATED BY Wojciech Zawieja
--------------------------------------------------------------------------------------
-- Funkcja zwraca tabel� zawieraj�c� liczb� pracownik�w na ka�dym stanowisku
--
-- Parametry wej�ciowe: Brak
-- Parametry wyj�ciowe: Tabela z liczb� pracownik�w na ka�dym stanowisku
--
-- Przyk�ad u�ycia:
--SELECT * FROM uf_LiczbaPracownikowNaStanowisku();
--------------------------------------------------------------------------------------
CREATE FUNCTION uf_LiczbaPracownikowNaStanowisku()
RETURNS TABLE
AS
RETURN
(
    SELECT Stanowiska.IdStanowiska, Stanowiska.Stanowisko, COUNT(*) AS LiczbaPracownikow
    FROM Pracownicy
    JOIN Stanowiska ON Pracownicy.IdStanowiska = Stanowiska.IdStanowiska
    GROUP BY Stanowiska.IdStanowiska, Stanowiska.Stanowisko
);
GO
--------------------------------------------------------------------------------------
-- PROCEDURE DEFINITION
-- up_RaportZarobkiPracownikow
-- CREATED BY Pawe� Wozign�j
--------------------------------------------------------------------------------------
-- Procedura generuje raport przedstawiaj�cy sum� zarobk�w pracownik�w za okre�lony okres czasu
--
-- Parametry wej�ciowe:
-- @DataPoczatkowa - data pocz�tkowa okresu
-- @DataKoncowa - data ko�cowa okresu
--
-- Parametry wyj�ciowe: Lista pracownik�w wraz z sum� zarobk�w
--
-- Przyk�ad u�ycia:
 DECLARE @DataPoczatkowa DATE = '2024-01-01';
 DECLARE @DataKoncowa DATE = '2024-12-31';
 EXEC up_RaportZarobkiPracownikow @DataPoczatkowa, @DataKoncowa;
--------------------------------------------------------------------------------------
CREATE PROCEDURE up_RaportZarobkiPracownikow
    @DataPoczatkowa DATE,
    @DataKoncowa DATE
AS
BEGIN
    DECLARE @IdPracownika INT
    DECLARE @Imie VARCHAR(50)
    DECLARE @Nazwisko VARCHAR(50)
    DECLARE @KwotaStawki DECIMAL(10, 2)
    DECLARE @LiczbaGodzin INT
    DECLARE @SumaZarobkow DECIMAL(10, 2)
    DECLARE @PrevIdPracownika INT = -1 -- Inicjalizacja zmiennej @PrevIdPracownika
    
    DECLARE raport_cursor CURSOR FOR
    SELECT 
        Pracownicy.IdPracownika,
        Pracownicy.Imie,
        Pracownicy.Nazwisko,
        StawkiPracownikow.KwotaStawki,
        PrzebiegDniaPracy.LiczbaGodzin
    FROM 
        Pracownicy
    JOIN 
        StawkiPracownikow ON Pracownicy.IdStawki = StawkiPracownikow.IdStawki
    JOIN 
        PrzebiegDniaPracy ON Pracownicy.IdPracownika = PrzebiegDniaPracy.IdPracownika
    WHERE 
        PrzebiegDniaPracy.Data BETWEEN @DataPoczatkowa AND @DataKoncowa
    ORDER BY 
        Pracownicy.IdPracownika;
    
    OPEN raport_cursor
    FETCH NEXT FROM raport_cursor INTO @IdPracownika, @Imie, @Nazwisko, @KwotaStawki, @LiczbaGodzin
    
    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF (@@ROWCOUNT = 1) OR (@IdPracownika <> @PrevIdPracownika)
        BEGIN
			PRINT '---------------------------------------------'
            PRINT 'Pracownik: ' + @Imie + ' ' + @Nazwisko
            PRINT 'Suma zarobk�w: '
        END
        
        SET @SumaZarobkow = @KwotaStawki * @LiczbaGodzin
        PRINT '  - ' + CAST(@SumaZarobkow AS VARCHAR(20))
        
        SET @PrevIdPracownika = @IdPracownika
        
        FETCH NEXT FROM raport_cursor INTO @IdPracownika, @Imie, @Nazwisko, @KwotaStawki, @LiczbaGodzin
    END
    
    CLOSE raport_cursor
    DEALLOCATE raport_cursor
END;





























