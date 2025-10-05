# 1) 빌드 스테이지
FROM maven:3.9-eclipse-temurin-11 AS build
WORKDIR /app

# pom.xml을 먼저 복사하여 의존성 레이어를 분리합니다.
COPY pom.xml .

# 의존성을 먼저 다운로드합니다. pom.xml이 변경되지 않으면 이 레이어는 캐시됩니다.
RUN mvn dependency:go-offline

# 소스 코드를 복사합니다.
COPY src ./src

# 애플리케이션을 패키징합니다. 소스 코드 변경 시 여기부터 다시 실행됩니다.
RUN mvn -DskipTests package

# 2) 런타임
FROM eclipse-temurin:11-jre
WORKDIR /
COPY --from=build /app/target/ROOT.war /app.war
ENTRYPOINT ["java","-jar","/app.war"]