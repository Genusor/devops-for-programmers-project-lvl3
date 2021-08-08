 
resource "digitalocean_droplet" "apps" {
    count = 2
    image = "docker-20-04"
    name = "devops-for-programmers-project-lvl3-${count.index}"
    region = "ams3"
    size = "s-1vcpu-1gb"
    ssh_keys = [var.ssh_key]
}

resource "digitalocean_loadbalancer" "public" {
  name   = "devops-for-programmers-project-lvl3-lb"
  region = "ams3"

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 3000
    target_protocol = "http"

    certificate_name = digitalocean_certificate.cert.name
  }

  healthcheck {
    port     = 3000
    protocol = "http"
    path = "/"
  }

  droplet_ids = digitalocean_droplet.apps.*.id
}


resource "digitalocean_domain" "domain" {
  name = "genusor.xyz"
  ip_address = digitalocean_loadbalancer.public.ip
}

resource "digitalocean_certificate" "cert" {
  name    = "domain-certificate"
  type    = "lets_encrypt"
  domains = ["genusor.xyz"]
}

resource "digitalocean_database_cluster" "postgres" {
  name       = "postgres-cluster"
  engine     = "pg"
  version    = "13"
  size       = "db-s-1vcpu-1gb"
  region     = "ams3"
  node_count = 1
}

resource "digitalocean_database_firewall" "trusted_web_sources" {
  cluster_id = digitalocean_database_cluster.postgres.id

  dynamic "rule" {
    for_each = digitalocean_droplet.apps
    content {
      type  = "droplet"
      value = rule.value["id"]
    }
  }
}



resource "digitalocean_database_db" "database" {
  cluster_id = digitalocean_database_cluster.postgres.id
  name       = "redmine"
}

resource "datadog_monitor" "healthcheck" {
  name    = "monitor health {{ host.name }}"
  type    = "service check"
  message = "@genusor@gmail.com"
  query   = "\"http.can_connect\".over(\"instance:app_health_check\",\"url:http://localhost:3000\").by(\"host\",\"instance\",\"url\").last(2).count_by_status()"
}

output "webserver_ips" {
  value = digitalocean_droplet.apps.*.ipv4_address
}

