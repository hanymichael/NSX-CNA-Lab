FROM gcr.io/spinnaker-marketplace/clouddriver:1.0.0-20171108151529
COPY ca.pem /etc/kubernetes/ssl/
COPY ca.crt /etc/kubernetes/ssl/

COPY ca.crt /
RUN keytool -importcert -keypass changeit -file /ca.crt -keystore /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/cacerts -noprompt -storepass changeit
