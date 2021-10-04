#!/usr/bin/env bashio
set -e

export WATCHED_METERS=$(bashio::config 'WATCHED_METERS|join(",")')
export WH_MULTIPLIER=$(bashio::config 'WH_MULTIPLIER')
export READINGS_PER_HOUR=$(bashio::config 'READINGS_PER_HOUR')
export MQTT_HOST=$(bashio::services mqtt 'host')
export MQTT_PORT="1883"
export MQTT_USER=$(bashio::services mqtt 'username')
export MQTT_PASSWORD=$(bashio::services mqtt 'password')
export DEBUG=$(bashio::config 'DEBUG')

exec /amridm2mqtt/amridm2mqtt
