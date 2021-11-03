How to run application (for zero):

1. Сначала надо запустить Postgres:

    
    docker-compose --version  
    docker-compose -f compose-env.yaml up


2. После того как Postgres поднялся, поднимаем наш образ:

   
    docker run -ti --rm -e DATASOURCE_HOST=192.168.56.1 -p 8081:8080 koshachek/cats-api:1.0.0


3. Проверяем: запускаем наше приложение в нормальном режиме (Shift + F10) и переходим по ссылке:

    
    http://localhost:8081/swagger-ui.html


4. Проводим установку kubectl и kind



5. Наше приложение сейчас должно быть остановлено. Но Postgres работает в фоне. Теперь займемся настройкой кластера.

    Выполним команду:

    
    kind create cluster --config kind-config.yaml 


Наш кластер успешно создан и запущен. Сейчас установим ingress выполнив команду:

   
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

Обязательно проверяем, что ingress "живой" выполнив команду: 

    kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=90s

дожидаемся в терминале ответа: "pod/ingress-nginx-controller-ddf6c9bfc-pqsnr condition met"

6. После этого начинаем deploy нашего приложения в Kubernates:

   Выполнить команду:

   
      kubectl apply -f k8s\deployment.yaml
 

   Проверим состояние наших Pods командой:
   
      kubectl get pods

   *в случае необходимости логи можно посмотреть командой:
   
      kubectl logs <pod_name>
   
   *удалить все Pods можно командой:
   
      kubectl delete pods --all

7. Убедимся, что все запущены (вышеописанной командой, без ключа -w) и пробросим порты нашего приложения (*обязательно):

   
      kubectl port-forward <pod_name> 8899:8080

8. Откроем web-browser и перейдем по адресу: 


      http://localhost:8899/cats-api/swagger-ui.html

получить всех котов можно по адресу:

      http://localhost:8080/cats-api/cats

Наше приложение успешно работает в кластере.

9. Сначала проверим nginx, если ответ 404 - мы на верном пути. 

      
   http://localhost:8888/

Если нет - применяем ingress:

      kubectl apply -f k8s\ingress.yaml


Теперь применим наш сервис командой:

      kubectl apply -f k8s\service.yaml

Убедимся что он поднят:

      kubectl get service

Снова применим ingress:

      kubectl apply -f k8s\ingress.yaml

Проходим по адресу, получаем котов:
   
      http://localhost:8888/cats-api/cats



