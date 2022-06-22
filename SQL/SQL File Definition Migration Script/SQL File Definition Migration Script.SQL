--First script is to copy everything from [ACT].[dbo].[FileType]. This is not everything from File Definition though so follow the scripts in order.
--The first script is to be run in the source location. It will generate an insert statement that will copy a row from the SOURCE location.

--Fill @FileTypeName
DECLARE @FileTypeName VARCHAR(50) = 'Subro KPS - Pending - Subrogation'
DECLARE @OutputText1 VARCHAR(MAX)

--[FileExtension], [ResultStatusID], [FileHeader], [AmountFileGenMappingID], [RequiresUnixNewLine], [RowNumberHeaderText], [RowNumberFixedWidth], [RowNumberColumnIndex], [IncludeDetailColumnHeaders], [RowNumberFixedWidth], [RowNumberColumnIndex], [IncludeDetailColumnHeaders], [StringDataWrapper], [DateTimeDataWrapper] are all fields that could have NULL values. They require an IF ELSE statement.

SET @OutputText1 = 'INSERT INTO [ACT].[dbo].[FileType] (ID, Name, Description, FileFormatID, NameConvention, FileExtension, Delimitor, ResultStatusID, Active, GenerateImages, FileHeader, FileDefinitionFilterTypeID, ContentTypeID, AmountFileGenMappingID, PortalVisible, IsComboFile, RequiresUnixNewline, RowNumberHeaderText, RowNumberFixedWidth, RowNumberColumnIndex, IncludeDetailColumnHeader, StringDataWrapper, DatetimeDataWrapper, GenerateEmptyFile, PopulateImageFile, ODARImageFileFormat)' + CHAR(13) + CHAR(10) + 'VALUES('

SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [ID] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [Name] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [Description] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [FileFormatID] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [NameConvention] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','

IF (SELECT [FileExtension] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
  SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [FileExtension] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
	
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [Delimitor] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','

IF (SELECT [ResultsStatusID] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
  SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [ResultsStatusID] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
