# ms_ldap
FROM osixia/openldap

#ENV LDAP_ORGANISATION="MPI CEC"
ENV LDAP_DOMAIN=mpicec.local
ENV LDAP_ADMIN_PASSWORD=test1234

# copy ldif info to dir
RUN mkdir -p /container/service/slapd/assets/config/bootstrap/ldif/
COPY bootstrap.ldif /container/service/slapd/assets/config/bootstrap/ldif/50-bootstrap.ldif
