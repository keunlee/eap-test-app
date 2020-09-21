for resource in \
	eap-xp1-basic-s2i.json \
	eap-xp1-third-party-db-s2i.json
do
	oc replace --force -f https://raw.githubusercontent.com/jboss-container-images/jboss-eap-openshift-templates/eap-xp1/templates/${resource}
done
