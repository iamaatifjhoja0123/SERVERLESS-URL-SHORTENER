# Lightweight Nginx image 
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

# Port 80 
EXPOSE 80