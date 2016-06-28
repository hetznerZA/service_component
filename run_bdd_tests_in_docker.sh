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

# echo "Installing ruby and gems of SOAR_SC"
# cd $SOAR_DIR
# rvm use jruby-9.0.4.0
# gem install bundle
# bundle install
#
#
# echo "Installing ruby and gems of service_component"
# cd $SERVICE_COMPONENT_DIR
# rvm use ruby-2.3.0
# gem install bundle
# bundle install


echo "Starting keep_running of soar_sc"
cd $SOAR_DIR
rvm use jruby-9.0.4.0
cd ..
cd $SOAR_DIR
export SOAR_TECH=rackup
export RACK_ENV=development
./soar_tech.sh
rvm use jruby-9.0.4.0
gem install bundle
bundle install
./keep_running.sh > /dev/null 2>&1 &

echo "Running service component BDD tests"
cd $SERVICE_COMPONENT_DIR
rvm use ruby-2.3.0
cd ..
cd $SERVICE_COMPONENT_DIR
rvm use ruby-2.3.0
gem install bundle
bundle install
export TEST_ORCHESTRATION_PROVIDER=tfa
bundle exec cucumber features/bootstrap_with_audit* features/bootstrap_with_service_identifier.feature features/auditing_*
