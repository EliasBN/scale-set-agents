az group create -n "agent-test" -l "norwayeast"

az vmss create \
--name "scale-set-test-vmss" \
--resource-group "agent-test" \
--image UbuntuLTS \
--vm-sku Standard_B1s \
--storage-sku StandardSSD_LRS \
--authentication-type ssh \
--instance-count 0 \
--disable-overprovision \
--upgrade-policy-mode manual \
--single-placement-group false \
--platform-fault-domain-count 1 \
--load-balancer "" \
--generate-ssh-keys