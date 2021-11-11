#1.
#Предварительно выполнить docker-compose иначе постгря не поднята и мы не достучимся до нее:
#docker-compose --version               - для начала проверяем версию
#docker-compose -f compose-env.yaml up  - поднимаем нашу постгрю

#Команда №1 сработает если постгря поднята и в app.yaml ip-шник захардкожен:
#1. docker run -ti --rm koshachek/cats-api:1.0.0
#Вход в swagger-ui.html по http://localhost:8080/swagger-ui.html

#2.
#Команда №2 сработает если постгря поднята и в app.yaml указана переменная окружения:
docker run -ti --rm -e DATASOURCE_HOST=192.168.56.1 -p 8081:8080 koshachek/cats-api:1.0.0
#для mac: docker run -ti --rm -e DATASOURCE_HOST=localhost -p 8081:8080 koshachek/cats-api:1.0.0

#Вход в swagger-ui.html по http://192.168.99.100:8081/swagger-ui.html
#У меня сработало так, потому что использовал Docker Quickstart Terminal; у него свой IP (192.168.99.100)
#в идеале надо стучаться на ip виртуальной машины. http://localhost:8081/swagger-ui.html - когда Quickstart удален

#Можно делать docker push koshachek/cats-api:1.0.0 (кидаем свой образ в репозиторий)