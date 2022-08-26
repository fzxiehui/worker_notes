MySqld
======

docker-compose
---------------

.. code:: yaml

    version: '3'
    services:
      mysql:
        image: mysql:5.7
        ports:
          - '3306:3306'
        volumes:
          - ./data:/var/lib/mysql
        environment:
          MYSQL_ROOT_PASSWORD: root
          MYSQL_DATABASE: test
          MYSQL_USER: test
          MYSQL_PASSWORD: test
          MYSQL_ALLOW_EMPTY_PASSWORD: yes
        restart: always
        # depends_on:
        #   - redis
        command: mysqld --default-time-zone=Asia/Shanghai
          
