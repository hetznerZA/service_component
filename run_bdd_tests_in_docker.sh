#!/bin/bash


export SOAR_DIR=$(pwd)/soar_sc
export SERVICE_COMPONENT_DIR=$(pwd)/service_component

'rvm install ruby-2.3.0'
'rvm install jruby-9.0.4.0'

echo "Installing ruby and gems of SOAR_SC"
cd $SOAR_DIR
rvm use .
bundle install

echo "Installing ruby and gems of service_component"
cd $SERVICE_COMPONENT_DIR
rvm use .
bundle install


echo "Starting keep_running of soar_sc"
cd $SOAR_DIR
./keep_running.sh &

echo "Running service component BDD tests"
cd $SERVICE_COMPONENT_DIR
bundle exec TEST_ORCHESTRATION_PROVIDER=tfa bundle exec cucumber features/bootstrap_with_audit* features/bootstrap_with_service_identifier.feature features/auditing_*


