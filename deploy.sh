#!/bin/sh -x

#cd terraform_eks_cluster
#terraform apply
#cd ..

kubectl create ns mytest
kubectl create ns nginx-ingress
kubectl create ns monitoring
kubectl apply -n monitoring -f helm/prometheus-operator/crds/
helm install --namespace=monitoring prometheus-operator \
--set grafana.dashboards.default.nginx-ingress.gnetId=9614  \
--set grafana.dashboards.default.nginx-ingress.datasource=Prometheus \
--set grafana.dashboards.default.apache.gnetId=3894 \
--set grafana.dashboards.default.apache.datasource=Prometheus \
--set grafana.dashboardProviders."dashboardproviders\.yaml".apiVersion=1 \
--set grafana.dashboardProviders."dashboardproviders\.yaml".providers[0].name=default \
--set grafana.dashboardProviders."dashboardproviders\.yaml".providers[0].orgId=1 \
--set grafana.dashboardProviders."dashboardproviders\.yaml".providers[0].folder="" \
--set grafana.dashboardProviders."dashboardproviders\.yaml".providers[0].type=file \
--set grafana.dashboardProviders."dashboardproviders\.yaml".providers[0].disableDeletion=false \
--set grafana.dashboardProviders."dashboardproviders\.yaml".providers[0].editable=true \
--set grafana.dashboardProviders."dashboardproviders\.yaml".providers[0].options.path=/var/lib/grafana/dashboards/default \
-f helm/prometheus-operator/prometheus-values.yaml stable/prometheus-operator
helm upgrade --install --namespace nginx-ingress nginx-ingress -f helm/nginx-ingress/nginx_valies.yaml stable/nginx-ingress
helm upgrade --install --namespace=mytest wordpress -f helm/wordpress/wordpress-values.yaml stable/wordpress
