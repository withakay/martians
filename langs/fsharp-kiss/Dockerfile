FROM mcr.microsoft.com/dotnet/sdk:9.0
WORKDIR /app
COPY langs/fsharp-kiss/Program.fsx /app/Program.fsx
ENTRYPOINT ["dotnet","fsi","/app/Program.fsx"]
