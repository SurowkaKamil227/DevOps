# Użyj obrazu z Maven do budowy projektu
FROM maven:3.8.8-eclipse-temurin-17 AS build
WORKDIR /app

# Kopiuj pliki projektu do kontenera
COPY . .

# Buduj projekt z użyciem Maven
RUN mvn clean package -DskipTests

# Wybierz minimalny obraz do uruchomienia aplikacji
FROM eclipse-temurin:17-jdk-alpine
WORKDIR /app

# Skopiuj skompilowany plik JAR z etapu budowy
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Otwórz port, na którym aplikacja będzie działać (domyślnie Spring Boot używa portu 8080)
EXPOSE 8080

# Uruchom aplikację
ENTRYPOINT ["java", "-jar", "app.jar"]
