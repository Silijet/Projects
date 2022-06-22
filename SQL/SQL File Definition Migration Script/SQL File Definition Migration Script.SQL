--First script is to copy everything from [ACT].[dbo].[FileType]. This is not everything from File Definition though so follow the scripts in order.
--The first script is to be run in the source location. It will generate an insert statement that will copy a row from the SOURCE location.

--Fill @FileTypeName
DECLARE @FileTypeName VARCHAR(50) = 'Subro KPS - Pending - Subrogation'
DECLARE @OutputText1 VARCHAR(MAX)
