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

   # 查看日志
   journalctl -u <服务名称> -f

   # 重新加载配置文件
   sudo systemctl daemon-reload

使用过程中遇到的问题
-----------------------

- 问题1, 在 ``arm ubuntu 2004`` 版本中, 将可执行文件放在 ``/root/work`` 目录中,出现 ``status=203/EXEC`` 最终将可执行文件放在 ``/usr/bin`` 目录中,配置文件放在 ``/etc/app/`` ,问题解决

- 问题2, 在 ``arm ubuntu 2004`` 版本中, ``user=nobody`` , 出现无法打开 ``/dev/ttysWk0`` ,最终将 ``user=root`` ,问题解决.


frp
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

