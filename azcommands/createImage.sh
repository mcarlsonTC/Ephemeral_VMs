az image create \
  --name Ephemeral_golden \
  --resource-group Ephemeral_VMs \
  --source burstable2 \
  --hyper-v-generation V2 \
  --os-type Windows

  # rename '--source' to VM name if creating a fresh VM