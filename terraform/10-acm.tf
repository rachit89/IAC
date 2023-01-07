module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = "*.${local.domain_name}"
  zone_id     = local.zone_id

  subject_alternative_names = [
    "*.${local.domain_name}",
    "${local.name}.${local.domain_name}",
    "${local.host_headers}",
  ]

  wait_for_validation = true

  tags = {
    Environment = local.Environment
    Terraform   = local.Terraform
    Owner       = local.Owner
  }
}
