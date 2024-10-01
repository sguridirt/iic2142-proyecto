# 2024-2-grupo-61

Render Web Application URL: **[DCCanvas Learning Web](https://mysite-2m84.onrender.com)**

## Instrucciones

### Para correrlo en local

1. Clonar el repositorio.
2. Crear la base de datos
```
rails db:create
rails db:schema:load
rails db:seed
```

### Cada vez que se vaya a programar

1. Actualizar branch en la que se va a trabajar.
```
git checkout [branch]
git pull
```
2. Asegurarse de que no hayan cambios en el modelo.
```
rails db:migrate:status
```
Si hay alguna migración que no ha sido corrida,
```
rails db:migrate
```
3. programar
4. Realizar commits de los cambios, idealmente lo más granular posibles. Commits con cambios pequeños, graduales y funcionales. **Que el mensaje continue la frase "if applied, this commit will ..."**. Por lo tanto, el mensaje comienza con un verbo y debe ser descriptivo. Uno debe poder leer el mensaje 6 meses después y acordarse qué hizo. https://www.freecodecamp.org/news/how-to-write-better-git-commit-messages/
5. Subir los cambios al origen. ```git push```
