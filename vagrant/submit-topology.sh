#!/bin/bash

RELEASE=`grep -1 -A 0 -B 0 '<version>' /vagrant/pom.xml | head -n 1 | awk '{print $1}' | sed -e 's/.*<version>//' | sed -e 's/<\/version>.*//'`
STORM_RELEASE=${STORM_RELEASE:-`grep -1 -A 0 -B 0 '<storm.default.version>' /vagrant/pom.xml | head -n 1 | awk '{print $1}' | sed -e 's/.*<storm.default.version>//' | sed -e 's/<\/storm.default.version>.*//'`}
MESOS_RELEASE=${MESOS_RELEASE:-`grep -1 -A 0 -B 0 '<mesos.default.version>' /vagrant/pom.xml | head -n 1 | awk '{print $1}' | sed -e 's/.*<mesos.default.version>//' | sed -e 's/<\/mesos.default.version>.*//'`}
CLASSIFIER=storm${STORM_RELEASE}-mesos${MESOS_RELEASE}

cd /vagrant/_release/storm-mesos-${RELEASE}-${CLASSIFIER}
bin/storm jar /vagrant/vagrant/$*
