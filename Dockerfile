FROM amazoncorretto:17-alpine3.18
WORKDIR /app
ADD https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.0/deploy/static/provider/cloud/deploy.yaml /app/
CMD [ "echo", "hello-neuvector" ]
