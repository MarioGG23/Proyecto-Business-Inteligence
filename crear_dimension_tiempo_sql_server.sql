-- Script para generacion de la dimension tiempo (Modificar los valores @desde  @hasta)
CREATE TABLE TIEMPO (
	[Tiempo_KEY] int identity(1,1),
	[Fecha] datetime NULL,
	[Dia] int NULL,
	[Mes] int NULL,
	[Semestre] int NULL,
	[agno] int NULL,
	[Dia_semana] int NULL,
	[Semana_del_agno] int NULL,
	[Mes_nombre] varchar(20) NULL,
	[Semestre_Nombre] varchar(2) NULL,
	[Diasemana_Nombre] varchar(10) NULL,
	PRIMARY KEY CLUSTERED (Tiempo_KEY)
)
 
SET LANGUAGE SPANISH
SET DATEFORMAT DMY
 
DECLARE @Fecha AS SMALLDATETIME
DECLARE @semestreNbr AS INT
DECLARE @mes_nombre AS VARCHAR(50)
DECLARE @semestre_Nombre AS VARCHAR(2)
DECLARE @diasemana_Nombre AS VARCHAR(10)
DECLARE @desde AS DATETIME
DECLARE @hasta AS DATETIME
 
SET @desde = '20000101'
SET @hasta = DATEADD(YEAR, 25, GETDATE())
SET @fecha = @desde
WHILE (@fecha < @hasta)
BEGIN
	SET @semestreNbr = CASE WHEN MONTH(@Fecha) < 5 THEN 1 WHEN MONTH(@Fecha) > 8 THEN 3 ELSE 2 END
	SET @mes_nombre = DATENAME(MONTH, @Fecha)
	SET @Semestre_Nombre = 'S' + CONVERT(char(1), @semestreNbr)
	SET @diasemana_Nombre = DATENAME(WEEKDAY, @Fecha)
	INSERT INTO
		 [TIEMPO]
	VALUES(@fecha, 
		DAY(@Fecha), 
		MONTH(@Fecha), 
		@semestreNbr,  
		YEAR(@Fecha), 
		DATEPART(WEEKDAY, @Fecha), 
		DATEPART(WEEK,@Fecha), 
		@mes_nombre, 
		@Semestre_Nombre,  
		@diasemana_Nombre)
	SET @fecha = DATEADD(DAY, 1, @fecha)
END

