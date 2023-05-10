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
- Se utiliza para poder definir un local de las variables y definir los [índices](https://github.com/Khato1319/cloud-inventory-management/blob/main/iac/database.tf#L26) y [atributos](https://github.com/Khato1319/cloud-inventory-management/blob/main/iac/database.tf#L26) de la tabla a partir del mismo sin tener que repetir los nombres.
- 
### depends_on
- [Se utiliza para obtener el nombre del archivo sin la extensión del mismo](https://github.com/Khato1319/cloud-inventory-management/blob/main/iac/lambda.tf#LL63C3-L63C44)
### count
- [Se utiliza para obtener el nombre del archivo sin la extensión del mismo](https://github.com/Khato1319/cloud-inventory-management/blob/main/iac/lambda.tf#LL63C3-L63C44)
### lifecycle
- [Se utiliza para obtener el nombre del archivo sin la extensión del mismo](https://github.com/Khato1319/cloud-inventory-management/blob/main/iac/lambda.tf#LL63C3-L63C44)
## Descripción de funciones
### template_file
- [Se utiliza para obtener el nombre del archivo sin la extensión del mismo](https://github.com/Khato1319/cloud-inventory-management/blob/main/iac/lambda.tf#LL63C3-L63C44)
### jsonencode
- [Se utiliza para obtener el nombre del archivo sin la extensión del mismo](https://github.com/Khato1319/cloud-inventory-management/blob/main/iac/lambda.tf#LL63C3-L63C44)
### fileset
- [Se utiliza para obtener el nombre del archivo sin la extensión del mismo](https://github.com/Khato1319/cloud-inventory-management/blob/main/iac/lambda.tf#LL63C3-L63C44)
### split
- [Se utiliza para obtener el nombre del archivo sin la extensión del mismo](https://github.com/Khato1319/cloud-inventory-management/blob/main/iac/lambda.tf#LL63C3-L63C44)

