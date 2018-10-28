{
  "AWSEBDockerrunVersion": "1",
  "Image": {
    "Name": "${docker_image}:${docker_tag}",
    "Update": "true"
  },
  "Ports": [{
        "ContainerPort": "9999",
        "HostPort": "80"

    }],
    "Logging": "/var/log/nginx"
}
