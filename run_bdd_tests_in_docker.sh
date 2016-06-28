#!/bin/bash

export SOAR_DIR=/soar_testing/soar_sc
export SERVICE_COMPONENT_DIR=/soar_testing/service_component
export AUDIT_TEST_SERVICE_DIR=/soar_testing/soar_audit_test_service

echo "Injecting Audit test service jewel"
cd $AUDIT_TEST_SERVICE_DIR
export TEST_SERVICE=soar_audit_test_service
cd $AUDIT_TEST_SERVICE_DIR/tfa/jewels/$TEST_SERVICE
zip -rq ../$TEST_SERVICE.zip *
cd $AUDIT_TEST_SERVICE_DIR
cp tfa/jewels/*.zip $SOAR_DIR/jewels
cd $SOAR_DIR
jewels/inject_jewel.sh $TEST_SERVICE

echo "Starting keep_running of soar_sc"
cd $SOAR_DIR
export SOAR_TECH=rackup
export RACK_ENV=development
./soar_tech.sh
rvm use . && gem install bundle && bundle
./keep_running.sh > /dev/null 2>&1 &

echo "Sleeping for 10 seconds to ensure soar_sc starts up the first time before tests are run"
sleep 10

echo "Running service component BDD tests"
cd $SERVICE_COMPONENT_DIR
rvm use . && gem install bundle && bundle
TEST_ORCHESTRATION_PROVIDER=tfa bundle exec cucumber features/bootstrap_with_audit* features/bootstrap_with_service_identifier.feature features/auditing_*
