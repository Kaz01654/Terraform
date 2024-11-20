resource "helm_release" "argocd" {
    name = "argocd"
    chart = "argo-cd"
    repository = "https://argoproj.github.io/argo-helm"
    version = "7.4.5"
    namespace = "argocd"
    create_namespace = "true"

    values = [
        <<EOF
        server:
          service:
            type: ClusterIP
        EOF
    ]
}