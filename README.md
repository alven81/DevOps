# devops

Создайть АDC на локальной машине: $ gcloud auth application-default login.

Для terraform apply необходимо в GCP проект добавить firewall "default-allow-ssh", Apply to all, IP ranges: 0.0.0.0/0, tcp:22.
