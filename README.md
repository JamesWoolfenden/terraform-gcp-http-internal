# HTTP Load Balancer with Cloud Armor

## Create a Scaffold

```bash tab="*nix*"
scaffold terraform-gcp-http-internal GCP
```

```powershell tab="windows"
$ scaffold -name terraform-gcp-http-internal -branch GCP
Cloning into 'terraform-gcp-http-internal'...
remote: Enumerating objects: 17, done.
remote: Counting objects: 100% (17/17), done.
remote: Compressing objects: 100% (12/12), done.
Receiving objects: 100% (17/17), 4.31 KiB | 2.16 MiB/s, done.
remote: Total 17 (delta 0), reused 14 (delta 0), pack-reused 0
pre-commit installed at .git\hooks\pre-commit
Trim Trailing Whitespace.................................................Passed
Fix End of Files.........................................................Passed
Check Yaml...............................................................Passed
Check for added large files..............................................Passed
Check for merge conflicts................................................Passed
Trim Trailing Whitespace.................................................Passed
No-tabs checker..........................................................Passed
terraform_fmt............................................................Passed
Detect Private Key.......................................................Passed
Shell Syntax Check.......................................................Passed
markdownlint.............................................................Passed
yamllint.................................................................Passed
Terraform docs...........................................................Passed
prettier.................................................................Passed
[master (root-commit) 2ef21c9] Initial Draft
 14 files changed, 358 insertions(+)
 create mode 100644 .dependabot/config.yml
 create mode 100644 .gitattributes
 create mode 100644 .gitignore
 create mode 100644 .markdownlint.json
 create mode 100644 .pre-commit-config.yaml
 create mode 100644 Makefile
 create mode 100644 README.md
 create mode 100644 main.auto.tfvars
 create mode 100644 main.tf
 create mode 100644 outputs.tf
 create mode 100644 provider.gcp.tf
 create mode 100644 validate.ps1
 create mode 100644 validate.sh
 create mode 100644 variables.tf
```

## Create firewall rule

Which VPC to attach the firewall? Add **data.google*compute*network.default.tf**

```terraform
data google_compute_network default {
    name = var.network
}  
```

and variables, outputs and values.

```shell
$ terrafom apply
Initializing the backend..
Initializing provider plugins..
Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see  any changes that are required for your infrastructure. All Terraform commands  should now work.
If you ever set or change modules or backend configuration for Terraform,  rerun this command to reinitialize your working directory. If you forget, other  commands will detect it and remind you to do so if necessary.
data.google_compute_network.default: Refreshing state...
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
Outputs:
    description = Default network for the project
    gateway_ipv4 =  
    self_link = https://www.googleapis.com/compute/v1/projects/examplea/global/networks/default 
```

Then add the rule **google_compute_firewall.default.tf**:

```terraform
resource "google*compute*firewall" "default" {
  name    = "default-allow-http"
  network = google*compute*network.default.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source*tags = ["http-server"]
}
```

[After](https://google.qwiklabs.com/focuses/1232?catalog*rank=%7B%22rank%22%3A39%2C%22num*filters%22%3A3%2C%22has*search%22%3Afalse%7D&parent=catalog)�