### Gitlab settings
external_url 'https://gitlab.your-domain.com'
letsencrypt['enable'] = false
nginx['listen_port'] = 80
nginx['listen_https'] = false

gitlab_rails['gitlab_shell_ssh_port'] = 22
gitlab_rails['enable'] = true # do not disable unless explicitly told to do so in docs
gitlab_rails['gitlab_ssh_host'] = 'gitlab.your-domain.com'
gitlab_rails['gitlab_ssh_user'] = ''
gitlab_rails['time_zone'] = 'Asia/Jakarta'


### Gitlab Prometheus
prometheus['enable'] = false
prometheus_monitoring['enable'] = false
gitlab_exporter['enable'] = false
node_exporter['enable'] = false
redis_exporter['enable'] = false
postgres_exporter['enable'] = false
pgbouncer_exporter['enable'] = false

### Gitlab Embedded Database
postgresql['enable'] = false
redis['enable'] = false

logrotate['enable'] = true

### Postgres settings
gitlab_rails['auto_migrate'] = false # First boot must true

gitlab_rails['db_adapter'] = "postgresql"
gitlab_rails['db_encoding'] = "unicode"
gitlab_rails['db_collation'] = nil
gitlab_rails['db_database'] = "gitlab"
gitlab_rails['db_username'] = "gitlab"
gitlab_rails['db_password'] = "postgres-password"
gitlab_rails['db_host'] = "gitlab-postgres"
gitlab_rails['db_port'] = "5432"
gitlab_rails['db_socket'] = nil
gitlab_rails['db_sslmode'] = nil
gitlab_rails['db_sslcompression'] = 0
gitlab_rails['db_sslrootcert'] = nil
gitlab_rails['db_sslcert'] = nil
gitlab_rails['db_sslkey'] = nil
gitlab_rails['db_prepared_statements'] = false
gitlab_rails['db_statements_limit'] = 1000
gitlab_rails['db_connect_timeout'] = nil
gitlab_rails['db_keepalives'] = nil
gitlab_rails['db_keepalives_idle'] = nil
gitlab_rails['db_keepalives_interval'] = nil
gitlab_rails['db_keepalives_count'] = nil
gitlab_rails['db_tcp_user_timeout'] = nil
gitlab_rails['db_application_name'] = nil
gitlab_rails['db_database_tasks'] = true

### GitLab Redis settings
gitlab_rails['redis_enable_client'] = true
gitlab_rails['redis_host'] = "gitlab-redis"
gitlab_rails['redis_port'] = 6379
# gitlab_rails['redis_ssl'] = $REDIS_SSL
# gitlab_rails['redis_password'] = $REDIS_PASSWORD
gitlab_rails['redis_database'] = 0
# gitlab_rails['redis_tls_ca_cert_dir'] = '/opt/gitlab/embedded/ssl/certs/'
# gitlab_rails['redis_tls_ca_cert_file'] = '/opt/gitlab/embedded/ssl/certs/cacert.pem'
# gitlab_rails['redis_tls_client_cert_file'] = nil
# gitlab_rails['redis_tls_client_key_file'] = nil

### Gitlab Registry settings
registry['enable'] = true
registry_nginx['enable'] = false
registry_nginx['listen_https'] = false
registry_nginx['listen_port'] = 80
registry_external_url 'https://registry.git.your-domain.com'

gitlab_rails['registry_path'] = '/var/opt/gitlab/gitlab-rails/shared/registry'

gitlab_rails['registry_enabled'] = true
gitlab_rails['registry_api_url'] = 'http://gitlab-registry:5000'
gitlab_rails['registry_host'] = 'registry.git.your-domain.com'
gitlab_rails['registry_port'] = nil
gitlab_rails['registry_issuer'] = 'omnibus-gitlab-issuer'
gitlab_rails['registry_key_path'] = '/var/opt/gitlab/gitlab-rails/certificate.key'

registry['dir'] = '/var/opt/gitlab/registry'
registry['log_directory'] = '/var/log/gitlab/registry'
registry['log_directory'] = '/var/log/gitlab/registry'
registry['env_directory'] = '/opt/gitlab/etc/registry/env'
registry['env'] = {
	'SSL_CERT_DIR' => '/opt/gitlab/embedded/ssl/certs/'
}
registry['storage_delete_enabled'] = true
registry['validation_enabled'] = true
registry['autoredirect'] = false
registry['compatibility_schema1_enabled'] = true
registry['log_level'] = 'warn'
registry['log_formatter'] = 'text'

registry['gc'] = { 
  'disabled' => false,
  'maxbackoff' => '24h',
  'noidlebackoff' => false,
  'transactiontimeout' => '10s',
  'reviewafter' => '24h',
  'manifests' => {
      'disabled' => false,
      'interval' => '5s'
  },
  'blobs' => {
      'disabled' => false,
      'interval' => '5s',
      'storagetimeout' => '5s'
  }
}

# ---> LDAP
# gitlab_rails['ldap_enabled'] = false
# gitlab_rails['prevent_ldap_sign_in'] = false

# gitlab_rails['ldap_servers'] = YAML.load <<-'EOS'
#   main: # 'main' is the GitLab 'provider ID' of this LDAP server
#     label: 'LDAP'
#     host: 'ldap.your-domain.com'
#     port: 389
#     uid: 'uid'
#     bind_dn: 'uid=gitlab,ou=Users,o=org,dc=your-domain,dc=com'
#     password: ''
#     encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
# #     verify_certificates: true
# #     smartcard_auth: false
# #     active_directory: true
# #     smartcard_ad_cert_field: 'altSecurityIdentities'
# #     smartcard_ad_cert_format: null # 'issuer_and_serial_number', 'issuer_and_subject' , 'principal_name'
# #     allow_username_or_email_login: false
# #     lowercase_usernames: false
# #     block_auto_created_users: false
#     base: 'o=6172ed659cb77f5f544fed5d,dc=your-domain,dc=com'
# #     user_filter: ''
# #     ## EE only
# #     group_base: ''
# #     admin_group: ''
# #     sync_ssh_keys: false
# #
# #   secondary: # 'secondary' is the GitLab 'provider ID' of second LDAP server
# #     label: 'LDAP'
# #     host: '_your_ldap_server'
# #     port: 389
# #     uid: 'sAMAccountName'
# #     bind_dn: '_the_full_dn_of_the_user_you_will_bind_with'
# #     password: '_the_password_of_the_bind_user'
# #     encryption: 'plain' # "start_tls" or "simple_tls" or "plain"
# #     verify_certificates: true
# #     smartcard_auth: false
# #     active_directory: true
# #     smartcard_ad_cert_field: 'altSecurityIdentities'
# #     smartcard_ad_cert_format: null # 'issuer_and_serial_number', 'issuer_and_subject' , 'principal_name'
# #     allow_username_or_email_login: false
# #     lowercase_usernames: false
# #     block_auto_created_users: false
# #     base: ''
# #     user_filter: ''
# EOS
# <--- LDAP

# ---> OIDC
# gitlab_rails['omniauth_allow_single_sign_on'] = ['openid_connect']
# gitlab_rails['omniauth_sync_email_from_provider'] = 'openid_connect'
# gitlab_rails['omniauth_sync_profile_from_provider'] = ['openid_connect']
# gitlab_rails['omniauth_sync_profile_attributes'] = ['email']
# # gitlab_rails['omniauth_auto_sign_in_with_provider'] = 'openid_connect'
# gitlab_rails['omniauth_block_auto_created_users'] = false
# gitlab_rails['omniauth_auto_link_saml_user'] = true
# gitlab_rails['omniauth_auto_link_user'] = ["openid_connect"]
# gitlab_rails['omniauth_providers'] = [
#   {
#     name: 'openid_connect',
#     label: 'authentik',
#     args: {
#       name: 'openid_connect',
#       scope: ['openid','profile','email'],
#       response_type: 'code',
#       issuer: 'https://authentik.your-domain.com/application/o/gitlab/',
#       discovery: true,
#       client_auth_method: 'query',
#       uid_field: 'preferred_username',
#       send_scope_to_token_endpoint: 'true',
#       pkce: true,
#       client_options: {
#         identifier: '',
#         secret: '',
#         redirect_uri: 'https://git.your-domain.com/users/auth/openid_connect/callback'
#       }
#     }
#   }
# ]
# <--- OIDC


# ---> SMTP
### GitLab email server settings
# gitlab_rails['smtp_enable'] = true
# gitlab_rails['smtp_address'] = "smtp.your-domain.com"
# gitlab_rails['smtp_port'] = 587
# gitlab_rails['smtp_user_name'] = ""
# gitlab_rails['smtp_password'] = ""
# gitlab_rails['smtp_domain'] = "your-domain.com"
# gitlab_rails['smtp_authentication'] = "login"
# gitlab_rails['smtp_enable_starttls_auto'] = true
# gitlab_rails['smtp_tls'] = false
# gitlab_rails['smtp_pool'] = true

# gitlab_rails['gitlab_email_enabled'] = true

# gitlab_rails['gitlab_email_from'] = 'no-reply@your-domain.com'
# gitlab_rails['gitlab_email_display_name'] = 'Gitlab'
# gitlab_rails['gitlab_email_reply_to'] = 'no-reply@your-domain.com'
# <--- SMTP
