# terraform-test

## Requirements
- terraform(>= 0.12.24)
- kubectl

## Terraform workspace
- https://app.terraform.io/app/owen/workspaces/terraform-test/runs

### workspace set up(aws configure)
- workspace > Variables > `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` 변경
- 상단 오른쪽 `Queue plan` 클릭

### Terraform resources
- EKS
- VPC(subnets, igw, ngw)
- Worker node(+ auto scaling group)
- Kubernetes
- Helm(jenkins)

## Use to kubectl
### set kube config
```
aws eks --region ap-northeast-2 --profile <your profile> update-kubeconfig --name eks-cluster
```
### Run k8s objects
```
cd modules/kubernetes/rails-realworld-example
kubectl apply -f .
```
해당 부분은 Terraform으로 iaC 되지 않았습니다. terraform k8s deployment resource 등을 보는 데 따로 template file(manifest)를 지원하고 있지 않아 시간이 오래 소요될 것 같아 부득이하게 manifest로 실행을 안내드립니다.
### get jenkins loadbalancer external ip
```
kubectl get svc --namespace kube-system jenkins --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}"
```
### get jenkins admin password
```
printf $(kubectl get secret --namespace kube-system jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
```

## Use to Jenkinsfile
```
mv ./Jenkinsfile <fork-rails-realworld-example-repo>/Jenkinsfile
```
Pipeline job or Blue ocean pipeline에서 github 연결 후 pipeline 실행