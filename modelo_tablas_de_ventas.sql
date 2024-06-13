--- Ejecutar la creacion de la BD ventas (stage)

CREATE DATABASE ventas;

GO
USE ventas;
GO


--- 1) Ejecutar la creacion de la BD
CREATE DATABASE ventasDM;


--- 2) Ejecutar el uso de la BD
GO
USE ventasDM;
GO

---  3) Crear las tablas

CREATE TABLE Dim_producto (
[Pk_producto] int identity(1,1),
[Id_producto] nvarchar(255),
[Nombre] nvarchar(255),
[Categoria] nvarchar (255),
[Subcategoria] nvarchar (255),
PRIMARY KEY CLUSTERED (Pk_producto)
)

CREATE TABLE Dim_ciudad (
[Pk_ciudad] int identity(1,1),
[Ciudad] nvarchar(255),
[Estado] nvarchar(255),
[Pais] nvarchar(255),
[Region] nvarchar(255),
PRIMARY KEY CLUSTERED (Pk_ciudad)
)

CREATE TABLE Dim_cliente (
[Pk_cliente] int identity(1,1),
[Id_cliente] nvarchar (255),
[Nombre_cliente] nvarchar(255),
[Segmento] nvarchar (255),
PRIMARY KEY CLUSTERED (Pk_cliente)
)

CREATE TABLE Dim_tipoEnvio (
[Pk_envio] int identity(1,1),
[Id_tipoEnvio] nvarchar (255),
[Nombre_envio] nvarchar (255),
PRIMARY KEY CLUSTERED (Pk_envio)
)

CREATE TABLE Dim_tiempo (
	[Pk_tiempo] int identity(1,1),
	[Id_fecha] date NOT NULL,
	[Dia] int NULL,
	[Mes] int NULL,
	[Semestre] int NULL,
	[año] int NULL,
	[Dia_semana] int NULL,
	[Semana_del_año] int NULL,
	[Mes_nombre] varchar(20) NULL,
	[Semestre_Nombre] varchar(2) NULL,
	[Dia_semana_Nombre] varchar(10) NULL,
	PRIMARY KEY CLUSTERED (Pk_tiempo)
)

CREATE TABLE Hechos_venta (
    [Pk_producto] int NOT NULL,
    [Pk_ciudad] int NOT NULL,
	[Pk_cliente] int NOT NULL,
    [pk_fecha_venta] int NOT NULL,
	[Pk_envio]  int NOT NULL,
	[Id_pedido] nvarchar(255) NOT NULL,
    [Cantidad_vendida] float,
    [Ganancia_venta] float,
	[Descuento_venta] float,
	[Total_venta] float


CONSTRAINT FK_NOM FOREIGN KEY (Pk_producto) REFERENCES [Dim_producto]([Pk_producto]),
CONSTRAINT FK_ID FOREIGN KEY ([Pk_ciudad]) REFERENCES [Dim_ciudad]([Pk_ciudad]),
CONSTRAINT FK_CL FOREIGN KEY ([Pk_cliente]) REFERENCES [Dim_cliente]([Pk_cliente]),
CONSTRAINT FK_FE FOREIGN KEY ([Pk_envio]) REFERENCES [Dim_tipoEnvio]([Pk_envio]),
CONSTRAINT FK_FN FOREIGN KEY ([pk_fecha_venta]) REFERENCES [Dim_tiempo]([Pk_tiempo])
)


ALTER TABLE [ventasDM].[dbo].[Hechos_venta] ADD PRIMARY KEY ([Pk_producto], [Pk_ciudad],[Pk_cliente],[pk_fecha_venta],[Pk_envio]);

SET LANGUAGE SPANISH
SET DATEFORMAT DMY
 
DECLARE @Fecha AS SMALLDATETIME
DECLARE @semestreNbr AS INT
DECLARE @mes_nombre AS VARCHAR(50)
DECLARE @semestre_Nombre AS VARCHAR(2)
DECLARE @diasemana_Nombre AS VARCHAR(10)
DECLARE @desde AS DATETIME
DECLARE @hasta AS DATETIME
 
SET @desde = '20110101'
SET @hasta = DATEADD(YEAR, 7, GETDATE())
SET @fecha = @desde
WHILE (@fecha < @hasta)
BEGIN
	SET @semestreNbr = CASE WHEN MONTH(@Fecha) < 5 THEN 1 WHEN MONTH(@Fecha) > 8 THEN 3 ELSE 2 END
	SET @mes_nombre = DATENAME(MONTH, @Fecha)
	SET @Semestre_Nombre = 'S' + CONVERT(char(1), @semestreNbr)
	SET @diasemana_Nombre = DATENAME(WEEKDAY, @Fecha)
	INSERT INTO
		 [Dim_tiempo]
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



DELETE FROM [ventasDM].[dbo].[Hechos_venta];
DELETE FROM [ventasDM].[dbo].[Dim_producto];
DELETE FROM [ventasDM].[dbo].[Dim_ciudad];
DELETE FROM [ventasDM].[dbo].[Dim_cliente];
DELETE FROM [ventasDM].[dbo].[Dim_tiempo];
DELETE FROM [ventasDM].[dbo].[Dim_tipoEnvio];

DROP TABLE [ventasDM].[dbo].[Hechos_venta];
DROP TABLE [ventasDM].[dbo].[Dim_producto];
DROP TABLE [ventasDM].[dbo].[Dim_ciudad];
DROP TABLE [ventasDM].[dbo].[Dim_cliente];
DROP TABLE [ventasDM].[dbo].[Dim_tiempo];
DROP TABLE [ventasDM].[dbo].[Dim_tipoEnvio];

--ALTER TABLE [ventas].[dbo].[Hechos venta] ADD CONSTRAINT FK_NOM FOREIGN KEY ([Id_producto]) REFERENCES [Dim Producto]([Id_producto]);
--ALTER TABLE [ventas].[dbo].[Hechos venta] ADD CONSTRAINT FK_ID FOREIGN KEY ([Id_ciudad]) REFERENCES [Dim ciudad]([Id_ciudad]);
--ALTER TABLE [ventas].[dbo].[Hechos venta] ADD CONSTRAINT FK_CL FOREIGN KEY ([Id_cliente]) REFERENCES [Dim cliente]([Id_cliente]);



DROP database [ventasDM];


UPDATE [ventas].[dbo].[Stage Clientes]
    SET Segmento = 'Empresa'  
    WHERE Nombre_cliente = 'Maro Castro' 
GO  


UPDATE [ventasDM].[dbo].[Hechos_venta]
SET 
      [Id_pedido] = [Id_pedido]
      ,[Cantidad_vendida] = [Cantidad_vendida]
      ,[Ganancia_venta] = [Ganancia_venta]
      ,[Descuento_venta] = [Descuento_venta]
      ,[Total_venta] = [Total_venta]
WHERE [Pk_producto] = [Pk_producto]
AND [Pk_ciudad] = [Pk_ciudad] 
AND [Pk_cliente] = [Pk_cliente]
AND [pk_fecha_venta] = [pk_fecha_venta] 
AND [Pk_envio] = [Pk_envio];






UPDATE [ventas].[dbo].[Stage tipoEnvio]
    SET Descripcion = 'Mismo dìa'  
    WHERE Id_formaEnvio = 'AXL-23G' 
GO