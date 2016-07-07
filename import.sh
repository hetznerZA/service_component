export SERVICE_COMPONENT=service_component
export SOAR_DIR=../soar_sc
export SERVICE_COMPONENT_DIR=$(pwd)
cd $SERVICE_COMPONENT_DIR/tfa/jewels/$SERVICE_COMPONENT
zip -rq ../$SERVICE_COMPONENT.zip *
cd $SERVICE_COMPONENT_DIR
cp tfa/jewels/*.zip $SOAR_DIR/jewels
cd $SOAR_DIR
jewels/inject_jewel.sh $SERVICE_COMPONENT
cd $SERVICE_COMPONENT_DIR
