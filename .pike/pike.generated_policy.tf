
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "compute.firewalls.create",
    "compute.firewalls.delete",
    "compute.firewalls.get",
    "compute.firewalls.update",
    "compute.instanceTemplates.create",
    "compute.instanceTemplates.delete",
    "compute.instanceTemplates.get",
    "compute.networks.get",
    "compute.networks.updatePolicy",
    "compute.regionInstanceGroupManagers.create",
    "compute.regionInstanceGroupManagers.delete",
    "compute.regionInstanceGroupManagers.get",
    "compute.regionInstanceGroupManagers.update"
  ]
}
