## Hexlet tests and linter status

[![Actions Status](https://github.com/Genusor/devops-for-programmers-project-lvl3/workflows/hexlet-check/badge.svg)](https://github.com/Genusor/devops-for-programmers-project-lvl3/actions)

# Инфраструктура как код

## Установка

### 0.Подготовка

Terraform Cloud
Нужно выставить для каждой переменной параметр sensivity

`ssh_key`  - id ssh ключа используемого на DigitalOcean

`do_token` - ключ api DigitalOcean

`datadog_api_key` - ключ api datadog

`datadog_app_key` - ключ app datadog

Vault
файл с паролем находится в директории
`ansible/pass`

### 1.Инициализация Terraform

`make init`

### 2.Развертывание Terraform

`make apply`

### 3.Установка зависимостей Ansible Galaxy

`make install_req`

### 4.Деплой на удалённые машины

`make deploy`

### Адрес приложения

[https://genusor.xyz/](https://genusor.xyz/)
