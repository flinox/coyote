## Landoop Coyote para realizar testes kafka

Coyote is a test agent. It uses a yml configuration file with commands to setup (stdin, env vars, etc) and run. It checks the output for errors and may further search for the presence or absence of specific regular expressions. Finally it creates a html report with the tests, their outputs and some statistics.

<a href="https://github.com/Landoop/coyote" target="_blank">Landoop Coyote</a>


## Escrever o teste

Criar um arquivo .yaml com o conteúdo e os comandos para o teste, você pode criar blocos de teste como o exemplo abaixo:

```
- name: Bloco de testes do Kafka Brokers
  skip: _kafka_brokers_
  entries:
    # BASIC / PERFORMANCE
    - name: Criacao do topico
      command: kafka-topics --zookeeper zookeeper:2181 --topic kapacitor-test --partition 3 --replication-factor 3 --create
    - name: Listar os topicos
      command: kafka-topics --zookeeper zookeeper:2181 --list
    - name: Teste de performance
      command: |
        kafka-producer-perf-test --topic kapacitor-test --throughput 100000 --record-size 1000 --num-records 2000000
                                 --producer-props bootstrap.servers="kafka:9092"
      timeout: 90s
```

Você pode fazer mais de um arquivo yaml de teste.

O Arquivo yaml gerado deve ser salvo na pasta /tests.

## Executar os testes

Para executar os testes, simplesmente rode:

```
docker-compose up
```

### Mais informações

Para executar os testes foi necessário criar uma imagem com o "kafka client" e outras ferramentas necessárias.
o Fonte é o arquivo /testes/coyote/Dockerfile

A pasta /testes/coyote/webserver contém um simples webserver em go para que seja possível abrir o .html gerado pelo landoop coyote.

O /testes/coyote/docker-compose.yml simplesmente constroi o Dockerfile, mapeia a pasta dos testes para o container, baixa o pacote do coyoto para golang, roda o webserver em go e executa os testes pelo coyote com o comando:

```
coyote -c . -out kapacitor_teste.html
```

Onde -c . executará todos os yml files contidos na pasta
Onde -out kapacitor_teste.html é o arquivo de saída, se não for informado ele gera um arquivo coyote.html

## Visualizar os resultados dos testes

Para visualizar os resultados, acesse http://localhost:8000/kapacitor_teste.html
