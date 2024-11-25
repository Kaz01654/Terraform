resource "helm_release" "sonar" {
  name = "sonarqube"
  repository = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart = "sonarqube"
  namespace = "sonarqube"
  create_namespace = "true"

  set {
    name = "service.type"
    value = "LoadBalancer"
  }
}