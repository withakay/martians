FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY csharp-martian-kiss/MartianRobot /src/MartianRobot
RUN dotnet publish /src/MartianRobot/src/MartianRobot.Cli/MartianRobot.Cli.csproj -c Release -o /out

FROM mcr.microsoft.com/dotnet/runtime:9.0
WORKDIR /app
COPY --from=build /out/ /app/
ENTRYPOINT ["dotnet","/app/MartianRobot.Cli.dll"]
