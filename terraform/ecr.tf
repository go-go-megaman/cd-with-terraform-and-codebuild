data "docker_registry_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_image" "nginx" {
  name = data.docker_registry_image.nginx.name
}

resource "aws_ecr_repository" "nginx" {
  name                 = "nginx"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "null_resource" "pushing_container_image_to_ecr" {
  provisioner "local-exec" {
    command = "aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com"
  }

  provisioner "local-exec" {
    command = "docker tag ${docker_image.nginx.name} ${aws_ecr_repository.nginx.repository_url}"
  }

  provisioner "local-exec" {
    command = "docker push ${aws_ecr_repository.nginx.repository_url}"
  }

  depends_on = [
    docker_image.nginx,
    aws_ecr_repository.nginx
  ]
}
