resource "dns_a_record_set" "demo" {
  zone = "demodomain.com."
  name = "demo"
  addresses = [ 
    "192.168.0.3"
   ]
   ttl = 300
}