# Base image
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copy project files and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the entire project code
COPY . ./

# Build the project
RUN dotnet build -c Release -o out

# Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .


# Set the entry point
ENTRYPOINT ["dotnet", "project.dll"]
