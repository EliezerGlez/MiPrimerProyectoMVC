# Establece la imagen base para el SDK de .NET
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo CSPROJ y restaura las dependencias
COPY *.csproj ./
RUN dotnet restore

# Copia el resto del código fuente
COPY . ./

# Publica la aplicación
RUN dotnet publish -c Release -o /out

# Establece la imagen base para el runtime
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia la aplicación publicada desde la etapa de build
COPY --from=build /out .

# Expone el puerto en el que la aplicación escuchará
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["dotnet", "TuProyecto.dll"]
