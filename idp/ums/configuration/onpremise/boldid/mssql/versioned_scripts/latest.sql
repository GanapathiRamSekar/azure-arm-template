IF NOT EXISTS (SELECT * FROM   INFORMATION_SCHEMA.TABLES WHERE  TABLE_NAME = 'BOLDTC_CredentialGroup')
BEGIN
CREATE TABLE [BOLDTC_CredentialGroup] (
    Id int IDENTITY(1,1) NOT NULL,
    Name nvarchar(255) NOT NULL,
    CreatedDate datetime NOT NULL,
    ModifiedDate datetime NOT NULL,
    IsActive bit NOT NULL,
    CONSTRAINT [PK_BOLDTC_CredentialGroup] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)

INSERT into [BOLDTC_CredentialGroup]  ([Name],[CreatedDate],[ModifiedDate],[IsActive]) VALUES (N'Database',GETDATE(),GETDATE(),1)

INSERT into [BOLDTC_CredentialGroup]  ([Name],[CreatedDate],[ModifiedDate],[IsActive]) VALUES (N'Storage',GETDATE(),GETDATE(),1)
END;

IF NOT EXISTS (SELECT * FROM   INFORMATION_SCHEMA.TABLES WHERE  TABLE_NAME = 'BOLDTC_CredentialType')
BEGIN
CREATE TABLE [BOLDTC_CredentialType] (
    Id int IDENTITY(1,1) NOT NULL,
    Name nvarchar(50) NOT NULL,
    CredentialGroupId int NOT NULL,
    CreatedDate datetime NOT NULL,
    ModifiedDate datetime NOT NULL,
    IsActive bit NOT NULL,
    CONSTRAINT [PK_BOLDTC_CredentialTyp] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)

ALTER TABLE [BOLDTC_CredentialType]  ADD CONSTRAINT  [BOLDTC_CredentialType_fk0]  FOREIGN KEY ([CredentialGroupId]) REFERENCES [BOLDTC_CredentialGroup]([Id])

ALTER TABLE [BOLDTC_CredentialType] CHECK CONSTRAINT [BOLDTC_CredentialType_fk0]

INSERT into [BOLDTC_CredentialType]  ([Name],[CredentialGroupId],[CreatedDate],[ModifiedDate],[IsActive]) VALUES (N'MSSQL',1,GETDATE(),GETDATE(),1)

INSERT into [BOLDTC_CredentialType]  ([Name],[CredentialGroupId],[CreatedDate],[ModifiedDate],[IsActive]) VALUES (N'PostgreSQL',1,GETDATE(),GETDATE(),1)

INSERT into [BOLDTC_CredentialType]  ([Name],[CredentialGroupId],[CreatedDate],[ModifiedDate],[IsActive]) VALUES (N'MySQL',1,GETDATE(),GETDATE(),1)

INSERT into [BOLDTC_CredentialType]  ([Name],[CredentialGroupId],[CreatedDate],[ModifiedDate],[IsActive]) VALUES (N'File',2,GETDATE(),GETDATE(),1)

INSERT into [BOLDTC_CredentialType]  ([Name],[CredentialGroupId],[CreatedDate],[ModifiedDate],[IsActive]) VALUES (N'AzureBlob',2,GETDATE(),GETDATE(),1)

INSERT into [BOLDTC_CredentialType]  ([Name],[CredentialGroupId],[CreatedDate],[ModifiedDate],[IsActive]) VALUES (N'AmazonS3',2,GETDATE(),GETDATE(),1)

END;

IF NOT EXISTS (SELECT * FROM   INFORMATION_SCHEMA.TABLES WHERE  TABLE_NAME = 'BOLDTC_Credentials')
BEGIN
CREATE TABLE [BOLDTC_Credentials] (
    Id uniqueidentifier NOT NULL,
    Name nvarchar(100) NOT NULL,
    Description nvarchar(100) NOT NULL,
    Credentials nvarchar(1026) NOT NULL,
    CredentialTypeId int NOT NULL,
    CreatedDate datetime NOT NULL,
    ModifiedDate datetime NOT NULL,
    IsActive bit NOT NULL,
    CONSTRAINT [PK_BOLDTC_Credentials] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)

ALTER TABLE [BOLDTC_Credentials]  ADD CONSTRAINT  [BOLDTC_Credentials_fk0]  FOREIGN KEY ([CredentialTypeId]) REFERENCES [BOLDTC_CredentialType]([Id])

ALTER TABLE [BOLDTC_Credentials] CHECK CONSTRAINT [BOLDTC_Credentials_fk0]
END;

IF NOT EXISTS (SELECT * FROM   INFORMATION_SCHEMA.TABLES WHERE  TABLE_NAME = 'BOLDTC_TenantStorageType')
BEGIN
CREATE TABLE [BOLDTC_TenantStorageType] (
    Id uniqueidentifier NOT NULL,
    TenantInfoId uniqueidentifier NOT NULL,
    StorageType int NOT NULL,
    CredentialId uniqueidentifier NOT NULL,
    ConnectionInfo nvarchar(1026),
    CreatedDate datetime NOT NULL,
    ModifiedDate datetime NOT NULL,
    IsActive bit NOT NULL,
    CONSTRAINT [PK_BOLDTC_TenantStorageType] PRIMARY KEY CLUSTERED
  (
  [Id] ASC
  ) WITH (IGNORE_DUP_KEY = OFF)
)

ALTER TABLE [BOLDTC_TenantStorageType]  ADD CONSTRAINT  [BOLDTC_TenantStorageType_fk0]  FOREIGN KEY ([TenantInfoId]) REFERENCES [BOLDTC_TenantInfo]([Id])

ALTER TABLE [BOLDTC_TenantStorageType] CHECK CONSTRAINT [BOLDTC_TenantStorageType_fk0]

ALTER TABLE [BOLDTC_TenantStorageType]  ADD CONSTRAINT  [BOLDTC_TenantStorageType_fk1]  FOREIGN KEY ([CredentialId]) REFERENCES [BOLDTC_Credentials]([Id])

ALTER TABLE [BOLDTC_TenantStorageType] CHECK CONSTRAINT [BOLDTC_TenantStorageType_fk1]
END;

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BOLDTC_TenantInfo' AND COLUMN_NAME = 'StorageType')
BEGIN
ALTER TABLE [BOLDTC_TenantInfo] ADD [StorageType] INT NOT NULL DEFAULT 0
END;

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'BOLDTC_TenantInfo' AND COLUMN_NAME = 'StorageType') AND EXISTS (SELECT 1 FROM BOLDTC_TenantInfo WHERE StorageType = 0)
BEGIN
    UPDATE BOLDTC_TenantInfo
    SET StorageType = 1
    WHERE BlobConnectionString IS NOT NULL AND BlobConnectionString <> ''
END;