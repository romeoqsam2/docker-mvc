FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app
EXPOSE 80

# copy csproj and restore as distinct layers
COPY *.sln .
COPY docker-mvc/*.csproj ./docker-mvc/
RUN dotnet restore

# copy everything else and build app
COPY docker-mvc/. ./docker-mvc/
WORKDIR /app/docker-mvc
RUN dotnet publish -c Release -o out


FROM microsoft/dotnet:2.2-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=build /app/docker-mvc/out ./
ENTRYPOINT ["dotnet", "docker-mvc.dll"]