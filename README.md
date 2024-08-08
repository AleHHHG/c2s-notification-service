
# C2S-NotificationService

Responsavel por enviar notificação para o sistema principal.

Se comunica com o serviço principal e com o serviço de scraping via RabbitMQ.

## Rodando localmente

Alterar o arquivo de configuração rabbitmq.yml(Enviada juntamente com o teste) e database.yml

Execute as migrações

```bash
  rails db:create
  rails db:migrate
```

Execute a aplicação

```bash
  rake sneakers:run
```
