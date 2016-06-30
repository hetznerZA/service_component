#!/bin/bash

#This script must be run from the parent folder of the soar_sc, service_component repo folders
export BASE_DIR=$(pwd)

export SOAR_DIR=$BASE_DIR/soar_sc
export SERVICE_COMPONENT_DIR=$BASE_DIR/service_component

echo "Cleaning all repos involved in testing in preparation for jewel injection"
cd $BASE_DIR/soar_sc && git checkout . && git clean -fdx
#cd $BASE_DIR/service_component && git checkout . && git clean -fdx
#cd $BASE_DIR/soar_audit_test_service && git checkout . && git clean -fdx

echo "Import soar_audit_test_service to audit related testing"
cd $BASE_DIR/soar_audit_test_service && ./import.sh

echo "Starting keep_running of soar_sc"
cd $SOAR_DIR
cp config/environment.yml.example config/environment.yml
export SOAR_TECH=rackup
export RACK_ENV=development
./soar_tech.sh
rvm use . && bundle

./keep_running.sh > /dev/null 2>&1 &
export KEEP_RUNNING_PID=$!

echo "Running service component BDD tests"
cd $SERVICE_COMPONENT_DIR
rvm use . && gem install bundler && bundle
TEST_ORCHESTRATION_PROVIDER=tfa bundle exec cucumber features/bootstrap_with_audit* features/bootstrap_with_service_identifier.feature features/auditing_*
TEST_EXIT_CODE=$?

echo "Stopping keep_running script and soar_sc service instance"
kill $KEEP_RUNNING_PID
$SOAR_DIR/stop.sh

echo "Cleanly exit"
cd $BASE_DIR
exit $TEST_EXIT_CODE
