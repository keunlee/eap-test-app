# dockerfile to build image for JBoss EAP 7.1

#start from eap71-openshift
FROM registry.redhat.io/jboss-eap-7/eap73-openjdk8-openshift-rhel7

# Copy war to deployments folder
COPY target/kitchensink.war $JBOSS_HOME/standalone/deployments/ROOT.war

# User root to modify war owners
USER root

# Modify owners war
RUN chown jboss:jboss $JBOSS_HOME/standalone/deployments/ROOT.war

# Important, use jboss user to run image
USER jboss

CMD ["/opt/eap/bin/openshift-launch.sh"]