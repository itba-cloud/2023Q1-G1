# cloud-inventory-management

## Descripción de módulos utilizados

Se utilizan los módulos `hashicorp/dir/template`, `terraform-aws-modules/vpc/aws` y un módulo propietario de nombre `web-app`.

## Componentes a analizar

- Lambda
- VPC Endpoint
- VPC
- Buckets S3
- DynamoDB
- CloudFront

## Descripción de meta-argumentos

### for_each


### depends_on

### count

### lifecycle

## Descripción de funciones
### template_file
- [Se utiliza para obtener el nombre del archivo sin la extensión del mismo](https://github.com/Khato1319/cloud-inventory-management/blob/main/iac/lambda.tf#LL63C3-L63C44)
### jsonencode
### fileset
### split

