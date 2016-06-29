#!/bin/bash

export SOAR_DIR=/soar_testing/soar_sc
export SERVICE_COMPONENT_DIR=/soar_testing/service_component

echo "Starting keep_running of soar_sc"
cd $SOAR_DIR
export SOAR_TECH=rackup
export RACK_ENV=development
./soar_tech.sh
rvm use . && gem install bundle && bundle
./keep_running.sh > /dev/null 2>&1 &

echo "Running service component BDD tests"
cd $SERVICE_COMPONENT_DIR
rvm use . && gem install bundle && bundle
TEST_ORCHESTRATION_PROVIDER=tfa bundle exec cucumber features/bootstrap_with_audit* features/bootstrap_with_service_identifier.feature features/auditing_*
