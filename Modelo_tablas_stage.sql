CREATE TABLE [Stage Clientes] (
    [Id_Cliente] nvarchar(255),
    [Nombre_Cliente] nvarchar(255),
    [Segmento] nvarchar(255)
);

CREATE TABLE [Stage productos] (
    [Id_Producto] nvarchar(255),
    [Categoría] nvarchar(255),
    [Subcategoría] nvarchar(255),
    [Nombre_Producto] nvarchar(255)
);

CREATE TABLE [Stage ciudad] (
    [Ciudad] nvarchar(255),
    [Estado] nvarchar(255),
    [País] nvarchar(255),
    [Región] nvarchar(255)
);


CREATE TABLE [Stage forma envio] (
    [Id_formaEnvio] nvarchar(255),
    [Descripcion] nvarchar(255)
);

CREATE TABLE [Stage Ventas] (
    [Id_Fila] float,
    [Id_Pedido] nvarchar(255),
    [Fecha_Pedido] datetime,
    [Fecha_Envio] datetime,
    [Forma_Envio] nvarchar(255),
    [Total] float,
    [Cantidad] float,
    [Descuento] float,
    [Ganancia] float,
    [Id_Cliente] nvarchar(255),
    [Ciudad] nvarchar(255),
    [Id_Producto] nvarchar(255)
);