CREATE TABLE IF NOT EXISTS BOLDTC_CredentialGroup (
    Id SERIAL NOT NULL,
    Name varchar(255) NOT NULL,
    CreatedDate timestamp NOT NULL,
    ModifiedDate timestamp NOT NULL,
    IsActive smallint NOT NULL,
    CONSTRAINT PK_BOLDTC_CredentialGroup PRIMARY KEY (Id)
);

INSERT INTO BOLDTC_CredentialGroup (Name, CreatedDate, ModifiedDate, IsActive)
SELECT 'Database', now() at time zone 'utc', now() at time zone 'utc', 1
WHERE NOT EXISTS (
    SELECT *
    FROM BOLDTC_CredentialGroup
    WHERE Name = 'Database'
);

INSERT INTO BOLDTC_CredentialGroup (Name, CreatedDate, ModifiedDate, IsActive)
SELECT 'Storage', now() at time zone 'utc', now() at time zone 'utc', 1
WHERE NOT EXISTS (
    SELECT *
    FROM BOLDTC_CredentialGroup
    WHERE Name = 'Storage'
);

CREATE TABLE IF NOT EXISTS BOLDTC_CredentialType (
    Id SERIAL NOT NULL,
    Name varchar(50) NOT NULL,
    CredentialGroupId int NOT NULL,
    CreatedDate timestamp NOT NULL,
    ModifiedDate timestamp NOT NULL,
    IsActive smallint NOT NULL,
    CONSTRAINT PK_BOLDTC_CredentialType PRIMARY KEY (Id),
    CONSTRAINT BOLDTC_CredentialType_fk0
        FOREIGN KEY (CredentialGroupId)
        REFERENCES boldtc_credentialgroup(Id)
);

CREATE TABLE IF NOT EXISTS BOLDTC_Credentials (
    Id uuid NOT NULL,
    Name varchar(100) NOT NULL,
    Description varchar(100) NOT NULL,
    Credentials varchar(1026) NOT NULL,
    CredentialTypeId int NOT NULL,
    CreatedDate timestamp NOT NULL,
    ModifiedDate timestamp NOT NULL,
    IsActive smallint NOT NULL,
    CONSTRAINT PK_BOLDTC_Credentials PRIMARY KEY (Id),
     CONSTRAINT BOLDTC_Credentials_fk0
        FOREIGN KEY (CredentialTypeId)
        REFERENCES BOLDTC_CredentialType(Id)
);

CREATE TABLE IF NOT EXISTS BOLDTC_TenantStorageType (
    Id uuid NOT NULL,
    TenantInfoId uuid NOT NULL,
    StorageType INT NOT NULL,
    CredentialId uuid NOT NULL,
    ConnectionInfo VARCHAR(1026),
    CreatedDate TIMESTAMP NOT NULL,
    ModifiedDate TIMESTAMP NOT NULL,
    IsActive smallint NOT NULL,
    CONSTRAINT PK_BOLDTC_TenantStorageType PRIMARY KEY (Id),
     CONSTRAINT BOLDTC_TenantStorageType_fk0
        FOREIGN KEY (TenantInfoId)
        REFERENCES BOLDTC_TenantInfo(Id),
     CONSTRAINT BOLDTC_TenantStorageType_fk1
        FOREIGN KEY (CredentialId)
        REFERENCES BOLDTC_Credentials(Id)
);

ALTER TABLE BOLDTC_TenantInfo ADD COLUMN IF NOT EXISTS StorageType INT NOT NULL DEFAULT 0;

UPDATE BOLDTC_TenantInfo
SET StorageType = 1
WHERE StorageType = 0
    AND BlobConnectionString IS NOT NULL
    AND BlobConnectionString <> '';

INSERT INTO BOLDTC_CredentialType (Name, CredentialGroupId, CreatedDate, ModifiedDate, IsActive)
SELECT 'MSSQL', 1, now() at time zone 'utc', now() at time zone 'utc', 1
WHERE NOT EXISTS (
    SELECT *
    FROM BOLDTC_CredentialType
    WHERE Name = 'MSSQL'
);

INSERT INTO BOLDTC_CredentialType (Name, CredentialGroupId, CreatedDate, ModifiedDate, IsActive)
SELECT 'PostgreSQL', 1, now() at time zone 'utc', now() at time zone 'utc', 1
WHERE NOT EXISTS (
    SELECT *
    FROM BOLDTC_CredentialType
    WHERE Name = 'PostgreSQL'
);

INSERT INTO BOLDTC_CredentialType (Name, CredentialGroupId, CreatedDate, ModifiedDate, IsActive)
SELECT 'MySQL', 1, now() at time zone 'utc', now() at time zone 'utc', 1
WHERE NOT EXISTS (
    SELECT *
    FROM BOLDTC_CredentialType
    WHERE Name = 'MySQL'
);

INSERT INTO BOLDTC_CredentialType (Name, CredentialGroupId, CreatedDate, ModifiedDate, IsActive)
SELECT 'File', 2, now() at time zone 'utc', now() at time zone 'utc', 1
WHERE NOT EXISTS (
    SELECT *
    FROM BOLDTC_CredentialType
    WHERE Name = 'File'
);

INSERT INTO BOLDTC_CredentialType (Name, CredentialGroupId, CreatedDate, ModifiedDate, IsActive)
SELECT 'AzureBlob', 2, now() at time zone 'utc', now() at time zone 'utc', 1
WHERE NOT EXISTS (
    SELECT *
    FROM BOLDTC_CredentialType
    WHERE Name = 'AzureBlob'
);

INSERT INTO BOLDTC_CredentialType (Name, CredentialGroupId, CreatedDate, ModifiedDate, IsActive)
SELECT 'AmazonS3', 2, now() at time zone 'utc', now() at time zone 'utc', 1
WHERE NOT EXISTS (
    SELECT *
    FROM BOLDTC_CredentialType
    WHERE Name = 'AmazonS3'
);