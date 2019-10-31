# HTTP Load Balancer with Cloud Armor

Create a Scaffold

```    ```

## Create firewall rule

Which VPC to attach the firewall? Add **data.google*compute*network.default.tf**

```terraform
data google_compute_network default {
    name = var.network
}  
```

and variables, outputs and values.

```shell
$ terrafom apply  Initializing the backend..
    Initializing provider plugins..
    Terraform has been successfully initialized!
    You may now begin working with Terraform. Try running "terraform plan" to see  any changes that are required for your infrastructure. All Terraform commands  should now work.    If you ever set or change modules or backend configuration for Terraform,  rerun this command to reinitialize your working directory. If you forget, other  commands will detect it and remind you to do so if necessary.  data.google_compute_network.default: Refreshing state...
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

[After](https://google.qwiklabs.com/focuses/1232?catalog*rank=%7B%22rank%22%3A39%2C%22num*filters%22%3A3%2C%22has*search%22%3Afalse%7D&parent=catalog)
