FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY ["docker-mvc.csproj", "docker-mvc/"]
RUN dotnet restore "docker-mvc/docker-mvc.csproj"
COPY . .
WORKDIR "/src/docker-mvc"
RUN dotnet build "docker-mvc.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "docker-mvc.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "docker-mvc.dll"]