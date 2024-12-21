# configure minio

docker run -rm minio/mc:latest /bin/sh -c "
      /usr/bin/mc config host rm local;
      /usr/bin/mc alias set minio http://minio:9000 minio minio123;
      /usr/bin/mc admin config set minio identity_ldap server_addr='ldap_server:389' tls_skip_verify='on' server_insecure='on' lookup_bind_dn='cn=admin,dc=mpicec,dc=local' lookup_bind_password='test1234' user_dn_search_base_dn='dc=mpicec,dc=local' user_dn_search_filter='(&(objectClass=posixAccount)(uid=%s))' group_search_filter='(&(objectClass=posixAccount)(uid=%s))' group_search_base_dn='dc=mpicec,dc=local' ;
      /usr/bin/mc admin service restart minio;
      /usr/bin/mc admin policy set minio consoleAdmin user='cn=minioadmin,dc=mpicec,dc=local';
      /usr/bin/mc admin policy set minio readwrite,diagnostics user='cn=testuser,ou=users,dc=mpicec,dc=local';
      exit 0;
      "
