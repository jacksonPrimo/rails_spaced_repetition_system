# Como executar o projeto

## Pré-requisitos

- Ruby 3.2.2
- Rails 7.1.6
- PostgreSQL 15
- Redis 7
- Node.js 20
- Tailwind CSS 4

## Instalação

```bash
# Instalar dependências do Ruby
bundle install

# Instalar dependências do Node.js
npm install

# Criar o banco de dados
rails db:create

# Migrar o banco de dados
rails db:migrate

# Criar um usuário de teste
rails console
User.create!(email: "[EMAIL_ADDRESS]", password: "password", password_confirmation: "password")
exit
```

## Execução

```bash
# Iniciar o servidor
rails server

# Iniciar o servidor com o foreman
foreman start
```

## Testes

```bash
# Executar os testes
rails test
```

## Deploy

```bash
# Deploy para o Heroku
rails heroku:push
```

## Envs

```env
RAILS_ENV=development
DB_HOST=localhost
DB_PORT=5432
DB_USER=myuser
DB_PASSWORD=mypassword
SMTP_ADDRESS=smtp.gmail.com
SMTP_PORT=587
SMTP_DOMAIN=gmail.com
SMTP_USERNAME=your-email@example.com
SMTP_PASSWORD=your-password
```