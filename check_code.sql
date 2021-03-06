USE [Codes]
GO
/****** Object:  StoredProcedure [dbo].[check_code]    Script Date: 13.01.2022 12:55:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[check_code]
@Code varchar(8),
@IsValid int output
as
begin
DECLARE @counter int = 1 ;
DECLARE @ValidChar NVARCHAR(1000) = 'ACDEFGHKLMNPRTXYZ234579';
	IF(LEN(@Code)!=8)
		Set @IsValid =0
	ELSE
	BEGIN
		Set @IsValid =1
			WHILE(@counter<=8)
			BEGIN
				DECLARE @char CHAR = SUBSTRING(@Code,@counter,1)
				DECLARE @nextChar CHAR = SUBSTRING(@Code,@counter+1,1)
				IF(CHARINDEX(@char,@ValidChar) = 0 OR @char = @nextChar OR (SELECT CHAR(ASCII(@char)+1)) = @nextChar)
					Set @IsValid =0
				SET @counter += 1
			END
		
	END
	RETURN @IsValid
End