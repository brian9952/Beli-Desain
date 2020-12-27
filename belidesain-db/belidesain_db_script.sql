CREATE TABLE User(
  UserId INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  Email VARCHAR(32),
  Password VARCHAR(32),
  LastActivity DATE,
  IsOnline BOOL,
  IsSupplier BOOL,
);

CREATE TABLE UserInfo(
  UserId INT(32) NOT NULL,
  Name VARCHAR(100),
  Description TEXT,
  Company VARCHAR(48),
  Location VARCHAR(48),
  Website VARCHAR(64),
  PhoneNumber VARCHAR(16),
  FOREIGN KEY (UserId) REFERENCES User (UserId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE UserPhoto(
  PhotoId  INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  UserId  INT(32) NOT NULL,
  PhotoName VARCHAR(48),
  FOREIGN KEY (UserId) REFERENCES User (UserId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ChatSystem(
  ChatSystemId  INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  toUserId  INT(32) NOT NULL,
  fromUserId  INT(32) NOT NULL,
  Message VARCHAR(100),
  Timestamp DATE,
  StatusMessage VARCHAR(15),
  FOREIGN KEY (toUserId) REFERENCES User (UserId) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (fromUserId) REFERENCES User (UserId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DesignTheme(
  ThemeId INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	ThemeName VARCHAR(20),
  ThemeDesc TEXT,
);

CREATE TABLE DesignCategories(
  CategoryId  INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  CategoryName VARCHAR(20),
  CategoryDesc TEXT,
  CategoryPhoto VARCHAR(20),  
);

CREATE TABLE DesignSubCategories(
  SubCategoryId INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  SubCategoryName VARCHAR(64),
  SubCategoryDesc TEXT,
);

CREATE TABLE DesignHeader(
  DesignId  INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  CategoryId  INT(32) NOT NULL,
  SubCategoryId INT(32) NOT NULL,
  ThemeId  INT(32) NOT NULL,
  SupplierUserId INT(32) NOT NULL,
  isSold BOOLEAN,
  FOREIGN KEY (CategoryId) REFERENCES DesignCategory (CategoryId),
  FOREIGN KEY (SubCategoryId) REFERENCES DesignSubCategory (SubCategoryId),
  FOREIGN KEY (ThemeId) REFERENCES DesignTheme (ThemeId),
  FOREIGN KEY (SupplierUserId) REFERENCES User (UserId)
);

CREATE TABLE DesignRating(
  RatingId INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
	DesignId INT(32) NOT NULL,
	UserId INT(32) NOT NULL,
	Rating INT(5),
  FOREIGN KEY (DesignId) REFERENCES DesignHeader (DesignId),
	FOREIGN KEY (UserId) REFERENCES User (UserId)
);

CREATE TABLE DesignComments(
  CommentId  INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  DesignId  INT(32) NOT NULL,
  UserId  INT(32) NOT NULL,
  Comment TEXT,
  DateSent DATE,
  FOREIGN KEY (DesignId) REFERENCES DesignHeader (DesignId),
  FOREIGN KEY (UserId) REFERENCES User (UserId)
);

CREATE TABLE UserInventory(
  InventoryId  INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  UserId  INT(32) NOT NULL,
  DesignId  INT(32) NOT NULL,
  DatePurchased DATE,
  FOREIGN KEY (UserId) REFERENCES User (UserId),
  FOREIGN KEY (DesignId) REFERENCES DesignHeader (DesignId)
);

CREATE TABLE TransactionHeader(
  TransactionId  INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  DesignId INT(32) NOT NULL,
  BuyerUserId INT(32) NOT NULL,
  SupplierUserId INT(32) NOT NULL,
  IsSuccess BOOLEAN,
  IsExpired BOOLEAN,
  TransactionType VARCHAR(32),
  FOREIGN KEY (DesignId) REFERENCES DesignHeader (DesignId),
  FOREIGN KEY (BuyerUserId) REFERENCES User (UserId),
  FOREIGN KEY (SupplierUserId) REFERENCES User (UserId)
);

CREATE TABLE TransactionDetails(
  TransactionId  INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  TransactionAmount INT(32),
  TransactionDate DATE,
  ExpirationDate DATE,
  DateCreated DATE,
  FOREIGN KEY (TransactionId) REFERENCES TransactionHeader (TransactionId)
);

CREATE TABLE DesignDetails(
  DesignId INT(32) NOT NULL PRIMARY KEY,
  DesignName VARCHAR(64),
  DesignDesc TEXT,
  DesignPrice INT(32),
  DesignDateCreated DATE,
  FOREIGN KEY (DesignId) REFERENCES DesignHeader (DesignId)
);

CREATE TABLE DesignPhotos(
  DesignPhotoId INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  DesignId INT(32) NOT NULL,
  DesignPhotoName VARCHAR(64),
  FOREIGN KEY (DesignId) REFERENCES DesignDetails (DesignId)
);

CREATE TABLE DesignSpesification(
  SpesificationId INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  DesignId INT(32) NOT NULL,
  SpesificationName VARCHAR(32),
  SpesificationDesc VARCHAR(32)
  FOREIGN KEY (DesignId) REFERENCES DesignDetails (DesignId)
);

CREATE TABLE DesignFile(
  DesignFileId INT(32) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  DesignId INT(32) NOT NULL,
  DesignFileName VARCHAR(20),
  DesignFileType VARCHAR(20),
  FOREIGN KEY (DesignId) REFERENCES DesignDetails (DesignId)
);
