Systemctl 示例
==============

命令
-----------

.. note:: 

   ubuntu: /etc/systemd/system/

.. code:: shell

   # 打开服务
   systemctl start <服务名称>

   # 关闭服务
   systemctl stop <服务名称>

   # 查看服务状态
   systemctl status <服务名称>

   # 启用服务
   sudo systemctl enable <服务名称>


rpc
-----------

- 服务端

  .. code:: shell

     [Unit]
     Description=Frp Server Service
     After=network.target

     [Service]
     Type=simple
     User=nobody
     Restart=on-failure
     RestartSec=5s
     ExecStart=/usr/bin/frps -c /etc/frp/frps.ini
     LimitNOFILE=1048576

     [Install]
     WantedBy=multi-user.target

- 客户端

  .. code:: shell
     
     [Unit]
     Description=Frp Client Service
     After=network.target

     [Service]
     Type=simple
     User=nobody
     Restart=on-failure
     RestartSec=5s
     ExecStart=/usr/bin/frpc -c /etc/frp/frpc.ini
     ExecReload=/usr/bin/frpc reload -c /etc/frp/frpc.ini
     LimitNOFILE=1048576

     [Install]
     WantedBy=multi-user.target

- 命令
  
  .. code:: shell

     sudo cp ./frp.service /etc/systemd/system/
     sudo systemctl enable frp.service
     sudo systemctl start frp.service




