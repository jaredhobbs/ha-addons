# Home Assistant Add-on: AMRIDM2MQTT add-on

## How to use

By default, this addon will watch all utility meters it can pick up.
To limit to only your own meters, add the meter id to the `WATCHED_METERS`
configuration.

Make sure to toggle on "Start on boot" and "Watchdog" then start the addon.

The addon will start collecting data and saving it to the
`readings/<meter id>/meter_reading` mqtt topic.

IDM readings will also store meter rate to the
`readings/<meter id>/meter_rate` mqtt topic.

### Finding your meter id

The meter id is usually printed on the actual utility meter. You may need
to turn on `DEBUG: '1'` in the configuration and watch the logs to find your
meter id.

## Creating sensors from meter data

You can create HA sensors from the meter data like this:

```yaml
# configuration.yaml
sensor: !include sensor.yaml

# sensor.yaml
- platform: mqtt
  state_topic: "readings/<meter id>/meter_reading"
  unique_id: "readings/<meter id>/meter_reading"
  name: "Power Meter"
  unit_of_measurement: kWh
  last_reset_value_template: 1970-01-01T00:00:00+00:00
  value_template: "{{ (value | float) / 100 | round(2) }}"
  state_class: total_increasing
  device_class: energy

- platform: mqtt
  state_topic: "readings/<meter id>/meter_rate"
  unique_id: "readings/<meter id>/meter_rate"
  name: "Power Meter Avg Usage 5 mins"
  unit_of_measurement: W
  value_template: "{{ (value | float) / 100 | round(2) }}"
```

You can also create a template sensor that calculates the current
electricity rate based on your provider's rates. Here's what it looks like
for me:

```yaml
# configuration.yaml
sensor: !include sensor.yaml
utility_meter: !include utility_meter.yaml
template:
  - sensor:
      - name: "Current Electricity Rate"
        unit_of_measurement: "USD/kWh"
        device_class: monetary
        unique_id: sensor.current_electicity_rate
        # https://www.rockymountainpower.net/about/rates-regulation/utah-rates-tariffs.html
        state: >
            {% set today = states('sensor.date').split('-') %}
            {% set month = today[1]|int %}
            {% set monthly_energy = states('sensor.monthly_energy') | float %}
            {% if month in [10, 11, 12, 1, 2, 3, 4, 5] %}
              {% if monthly_energy <= 400 %}
                0.082126
              {% else %}
                0.105959
              {% endif %}
            {% else %}
              {% if monthly_energy <= 400 %}
                0.092802
              {% else %}
                0.119733
              {% endif %}
            {% endif %}

# sensor.yaml
- platform: time_date
  display_options:
    - 'date'
    - 'time'

# utility_meter.yaml
hourly_energy:
  source: sensor.power_meter
  name: Hourly Energy
  cycle: hourly
daily_energy:
  source: sensor.power_meter
  name: Daily Energy
  cycle: daily
monthly_energy:
  source: sensor.power_meter
  name: Monthly Energy
  cycle: monthly
```

## Configuring HA Energy monitoring

With the sensors set up and the radio logging data, you should now be able
to setup HA Energy monitoring. Go to `Configuration->Energy` and setup
Grid consumption. If your config looks like mine above, you should be
able to add `sensor.power_meter` under `Consumed Energy (kWh)` and
`sensor.current_electricity_rate` under `Use an entity with current price`.
