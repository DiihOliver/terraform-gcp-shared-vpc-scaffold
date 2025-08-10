## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_secret_manager"></a> [secret\_manager](#module\_secret\_manager) | ../../../modules/secret-manager | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Region | `string` | n/a | yes |
| <a name="input_secret_manager"></a> [secret\_manager](#input\_secret\_manager) | The details of the Secret Manager. | <pre>map(object({<br>    id=string,<br>    labels=map(string)<br><br>  }))</pre> | <pre>{<br>  "secret_manager": {<br>    "id": "",<br>    "labels": {}<br>  }<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_manager_config"></a> [secret\_manager\_config](#output\_secret\_manager\_config) | n/a |
