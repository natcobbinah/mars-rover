FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR "/CSharp xUnit starter"

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR "/CSharp xUnit starter"
COPY --from=build "/CSharp xUnit starter/out" .
ENTRYPOINT ["dotnet", "CSharp xUnit starter.dll"]