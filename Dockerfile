FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
# COPY build/. ./build/
COPY NetPingPong/NetPingPong.csproj ./src/NetPingPong/

ARG NUGET_SOURCE=http://nexus.esphere.local:8081/repository/nuget-group/;https://api.nuget.org/v3/index.json
RUN dotnet restore --source $NUGET_SOURCE src/NetPingPong/NetPingPong.csproj

# copy everything else and build app
COPY NetPingPong/. ./src/NetPingPong/

WORKDIR /app/src/NetPingPong
RUN dotnet publish --source $NUGET_SOURCE -c Release -o ../../out


FROM microsoft/dotnet:2.2.0-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "NetPingPong.dll"]