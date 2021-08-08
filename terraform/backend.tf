terraform {
  backend "remote" {
    organization = "genusor_industry"

    workspaces {
      name = "devops-for-programmers-project-lvl3"
    }
  }
}

