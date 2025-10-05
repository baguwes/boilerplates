# Defectdojo
docker logs defectdojo-initializer | grep "Admin password:"  
or  
docker exec -it defectdojo-django /bin/bash -c 'python manage.py createsuperuser'  