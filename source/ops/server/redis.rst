.. _redis:

Redis
==========

基础配置
---------------

.. code:: yaml

  version: '3'

  services:
    redis:
      image: redis:7.0
      command: redis-server /usr/local/etc/redis/redis.conf
      restart: always
      ports:
        - 6379:6379
      volumes:
        - ./redis.conf:/usr/local/etc/redis/redis.conf
        - ./data:/data
