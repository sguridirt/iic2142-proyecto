# 2024-2-grupo-61

Render Web Application URL: **[DCCanvas Learning Web](https://mysite-mxg0.onrender.com)**

## Instrucciones

### Para correrlo en local

1. Clonar el repositorio.
2. Instalar gems
```
bundle install
```
4. Crear la base de datos local, esta dependerá de la git branch en la que estás.
```
rails db:create
rails db:schema:load
rails db:seed
```

### Cada vez que trabajes en una **nueva** `git branch`
Si creas una branch para trabajar en algo que no utiliza base de datos, entonces esto lo puedes ignorar.

1. Crear branch
```
git checkout -b [new-branch-name]
```
2. Crear la base de datos específica para esa branch.
```
rails db:create
```
La configuración de la base de datos, `config/database.yml`, especifica que comando creará dos base de datos llamadas `learning_app_development_[new-branch-name]` y `learning_app_test_[new-branch-name]`. No podrás trabajar en esta branch si no creas esta base de datos específica. Rails sabrá cuál usar.

3. Cargar el modelo previo con los datos necesarios.
```
rails db:schema:load
rails db:seed
```
4. Una vez finalizado el uso de la branch, con sus cambios *merged* a la branch `development`, eliminar la base de datos.
```
rails db:drop
```
5. Además, eliminar la branch. Github permite eliminarla por la página. O, se puede hacer:
```
git branch -d [branch-name-to-delete]
```
Una vez _merged_, no utilizar de nuevo la branch, siempre borrarla.


### Cada vez que vayas a programar

1. Actualizar branch en la que se va a trabajar.
```
git checkout [work-branch]
git pull
```
2. Asegurarse de que no hayan cambios en el modelo.
```
rails db:migrate:status
```
Si hay alguna migración que no ha sido corrida, rails no permitirá correr la aplicación. Migramos la base de datos:
```
rails db:migrate
```

3. programar
4. Realizar commits de los cambios, idealmente lo más granular posibles. Commits con cambios pequeños, graduales y funcionales. **Que el mensaje continue la frase "if applied, this commit will ..."**. Por lo tanto, el mensaje comienza con un verbo y debe ser descriptivo. Uno debe poder leer el mensaje 6 meses después y acordarse qué hizo. https://www.freecodecamp.org/news/how-to-write-better-git-commit-messages/
5. Subir los cambios al origen. ```git push```

