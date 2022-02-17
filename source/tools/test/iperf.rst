iperf吞吐测试工具
=================

常用命令
--------

- 服务端

.. code:: shell

  # tcp
  iperf -s -i 1 -p 5001

  # udp
  iperf -u -s -i 1 -p 5001


- 客户端

.. code:: shell

  # tcp 
  iperf -c 192.168.1.2 -i 1 -b 10M -t 60

  # udp 
  iperf -u -c 192.168.1.2 -i -b 10M -t 60
