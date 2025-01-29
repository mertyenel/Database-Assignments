USE KutuphaneBilgiSistemi;
CREATE TABLE Yazarlar (
    YazarID INT PRIMARY KEY,
    Ad VARCHAR(50) NOT NULL,
    Soyad VARCHAR(50) NOT NULL,
    DogumTarihi DATE,
    Ulke VARCHAR(50)
);
CREATE TABLE Kitaplar (
    KitapID INT PRIMARY KEY,
    KitapAdi VARCHAR(100) NOT NULL,
    ISBN VARCHAR(13) NOT NULL,
    YayinEvi VARCHAR(100),
    BasimTarihi DATE,
    StokAdeti INT,
    YazarID INT NOT NULL,
    FOREIGN KEY (YazarID) REFERENCES Yazarlar(YazarID)
);
CREATE TABLE KutuphaneUyeleri (
    UyeID INT PRIMARY KEY,
    Ad VARCHAR(50) NOT NULL,
    Soyad VARCHAR(50) NOT NULL,
    Telefon VARCHAR(15),
    Adres VARCHAR(255)
);
CREATE TABLE OduncAlinanKitaplar (
    OduncID INT PRIMARY KEY,
    KitapID INT NOT NULL,
    UyeID INT NOT NULL,
    AlisTarihi DATE,
    TeslimTarihi DATE,
    FOREIGN KEY (KitapID) REFERENCES Kitaplar(KitapID),
    FOREIGN KEY (UyeID) REFERENCES KutuphaneUyeleri(UyeID)
);

