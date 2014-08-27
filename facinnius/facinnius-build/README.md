Projeto prime-ejb-crud-build
=====================

Define o projeto principal (parent) da aplicação demo Primefaces e EJB.

No pom.xml desse projeto é possível verificar a definição dos módulos (sub-projetos), configuração dos repositórios e as dependências globais.

A proposta desse projeto é centralizar o build. Por exemplo o comando mvn package aciona a geração do módulo core (model) e web.
