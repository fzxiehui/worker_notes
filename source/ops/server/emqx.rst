EMQx
======

docker-compose
--------------------


.. code:: yaml

  version: '3'

  services:
    emq:
      image: emqx/emqx:5.0.3
      restart: always
      container_name: emqx-docker
      # network_mode: docker-net
      privileged: true
      volumes:
        - ./conf:/opt/emqx/etc
        - ./data:/opt/emqx/data
          #      - ./logs:/opt/emqx/log
      ports:
        # MQTT 协议端口
        - 1883:1883
        # MQTT/SSL 端口
        - 8883:8883
        # MQTT/WebSocket 端口
        - 9083:8083
        # MQTT/WebSocket/SSL 端口
        - 8084:8084
        # 管理 API 端口
        - 8081:8081
        # Dashboard 端口
        - 18083:18083

