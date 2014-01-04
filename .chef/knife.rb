# Logging.
log_level :debug
log_location STDOUT

# Chef server configuration.
chef_server_url "http://172.16.1.2:4000"
client_key ".chef/client.pem"
node_name "thinkpad"
validation_client_name "chef-validator"
validation_key "chef-validator.pem"
