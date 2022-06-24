--First script is to copy everything from [ACT].[dbo].[FileType]. This is not everything from File Definition though so follow the scripts in order.
--The first script is to be run in the source location. It will generate an insert statement that will copy a row from the SOURCE location.

--Fill @FileTypeName
DECLARE @FileTypeName VARCHAR(50) = 'Subro KPS - Pending - Subrogation'
DECLARE @OutputText1 VARCHAR(MAX)

--[FileExtension], [ResultStatusID], [FileHeader], [AmountFileGenMappingID], [RequiresUnixNewLine], [RowNumberHeaderText], [RowNumberFixedWidth], [RowNumberColumnIndex], [IncludeDetailColumnHeaders], [RowNumberFixedWidth], [RowNumberColumnIndex], [IncludeDetailColumnHeaders], [StringDataWrapper], [DateTimeDataWrapper] are all fields that could have NULL values. They require an IF ELSE statement.

SET @OutputText1 = 'SET IDENTITY_INSERT [ACT].[dbo].[FileType] ON;' + CHAR(13) + CHAR(10_
SET @OutputText1 = @OutputText1 + 'INSERT INTO [ACT].[dbo].[FileType] (ID, Name, Description, FileFormatID, NameConvention, FileExtension, Delimitor, ResultStatusID, Active, GenerateImages, FileHeader, FileDefinitionFilterTypeID, ContentTypeID, AmountFileGenMappingID, PortalVisible, IsComboFile, RequiresUnixNewline, RowNumberHeaderText, RowNumberFixedWidth, RowNumberColumnIndex, IncludeDetailColumnHeader, StringDataWrapper, DatetimeDataWrapper, GenerateEmptyFile, PopulateImageFile, ODARImageFileFormat)' + CHAR(13) + CHAR(10) + 'VALUES('

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
	
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [Active] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [GenerateImages] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','

IF (SELECT [FileHeader] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [FileHeader] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','

SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [FileDefinitionFilterTypeID] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [ContentTypeID] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','

IF (SELECT [AmountFileGenMappingID] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [AmountFileGenMappingID] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','

SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [PortalVisible] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [IsComboFile] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','

IF (SELECT [RequiresUnixNewLine] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [RequiresUnixNewLine] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
	
IF (SELECT [RowNumberHeaderText] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [RowNumberHeaderText] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
	
IF (SELECT [RowNumberFixedWidth] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [RowNumberFixedWidth] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
	
IF (SELECT [RowNumberColumnIndex] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [RowNumberColumnIndex] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','

IF (SELECT [IncludeDetailColumnHeaders] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [IncludeDetailColumnHeaders] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
	
IF (SELECT [StringDataWrapper] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [StringDataWrapper] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
	
IF (SELECT [StringDataWrapper] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [StringDataWrapper] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
	
IF (SELECT [DatetimeDataWrapper] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [DatetimeDataWrapper] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
	
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [GenerateEmptyFile] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [PopulateImageFile] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [ODARImageFileFormat] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) AS VARCHAR) + ''')' + CHAR(13) + CHAR(10)

SET @OutputText1 = @OutputText1 + 'SET IDENTITY_INSERT [ACT].[dbo].[FileType] OFF'
SELECT @OutputText1 AS 'First Script'
--End of first script. Take the output and run it in the target database.

--Second script to add to [ACT].[dbo].[FileGenMapping]]. Pulling the same FileTypeID from the source location because it should NOT exist in the target location. If it does, then it should error.
DECLARE @FileTypeID INT = (SELECT [ID] FROM [ACT].[dbo].[FileType] WHERE Name = @FileTypeName) 
--FileTypeID is used as the PK for both FileGenMapping and FileTypeFilter
DECLARE @OutputText2 VARCHAR(MAX) = 'INSERT INTO [ACT].[dbo].[FileGenMapping] (FileTypeID, FieldID, StaticValue, OutputName, Ordinal, Formatter, CalculationID, CustomCalculation, RecordTypeID, SortLevel, SortDescending, CollapseOperator)' + CHAR(13) + CHAR(10) + 'VALUES'
--Necessary to iterate through the ordinals starting from 1.
DECLARE @Ordinal INT = 1
