Demo Primefaces e EJB em módulos
=====================

Modularizamos o projeto web, demonstração das tecnologias: Primefaces, JSF2, EJB 3 e JPA. A idéia é apresentar uma outra maneira de organizar o projeto, utilizando a funcionalidade de multi-módulos do Maven para gerenciamento do build.

Organização do projeto foi divida em três módulos (diretórios):

* prime-ejb-crud-build: Projeto principal, com objetivo de centralizar o build dos outros 2 módulos (sub-projetos).

* prime-ejb-crud-model: Módulo core da aplicação. Nele definimos a Mercadoria, a entidade do projeto. Essa classe é mapeada com as anotações da JPA. Nesse modulo definimos o componente EJB3 (Session Bean), responsável por acionar o mecanismo de persistência.

* prime-ejb-crud-web: Módulo web da aplicação. As páginas JSF e o managed bean ficam contidos nesse projeto. O módulo web depende do módulo core (model)!

