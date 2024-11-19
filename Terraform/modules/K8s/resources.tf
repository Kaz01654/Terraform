resource "kubernetes_namespace" "example" {
  metadata {
    name = "example-namespace"
  }
}

resource "kubernetes_deployment" "example" {
  depends_on = [ kubernetes_namespace.example ]

  metadata {
    name = "example-deploy"
    namespace = "example-namespace"
    labels = {
      app = "example-app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "example-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "example-app"
        }
      }

      spec {
        container {
          image = "nginx:lastest"
          name = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "example" {
  depends_on = [ kubernetes_namespace.example ]

  metadata {
    name = "example-service"
    namespace = "example-namespace"
  }

  spec {
    selector = {
      app = "example-app"
    }

    port {
      port = 80
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress" "example_ingress" {
  depends_on = [ kubernetes_namespace.example, kubernetes_deployment.example ]

  metadata {
    name = "example-ingress"
    namespace = "example-namespace"
  }

  spec {
    backend {
      service_name = "MyApp1"
      service_port = 8080
    }

    rule {
      http {
        path {
          backend {
            service_name = "MyApp1"
            service_port = 8080
          }

          path = "/app1/*"
        }

        path {
          backend {
            service_name = "MyApp2"
            service_port = 8080
          }

          path = "/app2/*"
        }
      }
    }

    tls {
      secret_name = "tls-secret"
    }
  }
}