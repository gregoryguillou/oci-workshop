#cloud-config

write_files:
  - path: /etc/sysctl.d/98-ip-forward.conf
    content: |
      net.ipv4.ip_forward = 0

runcmd:
  - echo "${workshop_version}" >/etc/oci-workshop.version
  - echo "<html><head><title>#OracleCode</title></head><body>" >"/var/www/html/index.html"
  - curl -L "https://publish.twitter.com/oembed?url=https://twitter.com/twitter/status/${tweet}" | jq -r '.html' >>"/var/www/html/index.html"
  - echo "</body></html>" >>"/var/www/html/index.html"
  - sysctl -p /etc/sysctl.d/98-ip-forward.conf
  - OCI_CLI_AUTH=instance_principal oci os object get --bucket-name ftclnpb3wrytejru.resetlogs.com --file=/etc/secret.json --name=/configuration/secret/secret.json
  - chmod 400 /etc/secret.json