--First script is to copy everything from [A].[dbo].[FT]. This is not everything from File Definition though so follow the scripts in order.
--The first script is to be run in the source location. It will generate an insert statement that will copy a row from the SOURCE location.

--Fill @FTName
DECLARE @FTName VARCHAR(50) = 'Subro KPS - Pending - Subrogation'
DECLARE @OutputText1 VARCHAR(MAX)

--[FileExtension], [ResultStatusID], [FileHeader], [AmountFileGenMappingID], [RequiresUnixNewLine], [RowNumberHeaderText], [RowNumberFixedWidth], [RowNumberColumnIndex], [IncludeDetailColumnHeaders], [RowNumberFixedWidth], [RowNumberColumnIndex], [IncludeDetailColumnHeaders], [StringDataWrapper], [DateTimeDataWrapper] are all fields that could have NULL values. They require an IF ELSE statement.

SET @OutputText1 = 'SET IDENTITY_INSERT [A].[dbo].[FT] ON;' + CHAR(13) + CHAR(10_
SET @OutputText1 = @OutputText1 + 'INSERT INTO [A].[dbo].[FT] (ID, Name, Description, FileFormatID, NameConvention, FileExtension, Delimitor, ResultStatusID, Active, GenerateImages, FileHeader, FileDefinitionFilterTypeID, ContentTypeID, AmountFileGenMappingID, PortalVisible, IsComboFile, RequiresUnixNewline, RowNumberHeaderText, RowNumberFixedWidth, RowNumberColumnIndex, IncludeDetailColumnHeader, StringDataWrapper, DatetimeDataWrapper, GenerateEmptyFile, PopulateImageFile, ODARImageFileFormat)' + CHAR(13) + CHAR(10) + 'VALUES('

SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [ID] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [Name] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [Description] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [FileFormatID] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [NameConvention] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','

IF (SELECT [FileExtension] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [FileExtension] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
	
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [Delimitor] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','

IF (SELECT [ResultsStatusID] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [ResultsStatusID] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
	
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [Active] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [GenerateImages] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','

IF (SELECT [FileHeader] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [FileHeader] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','

SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [FileDefinitionFilterTypeID] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [ContentTypeID] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','

IF (SELECT [AmountFileGenMappingID] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [AmountFileGenMappingID] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','

SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [PortalVisible] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [IsComboFile] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','

IF (SELECT [RequiresUnixNewLine] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [RequiresUnixNewLine] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
	
IF (SELECT [RowNumberHeaderText] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [RowNumberHeaderText] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
	
IF (SELECT [RowNumberFixedWidth] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [RowNumberFixedWidth] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
	
IF (SELECT [RowNumberColumnIndex] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [RowNumberColumnIndex] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','

IF (SELECT [IncludeDetailColumnHeaders] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [IncludeDetailColumnHeaders] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
	
IF (SELECT [StringDataWrapper] FROM [AC].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [StringDataWrapper] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
	
IF (SELECT [StringDataWrapper] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [StringDataWrapper] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
	
IF (SELECT [DatetimeDataWrapper] FROM [A].[dbo].[FT] WHERE Name = @FTName IS NULL
	SET @OutputText1 = CONCAT(@OutputText1,'NULL,')
ELSE
	SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [DatetimeDataWrapper] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
	
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [GenerateEmptyFile] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [PopulateImageFile] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''','
SET @OutputText1 = @OutputText1 + '''' + CAST((SELECT [ODARImageFileFormat] FROM [A].[dbo].[FT] WHERE Name = @FTName) AS VARCHAR) + ''')' + CHAR(13) + CHAR(10)

SET @OutputText1 = @OutputText1 + 'SET IDENTITY_INSERT [A].[dbo].[FT] OFF'
SELECT @OutputText1 AS 'First Script'
--End of first script. Take the output and run it in the target database.

--Second script to add to [A].[dbo].[FGM]]. Pulling the same FileTypeID from the source location because it should NOT exist in the target location. If it does, then it should error.
DECLARE @FileTypeID INT = (SELECT [ID] FROM [A].[dbo].[FT] WHERE Name = @FTName) 
--FileTypeID is used as the PK for both FGM and FTF
DECLARE @OutputText2 VARCHAR(MAX) = 'INSERT INTO [A].[dbo].[FGM] (FileTypeID, FieldID, StaticValue, OutputName, Ordinal, Formatter, CalculationID, CustomCalculation, RecordTypeID, SortLevel, SortDescending, CollapseOperator)' + CHAR(13) + CHAR(10) + 'VALUES'
--Necessary to iterate through the ordinals starting from 1.
DECLARE @Ordinal INT = 1

WHILE EXISTS (SELECT [FileTypeID] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal
BEGIN
--Because there may be multiple ordinals, starting with each list of values with an open parenthesis is necessary for multiple lists to be added
	SET @OutputText2 = @OutputText2 + '(''' + CAST((SELECT [FileTypeID] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','
	IF (SELECT [FieldID] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) IS NULL
		SET @OutputText2 = CONCAT(@OutputText2,'NULL')
	ELSE
		SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [FieldID] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','
	
	IF (SELECT [StaticValue] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) IS NULL
		SET @OutputText2 = CONCAT(@OutputText2,'NULL')
	ELSE
		SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [StaticValue] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','
	
	SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [StaticValue] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','
	SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [OutputName] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','
	SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [Ordinal] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','
	
	
	IF (SELECT [Formatter] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) IS NULL
		SET @OutputText2 = CONCAT(@OutputText2,'NULL')
	ELSE
		SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [Formatter] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','
		
	
	IF (SELECT [CalculationID] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) IS NULL
		SET @OutputText2 = CONCAT(@OutputText2,'NULL')
	ELSE
		SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [CalculationID] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','
		
	
	IF (SELECT [CustomCalculation] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) IS NULL
		SET @OutputText2 = CONCAT(@OutputText2,'NULL')
	ELSE
		SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [CustomCalculation] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR(MAX)) + ''','
		
	SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [RecordTypeID] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','
	
	
	IF (SELECT [SortLevel] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) IS NULL
		SET @OutputText2 = CONCAT(@OutputText2,'NULL')
	ELSE
		SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [SortLevel] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','
	
	IF (SELECT [SortDescending] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) IS NULL
		SET @OutputText2 = CONCAT(@OutputText2,'NULL')
	ELSE
		SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [SortDescending] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''','

--Final Field that is added needs to end with a closed parenthesis

	IF (SELECT [CollapseOperator] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) IS NULL
		SET @OutputText2 = CONCAT(@OutputText2,'NULL')
	ELSE
		SET @OutputText2 = @OutputText2 + '''' + CAST((SELECT [CollapseOperator] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal) AS VARCHAR) + ''')'
		
--Checking if the next ordinal exists. If it does, then a comma will be added to the end of the list and the loop will continue.

	IF EXISTS (SELECT [FileTypeID] FROM [A].[dbo].[FGM] WHERE FileTypeID = @FileTypeID AND Ordinal = @Ordinal + 1)
		SET @OutputText2 = @OutputText2 + ','
	ELSE
		BREAK
		
--Can iterate by the ordinal since this will account for all the fields that are added

	SET @Ordinal = @Ordinal +1
	
END
SELECT @OutputText2 AS "Second Script"
--End of second script. Take the output and run it in the target database.

--Third script to add to [A].[dbo].[FTF]
DECLARE @ID int
DECLARE @OutputText3 VARCHAR(MAX) = 'INSERT INTO [A].[dbo].[FTF] (FileTypeID, FieldID, FilterValue, IsRange)' + CHAR(13) + CHAR(10) + 'VALUES'

SELECT *
INTO #TempFTF
FROM [A].[dbo].[FTF]
WHERE FileTypeID = @FileTypeID

--If nothing returns from the SELECT, then EXISTS will return false. However, the table object still exists.
WHILE EXISTS (SELECT * FROM #TempFTF)
BEGIN
	SET @OutputText3 = @OutputText3 + '(''' + CAST((SELECT TOP(1) [FileTypeID] FROM #TempFTF ORDER BY ID) AS VARCHAR) + ''','
	SET @OutputText3 = @OutputText3 + '(''' + CAST((SELECT TOP(1) [FieldID] FROM #TempFTF ORDER BY ID) AS VARCHAR) + ''','
	SET @OutputText3 = @OutputText3 + '(''' + CAST((SELECT TOP(1) [FilterValue] FROM #TempFTF ORDER BY ID) AS VARCHAR) + ''','
	IF (SELECT TOP(1) [IsRange] FROM #TempFTF ORDER BY ID) IS NULL
		SET @OutputText3 = CONCAT(@OutputText3,'NULL)')
	ELSE
		SET @OutputText3 = @OutputText3 + '''' + CAST((SELECT TOP (1) [IsRange] FROM #TempFTF ORDER BY ID) AS VARCHAR) + ''')'
	--Deletes the rows within the temp table as it progresses through it.
	SET @ID = (SELECT TOP (1) ID FROM #TempFTF ORDER BY ID)
	DELETE #TempFTF WHERE ID = @ID
	
	IF EXISTS (SELECT * FROM #TempFTF)
		SET @OutputText3 = @OutputText + ','
	ELSE
		BREAK
END
--After iterating through every row, it should delete the row and then finally we will need to drop the empty table.
DROP TABLE #TempFTF
SELECT @OutputText3 AS 'Third Script'
