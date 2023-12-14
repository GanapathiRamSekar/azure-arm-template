CREATE TABLE {database_name}.BOLDTC_CredentialGroup (
    Id int NOT NULL AUTO_INCREMENT,
    Name nvarchar(255) NOT NULL,
    CreatedDate datetime NOT NULL,
    ModifiedDate datetime NOT NULL,
    IsActive tinyint(1) NOT NULL,
    CONSTRAINT PK_BOLDTC_CredentialGroup PRIMARY KEY (Id ASC)
)
;

CREATE TABLE {database_name}.BOLDTC_CredentialType (
    Id int NOT NULL AUTO_INCREMENT,
    Name nvarchar(50) NOT NULL,
    CredentialGroupId int NOT NULL,
    CreatedDate datetime NOT NULL,
    ModifiedDate datetime NOT NULL,
    IsActive tinyint(1) NOT NULL,
    CONSTRAINT PK_BOLDTC_CredentialType PRIMARY KEY (Id ASC)
)
;

ALTER TABLE {database_name}.BOLDTC_CredentialType ADD CONSTRAINT BOLDTC_CredentialType_fk0 FOREIGN KEY (CredentialGroupId) REFERENCES {database_name}.BOLDTC_CredentialGroup(Id)
;

CREATE TABLE {database_name}.BOLDTC_Credentials (
    Id char(38) NOT NULL,
    Name nvarchar(100) NOT NULL,
    Description nvarchar(100) NOT NULL,
    Credentials nvarchar(1026) NOT NULL,
    CredentialTypeId int NOT NULL,
    CreatedDate datetime NOT NULL,
    ModifiedDate datetime NOT NULL,
    IsActive tinyint(1) NOT NULL,
    CONSTRAINT PK_BOLDTC_Credentials PRIMARY KEY (Id ASC)
)
;

ALTER TABLE {database_name}.BOLDTC_Credentials ADD CONSTRAINT BOLDTC_Credentials_fk0 FOREIGN KEY (CredentialTypeId) REFERENCES {database_name}.BOLDTC_CredentialType(Id)
;

CREATE TABLE {database_name}.BOLDTC_TenantStorageType (
    Id char(38) NOT NULL,
    TenantInfoId char(38) NOT NULL,
    StorageType int NOT NULL,
    CredentialId char(38) NOT NULL,
    ConnectionInfo nvarchar(1026),
    CreatedDate datetime NOT NULL,
    ModifiedDate datetime NOT NULL,
    IsActive tinyint(1) NOT NULL,
    CONSTRAINT PK_BOLDTC_TenantStorageType PRIMARY KEY (Id ASC)
)
;

ALTER TABLE  {database_name}.BOLDTC_TenantStorageType  ADD CONSTRAINT  BOLDTC_TenantStorageType_fk0  FOREIGN KEY (TenantInfoId) REFERENCES {database_name}.BOLDTC_TenantInfo(Id)
;

ALTER TABLE  {database_name}.BOLDTC_TenantStorageType  ADD CONSTRAINT  BOLDTC_TenantStorageType_fk1  FOREIGN KEY (CredentialId) REFERENCES {database_name}.BOLDTC_Credentials(Id)
;

ALTER TABLE {database_name}.BOLDTC_TenantInfo ADD StorageType int NOT NULL DEFAULT 0;

UPDATE {database_name}.BOLDTC_TenantInfo SET StorageType = 1 WHERE BlobConnectionString IS NOT NULL AND BlobConnectionString <> '';

INSERT into  {database_name}.BOLDTC_CredentialGroup  (Name,CreatedDate,ModifiedDate,IsActive) VALUES (N'Database',CURDATE(),CURDATE(),1);

INSERT into  {database_name}.BOLDTC_CredentialGroup  (Name,CreatedDate,ModifiedDate,IsActive) VALUES (N'Storage',CURDATE(),CURDATE(),1);

INSERT into  {database_name}.BOLDTC_CredentialType  (Name,CredentialGroupId,CreatedDate,ModifiedDate,IsActive) VALUES (N'MSSQL',1,CURDATE(),CURDATE(),1);

INSERT into  {database_name}.BOLDTC_CredentialType  (Name,CredentialGroupId,CreatedDate,ModifiedDate,IsActive) VALUES (N'PostgreSQL',1,CURDATE(),CURDATE(),1);

INSERT into  {database_name}.BOLDTC_CredentialType  (Name,CredentialGroupId,CreatedDate,ModifiedDate,IsActive) VALUES (N'MySQL',1,CURDATE(),CURDATE(),1);

INSERT into  {database_name}.BOLDTC_CredentialType  (Name,CredentialGroupId,CreatedDate,ModifiedDate,IsActive) VALUES (N'File',2,CURDATE(),CURDATE(),1);

INSERT into  {database_name}.BOLDTC_CredentialType  (Name,CredentialGroupId,CreatedDate,ModifiedDate,IsActive) VALUES (N'AzureBlob',2,CURDATE(),CURDATE(),1);

INSERT into  {database_name}.BOLDTC_CredentialType  (Name,CredentialGroupId,CreatedDate,ModifiedDate,IsActive) VALUES (N'AmazonS3',2,CURDATE(),CURDATE(),1);