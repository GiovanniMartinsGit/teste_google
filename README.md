# README

O aplicativo de Vendas é uma aplicação web que permite o upload de arquivos de vendas separados por TAB e processa os dados para salvar corretamente em um banco de dados relacional. Além disso, o aplicativo exibe as vendas registradas em uma tabela e calcula a receita bruta total representada pelos dados de vendas.

#Requisitos:

Ruby: 3.2.2
Rails: 7.0.5
PostgreSQL: 10 ou superior


#Instalação:

Clone o repositório do aplicativo de vendas para o seu ambiente local.
No diretório raiz do aplicativo, execute o seguinte comando para instalar as dependências:

bundle install

Configure o banco de dados PostgreSQL no arquivo config/database.yml de acordo com a sua configuração local.

Execute o seguinte comando para criar o banco de dados e executar as migrações:


rails db:create

rails db:migrate

Inicie o servidor Rails com o seguinte comando:


rails server

Acesse o aplicativo no seu navegador em http://localhost:3000.

Configuração em Container: 

#Dockerfile:

FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs


WORKDIR /var/www/teste_google
COPY Gemfile /var/www/teste_google/Gemfile
COPY Gemfile /var/www/teste_google/Gemfile.lock


RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]


#docker-compose.yml: 

version: "3.9"
services:
  teste_google_postgres:
    image: postgres
    platform: linux/amd64
    container_name: teste_google_postgres
    environment:
      POSTGRES_PASSWORD: teste_google
      POSTGRES_HOST_AUTH_METHOD: trust
      HOST: http://192.168.0.107:3000
    volumes:
      - ./tmp/postgres:/var/lib/postgresql/data:z

  teste_google:
    build: .
    platform: linux/amd64
    container_name: teste_google
    command: bash -c "bundle exec rails s -p 3000 -b '0.0.0.0'"
    volumes:
      - ./:/var/www/teste_google:z
    ports:
      - "3000:3000"
    depends_on:
      - teste_google_postgres

#COMANDOS PARA O CONTAINER

 docker exec -it <NOME_DO_CONTAINER>
 docker compose build
 docker compose run --rm teste_google bundle install
 docker compose run --rm teste_google rake db:drop
 docker compose run --rm teste_google rake db:create
 docker compose run --rm teste_google rake db:migrate
 docker compose run --rm teste_google rake seed:migrate
 docker compose run  --rm -p 3000:3000 teste_google rails s -b 0.0.0.0
 docker compose run  --rm teste_google rails c

Uso:

#Página Inicial:


A página inicial exibe todas as vendas registradas em uma tabela.

A receita bruta total é exibida abaixo da tabela.

Upload de Arquivo:

Clique no link "New Sale" na página inicial para acessar a página de upload de arquivo.

Selecione um arquivo de vendas separado por TAB no campo fornecido.

Clique no botão "Enviar" para enviar o arquivo e processar os dados.

Após o processamento bem-sucedido, você será redirecionado para a página inicial.


#Funcionalidades:

Upload de Arquivo:

O aplicativo aceita uploads de arquivos separados por TAB.

O arquivo deve ter as seguintes colunas na ordem: purchaser name, item description, item price, purchase count, merchant address e merchant name.

O arquivo deve conter uma linha de cabeçalho.

Os dados do arquivo são normalizados e salvos corretamente no banco de dados.


#Exibição de Vendas:

As vendas registradas são exibidas em uma tabela na página inicial.

Cada linha da tabela representa uma venda e exibe as seguintes informações: nome do comprador, descrição do item, preço do item, quantidade de compras, endereço do comerciante e nome do comerciante.

Cálculo da Receita Bruta Total:

A receita bruta total é calculada somando o preço do item multiplicado pelo número de compras de todas as vendas registradas.

A receita bruta total é exibida na página inicial abaixo da tabela de vendas.


#Considerações Finais:

O aplicativo de Vendas é uma solução simples e eficiente para processar e exibir dados de vendas a partir de arquivos separados por TAB. Ele automatiza o processo de importação de dados e fornece uma visão clara da receita bruta total. Sinta-se à vontade 

para explorar e adaptar o código-fonte conforme suas necessidades específicas.
