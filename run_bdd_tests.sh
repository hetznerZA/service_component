#!/bin/bash
source ~/.rvm/scripts/rvm

#This script must be run from the parent folder of the soar_sc, service_component repo folders
export BASE_DIR=$(pwd)

export SOAR_DIR=../soar_sc
export SERVICE_COMPONENT_DIR=$BASE_DIR

echo "Cleaning all repos involved in testing in preparation for jewel injection"
cd $SOAR_DIR && git checkout . && git clean -fdx
#cd $SERVICE_COMPONENT_DIR && git checkout . && git clean -fdx

echo "Import jewels related to audit related testing"
cd $SERVICE_COMPONENT_DIR && ./import.sh service_component
cd $SERVICE_COMPONENT_DIR && ./import.sh policy_is_anyone
cd $SERVICE_COMPONENT_DIR && ./import.sh service_registry_tests

echo "Starting keep_running of soar_sc"
cd $SOAR_DIR
git checkout config/config.yml
cp config/environment.yml.example config/environment.yml
export SOAR_TECH=rackup
export RACK_ENV=production
./soar_tech.sh
rvm use . && gem install bundler && bundle

./keep_running.sh > /dev/null 2>&1 &
export KEEP_RUNNING_PID=$!

echo "Running service component BDD tests"
cd $SERVICE_COMPONENT_DIR
rvm use . && gem install bundler && bundle

COUNTER=0
TEST_EXIT_CODE=1
echo $TEST_EXIT_CODE
while [  $COUNTER -lt 3 ] && [ $TEST_EXIT_CODE -ne "0" ]; do
   let COUNTER=COUNTER+1
   echo "--- Cucumber Test iteration $COUNTER START ---"
   if [ $COUNTER -eq "1" ]; then
     TEST_ORCHESTRATION_PROVIDER=tfa bundle exec cucumber --format pretty --format rerun --out .cucumber_failed_tests features/*
   else
     TEST_ORCHESTRATION_PROVIDER=tfa bundle exec cucumber --format pretty --format rerun --out .cucumber_failed_tests -q @.cucumber_tests_to_run
   fi
   TEST_EXIT_CODE=$?
   cp .cucumber_failed_tests .cucumber_tests_to_run
   echo "--- Cucumber Test iteration $COUNTER END ---"
done

TEST_EXIT_CODE=$?

echo "Stopping keep_running script and soar_sc service instance"
kill $KEEP_RUNNING_PID
$SOAR_DIR/stop.sh

echo "Exiting with status code $TEST_EXIT_CODE"
cd $BASE_DIR
exit $TEST_EXIT_CODE
