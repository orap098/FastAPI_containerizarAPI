---
title: FastAPI
description: A FastAPI server
  - hypercorn
  - python
---

## FastAPI Containerizada com Docker

**FastAPI - Conteinerizada**

Projeto baseado no repositório template oficial do Railway para FastAPI (https://github.com/railwayapp-templates/fastapi). O objetivo principal deste repositório foi criar um `Dockerfile` para containerizar esta API e documentar como construir e executar a imagem.

**Resumo**:
- **Propósito:** Praticar o Build de imagens no docker e demonstrar como empacotar a API FastAPI em um container Docker.
- **Origem:** Template Railway: https://github.com/railwayapp-templates/fastapi

**Arquivos principais**
- [main.py](main.py) : aplicação FastAPI de exemplo.
- [requirements.txt](requirements.txt) : dependências Python (FastAPI, Hypercorn, etc.).
- `Dockerfile` : foco do projeto 


**Como construir a imagem Docker**
1. Criar/adicionar um `Dockerfile` na raiz (exemplo simples):

```dockerfile

FROM python:alpine

WORKDIR /app

COPY ./requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8000

ENTRYPOINT ["hypercorn", "main:app", "--bind", "0.0.0.0:8000"]
```

2. Construir a imagem:

```bash
docker build -t fastapi .
```

3. Executar o container:

```bash
docker run -p 8000:8000 --rm fastapi
```

Agora a API ficará disponível em `http://localhost:8000`.


**Contribuições**
- Pull requests são bem-vindas. Se possuir uma sugestão de melhoria pode abrir uma PR.


**Explicando o Dockerfile**
```dockerfile
FROM python:alpine
````
Aqui você define a imagem base, nesse caso eu usei a python alpine, que seria uma imagem mais leve e consome menos recursos

````dockerfile
WORKDIR /app
`````
Aqui seria onde a aplicação vai ser executada dentro do container, nesse caso dentro do diretório "app"

````dockerfile
COPY ./requirements.txt .
````
Aqui eu estou copiando do meu diretório local para o diretorio de trabalho que definimos na etapa acima o arquivo de requirements.txt

````dockerfile
RUN pip install -r requirements.txt
````
Nessa etapa estou instalando as dependencias da aplicação, no caso do python estou usando o comando "pip", mas isso varia de linguagem para linguagem.

````dockerfile
COPY . .
````
Nessa etapa eu estou copiando o restante da aplicação para o meu diretorio de trabalho para dentro do container. Você pode ter se perguntado o motivo de eu não ter copiado tudo no primeiro "COPY", bem se eu colocasse apenas "COPY . ." no início, qualquer alteração no seu código faria com que o Docker tivesse que copiar tudo e, em seguida, reinstalar todas as dependências sempre que alguma coisa nessa camada for alterada. A separação garante que o passo da instalação de dependências só seja reexecutado quando o arquivo  "requirements.txt" mudar. Assim na hora de buildar a imagem eu economizo tempo sem ter que reinstalar as dependencias a cada alteração.

````dockerfile
EXPOSE 8000
````
Nessa etapa eu estou expondo a porta do container na porta 8000, ou seja onde a aplicação vai escutar dentro do container.

````dockerfile
ENTRYPOINT ["hypercorn", "main:app", "--bind", "0.0.0.0:8000"]
````
Aqui o "ENTRYPOINT",  é a instrução do Dockerfile que define o comando principal que sempre será executado quando o container inicia. Também temos a instrução "CMD", onde a princiapl diferença é que o comando "CMD" ele seria um comando padrão que pode ser substituido, e também podemos usar eles em conjunto.