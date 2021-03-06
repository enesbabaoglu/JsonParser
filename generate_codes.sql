USE [Codes]
GO
/****** Object:  StoredProcedure [dbo].[generate_code]    Script Date: 13.01.2022 12:56:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[generate_codes] 
AS
DECLARE @ValidChar VARCHAR(1000) = 'ACDEFGHKLMNPRTXYZ234579';
DECLARE @counter int =0 ;
DECLARE @codeCount int = 0 ;
Declare @code VARCHAR(8)='' ;
Declare @character CHAR ='';
Declare @lastCharacter CHAR ='';

DECLARE @Codes TABLE
(
      Code varchar(8) not null
)
WHILE @codeCount < 1000
	BEGIN
		WHILE @counter <= 8
		BEGIN 
			SET @character = SUBSTRING(@ValidChar,CONVERT(int,(RAND()*(LEN(@ValidChar))+1)),1)
			SET @lastCharacter = SUBSTRING(@code,LEN(@code),1)
			IF (@character != @lastCharacter AND (SELECT CHAR(ASCII(@lastCharacter)+1)) != @character ) 
			BEGIN
				SET @code = @code + @character 
				SET @counter += 1
			END
		END
		IF NOT EXISTS(Select * From @Codes WHERE Code = @code)
		BEGIN
			INSERT INTO @Codes VALUES (@code);
			SET @codeCount += 1
		END
		SET @code=''
		SET @counter = 0
END
Select * From @Codes 
