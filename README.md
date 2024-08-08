
# C2S-NotificationService

Responsavel por enviar notificação para o sistema principal.

Se comunica com o serviço principal e com o serviço de scraping via RabbitMQ.

## Rodando localmente

Build o container

```bash
  docker compose build
```

Execute as migrações

```bash
  docker compose run web rake db:create
  docker compose run web rake db:migrate
```

Execute o container

```bash
  docker compose up
```

Execute os teste unitários

```bash
  docker compose run web bash -c "RAILS_ENV=test bundle exec rspec"
```
