FROM azul/zulu-openjdk:11

# 깃에서 가져온 소스 코드 이미지 내부 경로로 복사
COPY . /home/A605

# 이미지 내부 작업 공간 설정
WORKDIR  /home/A605

# gradle 빌드
RUN chmod +x gradlew
RUN ./gradlew clean build

RUN mv ./build/libs/ninuco-0.0.1-SNAPSHOT.jar ./ninucco.jar

CMD ["nohup", "java", "-jar", "ninucco.jar", "&"]