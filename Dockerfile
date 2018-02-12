FROM microsoft/aspnetcore-build:2.0.5-2.1.4 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:2.0.5-sdk-2.1.4
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "myApp.dll"]