terraform {
  required_providers {
    aci = {
      source  = "ciscodevnet/aci"
      version = "~> 0.5.4"
    }
  }
}
# var is from variables.tf in the same directory

provider "aci" {
  username = var.aciUser
  password = var.aciPassword
  insecure = true
  url      = var.aciUrl
}

resource "aci_tenant" "tenant_name" {
  name        = var.tenantName
  description = "created by terraform"
}

resource "aci_vrf" "new_vrf01" {
  tenant_dn = aci_tenant.tenant_name.id
  name      = var.vrf
}

data "aci_vrf" "sals" {

  tenant_dn = aci_tenant.tenant_name.id
  name      = "SalsVRF"

}

resource "aci_vrf" "vrf2" {
  tenant_dn          = aci_tenant.tenant_name.id
  name               = var.vrf
  bd_enforced_enable = "yes"


}
